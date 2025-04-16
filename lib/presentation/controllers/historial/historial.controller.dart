import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:app_guias/providers/guia.provider.dart';
import 'package:app_guias/providers/auth.provider.dart';
import 'package:app_guias/models/guia.dart';
import 'package:path_provider/path_provider.dart';
import 'package:app_guias/services/log/logger.service.dart';
import 'package:app_guias/presentation/widgets/modals/procesando.modal.dart';
import 'package:app_guias/presentation/widgets/modals/resultado.modal.dart';

class GuideFile {
  final String fileName;
  final String fullPath;
  final DateTime creationDate;
  final FileSystemEntityType type;
  final String extension;
  final bool isPdf;
  final bool isCsv;

  // Información extraída del nombre (para archivos SUNAT)
  final String? ruc;
  final String? tipoDocumento;
  final String? serieCorrelativo;
  final String? usernameUsuario;

  GuideFile({
    required this.fileName,
    required this.fullPath,
    required this.creationDate,
    required this.type,
    required this.extension,
    required this.isPdf,
    required this.isCsv,
    this.ruc,
    this.tipoDocumento,
    this.serieCorrelativo,
    this.usernameUsuario,
  });

  // Métodos para extraer información del nombre del archivo
  static GuideFile fromFile(FileSystemEntity entity) {
    final File file = File(entity.path);
    final String fileName = path.basename(file.path);
    final String extension = path.extension(file.path).toLowerCase();
    final DateTime creationDate = file.statSync().changed;

    // Determinar tipo de archivo
    final bool isPdf = extension == '.pdf';
    final bool isCsv = extension == '.csv';

    // Intentar extraer información del nombre si sigue el formato SUNAT
    // Formato esperado: <RUC>-<TipoDoc>-<Serie>-<Correlativo>.<ext>
    // Ejemplo: 20132377783-09-T002-00000603.pdf
    String? ruc;
    String? tipoDocumento;
    String? serieCorrelativo;

    final RegExp guiaRegExp = RegExp(r'^(\d+)-(\d+)-([A-Z0-9]+-\d+)\..*$');
    final match = guiaRegExp.firstMatch(fileName);

    if (match != null && match.groupCount >= 3) {
      ruc = match.group(1);
      tipoDocumento = match.group(2);
      serieCorrelativo = match.group(3);
    }

    return GuideFile(
      fileName: fileName,
      fullPath: file.path,
      creationDate: creationDate,
      type: FileSystemEntity.typeSync(file.path),
      extension: extension,
      isPdf: isPdf,
      isCsv: isCsv,
      ruc: ruc,
      tipoDocumento: tipoDocumento,
      serieCorrelativo: serieCorrelativo,
      usernameUsuario: null,
    );
  }

  // Método para crear un GuideFile a partir de un objeto Guia del backend
  static GuideFile fromGuia(Guia guia) {
    final serieCorrelativoMatch =
        RegExp(r'([A-Z0-9]+-\d+)').firstMatch(guia.nombre);
    final serieCorrelativo = serieCorrelativoMatch?.group(1);

    return GuideFile(
      fileName: guia.nombre,
      fullPath: '', // No tenemos path físico para archivos del backend
      creationDate: guia.fechaSubida,
      type: FileSystemEntityType.file,
      extension: '.pdf', // Asumimos que todos son PDF
      isPdf: true,
      isCsv: false,
      ruc: null, // No tenemos esta información
      tipoDocumento: null, // No tenemos esta información
      serieCorrelativo: serieCorrelativo,
      usernameUsuario: guia.usuario,
    );
  }
}

class HistorialController extends ChangeNotifier {
  final List<GuideFile> _archivosPdf = [];
  final List<GuideFile> _archivosPdfLocales = [];
  List<GuideFile> _archivosCsv = [];
  bool _isLoading = false;
  String _errorMessage = '';
  late GuiaProvider _guiaProvider;
  late AuthProvider _authProvider;
  bool _mounted = true;

  // Variables para controlar acciones en progreso
  bool _isProcessingAction = false;
  bool _isSharing = false;
  bool _isUploading = false;
  String? _sharingFileId;
  String? _uploadingFileId;

  // Variables para controlar el estado de carga por tipo de archivo
  bool _isLoadingPagePDF = false;
  bool _isLoadingPageCSV = false;

  // Variables para búsqueda y filtrado
  String _searchText = '';
  List<GuideFile> _filteredPdfFiles = [];
  List<GuideFile> _filteredCsvFiles = [];

  final TextEditingController searchController = TextEditingController();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Getters
  List<GuideFile> get archivosPdf => _archivosPdf;
  List<GuideFile> get archivosCsv => _archivosCsv;
  List<GuideFile> get archivosPdfLocales => _archivosPdfLocales;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get isAdmin => _authProvider.role == 'ADMINISTRADOR';
  bool get mounted => _mounted;
  bool get isProcessingAction =>
      _isProcessingAction || _isSharing || _isUploading;
  bool get isLoadingPagePDF => _isLoadingPagePDF;
  bool get isLoadingPageCSV => _isLoadingPageCSV;
  bool get isSharing => _isSharing;
  bool get isUploading => _isUploading;
  String? get sharingFileId => _sharingFileId;
  String? get uploadingFileId => _uploadingFileId;
  String get searchText => _searchText;
  List<GuideFile> get filteredPdfFiles => _filteredPdfFiles;
  List<GuideFile> get filteredCsvFiles => _filteredCsvFiles;

  // Para compatibilidad con código existente
  bool get isLoadingPage => _isLoadingPagePDF;

  @override
  void dispose() {
    searchController.dispose();
    _mounted = false;
    super.dispose();
  }

  void initialize(BuildContext context) {
    if (!context.mounted || !_mounted) return;

    _guiaProvider = Provider.of<GuiaProvider>(context, listen: false);
    _authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Determinar si el usuario es administrador
    final isAdmin = _authProvider.role == 'ADMINISTRADOR';
    // Determinar si es desktop
    final isDesktop = MediaQuery.of(context).size.width > 600;

    // Establecer estados de carga para mostrar Shimmer
    _isLoadingPagePDF = true;
    _isLoadingPageCSV = true;
    notifyListeners();

    // Cargar las guías apropiadas según el rol y plataforma
    cargarArchivos(isAdmin: isAdmin || isDesktop);
  }

  Future<void> cargarArchivos({bool isAdmin = false}) async {
    if (!_mounted) {
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    // Establecer estados de carga para mostrar Shimmer
    _isLoadingPagePDF = true;
    _isLoadingPageCSV = true;
    notifyListeners();

    try {
      _archivosPdf.clear();
      _archivosPdfLocales.clear();

      // Cargar archivos CSV locales (siempre se cargan independientemente del rol)
      await _cargarArchivosCsvLocales();

      // Cargar archivos PDF locales
      await _cargarArchivosPdfLocales();

      // Cargar guías del backend según el rol de usuario
      if (isAdmin) {
        // Administrador: cargar todas las guías
        await _guiaProvider.loadGuias(all: true);
      } else {
        // Usuario normal: cargar solo sus guías
        final userId = _authProvider.userId;
        if (userId != null) {
          await _guiaProvider.loadGuiasByUsuario(userId, all: true);
        }
      }

      if (!_mounted) {
        return;
      }
      // Convertir las guías del backend en objetos GuideFile y agregarlos
      _archivosPdf.addAll(
          _guiaProvider.guias.map((guia) => GuideFile.fromGuia(guia)).toList());

      // Ordenar por fecha de creación (más reciente primero)
      _archivosPdf.sort((a, b) => b.creationDate.compareTo(a.creationDate));

      // Después de haber obtenido y ordenado los archivos, inicializar las listas filtradas
      _applyFilters();
    } catch (e) {
      if (!_mounted) {
        return;
      }
      _errorMessage = 'Error al cargar las guías: ${e.toString()}';
    } finally {
      if (_mounted) {
        _isLoading = false;
        _isLoadingPagePDF = false;
        _isLoadingPageCSV = false;
        notifyListeners();
      }
    }
  }

  // Añadir función auxiliar para obtener el directorio de guías según la plataforma
  Future<Directory> getGuiasDirectory() async {
    try {
      if (Platform.isAndroid) {
        // En Android mantener la ruta original en Downloads
        return Directory('/storage/emulated/0/Download/Guias');
      } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        // En escritorio, usar ApplicationDocuments
        final appDocDir = await getApplicationDocumentsDirectory();
        final guiasDir = Directory('${appDocDir.path}/Guias');
        if (!await guiasDir.exists()) {
          await guiasDir.create(recursive: true);
        }
        return guiasDir;
      } else {
        // Para otras plataformas, usar un directorio temporal
        final tempDir = await getTemporaryDirectory();
        final guiasDir = Directory('${tempDir.path}/Guias');
        if (!await guiasDir.exists()) {
          await guiasDir.create(recursive: true);
        }
        return guiasDir;
      }
    } catch (e) {
      LoggerService.error('Error al obtener directorio de guías: $e');
      // En caso de error, usar un directorio temporal como fallback
      final tempDir = await getTemporaryDirectory();
      final fallbackDir = Directory('${tempDir.path}/Guias');
      if (!await fallbackDir.exists()) {
        await fallbackDir.create(recursive: true);
      }
      return fallbackDir;
    }
  }

  // Método para cargar los archivos CSV locales (simplificado sin paginación)
  Future<void> _cargarArchivosCsvLocales() async {
    try {
      final Directory directory = await getGuiasDirectory();

      if (!await directory.exists()) {
        await directory.create(recursive: true);
        _archivosCsv = [];
        return;
      }

      final List<GuideFile> tempCsv = [];

      await for (final FileSystemEntity entity in directory.list()) {
        try {
          final GuideFile archivo = GuideFile.fromFile(entity);
          if (archivo.isCsv) {
            tempCsv.add(archivo);
          }
        } catch (e) {
          LoggerService.error('Error al procesar archivo CSV local: $e');
        }
      }
      // Ordenar por fecha de creación (más reciente primero)
      tempCsv.sort((a, b) => b.creationDate.compareTo(a.creationDate));
      _archivosCsv = tempCsv;
    } catch (e) {
      LoggerService.error('Error al cargar archivos CSV: $e');
      _archivosCsv = [];
    }
  }

  Future<void> _cargarArchivosPdfLocales() async {
    try {
      // Obtener directorio de guías
      final Directory guiasDir = await getGuiasDirectory();

      if (!await guiasDir.exists()) {
        await guiasDir.create(recursive: true);
        return;
      }

      final List<GuideFile> tempFiles = [];

      // Limpiar la lista antes de cargar
      _archivosPdfLocales.clear();

      // Listar archivos en el directorio
      await for (final FileSystemEntity entity in guiasDir.list()) {
        try {
          // Solo procesar archivos que existan y sean PDF
          if (entity is File &&
              await entity.exists() &&
              path.extension(entity.path).toLowerCase() == '.pdf') {
            final GuideFile archivo = GuideFile.fromFile(entity);
            tempFiles.add(archivo);
          }
        } catch (e) {
          LoggerService.error('Error al procesar archivo local: $e');
        }
      }

      // Ordenar por fecha de creación (más reciente primero)
      tempFiles.sort((a, b) => b.creationDate.compareTo(a.creationDate));

      // Asignar a la lista de PDFs locales
      _archivosPdfLocales.addAll(tempFiles);
    } catch (e) {
      LoggerService.error('Error al cargar archivos PDF locales: $e');
    }
  }

  Future<bool> abrirArchivo(GuideFile archivo) async {
    // Si ya estamos procesando una acción, ignorar
    if (_isProcessingAction) return false;

    _isProcessingAction = true;
    notifyListeners();

    try {
      // Si es un archivo local (tiene ruta completa)
      if (archivo.fullPath.isNotEmpty &&
          await File(archivo.fullPath).exists()) {
        LoggerService.info('Abriendo archivo local: ${archivo.fullPath}');
        final result = await OpenFile.open(archivo.fullPath);
        if (result.type != ResultType.done) {
          _errorMessage =
              'No se pudo abrir el archivo local: ${result.message}';
          LoggerService.warning(_errorMessage);
          notifyListeners();
          return false;
        }
        return true;
      }
      // Si es un archivo del backend (no tiene ruta completa)
      else {
        LoggerService.info(
            'Intentando abrir archivo del backend: ${archivo.fileName}');
        Guia? guiaEncontrada;
        try {
          // Buscar guía correspondiente en el provider
          guiaEncontrada = _guiaProvider.guias.firstWhere((guia) =>
              archivo.fileName.contains(guia.nombre) ||
              guia.nombre.contains(archivo.fileName));
        } catch (e) {
          guiaEncontrada = _guiaProvider.guias.firstWhereOrNull((guia) =>
              archivo.fileName.contains(guia.nombre) ||
              guia.nombre.contains(archivo.fileName));
          LoggerService.warning(
              'Guía no encontrada por nombre exacto, buscando parcialmente...');
        }

        if (guiaEncontrada == null) {
          _errorMessage =
              'No se encontró la guía correspondiente en el servidor.';
          LoggerService.error(_errorMessage);
          notifyListeners();
          return false;
        }

        LoggerService.info(
            'Guía encontrada (${guiaEncontrada.id}). Descargando...');
        // Descargar el archivo
        final bytes = await _guiaProvider.downloadGuia(guiaEncontrada.id);
        if (bytes == null) {
          _errorMessage = 'No se pudo descargar la guía ${guiaEncontrada.id}.';
          LoggerService.error(_errorMessage);
          notifyListeners();
          return false;
        }
        LoggerService.info(
            'Guía ${guiaEncontrada.id} descargada (${bytes.lengthInBytes} bytes). Guardando en temporal...');

        try {
          // Usar el directorio temporal según la plataforma
          final Directory tempDir = await getTemporaryDirectory();
          final String tempFilePath = path.join(tempDir.path, archivo.fileName);
          final File tempFile = File(tempFilePath);

          await tempFile.writeAsBytes(bytes);
          LoggerService.info('Archivo temporal guardado en: ${tempFile.path}');

          // Abrir el archivo temporal
          final result = await OpenFile.open(tempFilePath);
          if (result.type != ResultType.done) {
            _errorMessage =
                'No se pudo abrir el archivo descargado: ${result.message}';
            LoggerService.warning(_errorMessage);
            notifyListeners();
            return false;
          }
        } catch (fileError) {
          _errorMessage =
              'Error al guardar o abrir el archivo temporal: $fileError';
          LoggerService.error(_errorMessage);
          notifyListeners();
          return false;
        }
      }
    } catch (e) {
      _errorMessage = 'Error general al intentar abrir el archivo: $e';
      LoggerService.error(_errorMessage);
      notifyListeners();
      return false;
    } finally {
      _isProcessingAction = false;
      notifyListeners();
    }
    return true;
  }

  // Para compatibilidad con la vista y asegurar limpieza completa (sin paginación)
  Future<void> cargarArchivosPDF({bool isAdmin = false}) async {
    if (!_mounted) return;

    _isLoadingPagePDF = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Limpiar las listas antes de cargar nuevos archivos
      _archivosPdf.clear();
      _archivosPdfLocales.clear();

      // Cargar archivos PDF locales
      await _cargarArchivosPdfLocales();

      // Determinar si es desktop de manera segura
      bool isDesktop = false;
      try {
        final context = navigatorKey.currentContext;
        if (context != null) {
          isDesktop = MediaQuery.of(context).size.width > 600;
        }
      } catch (e) {
        LoggerService.warning('No se pudo determinar si es desktop: $e');
      }

      // Cargar guías del backend según el rol de usuario y plataforma
      if (isAdmin || isDesktop) {
        // Administrador o Desktop: cargar todas las guías
        await _guiaProvider.loadGuias(all: true);
      } else {
        // Usuario normal en móvil: cargar solo sus guías
        final userId = _authProvider.userId;
        if (userId != null) {
          await _guiaProvider.loadGuiasByUsuario(userId, all: true);
        }
      }

      if (!_mounted) return;

      // Convertir las guías del backend en objetos GuideFile y agregarlos
      _archivosPdf.addAll(
          _guiaProvider.guias.map((guia) => GuideFile.fromGuia(guia)).toList());

      // Ordenar por fecha de creación (más reciente primero)
      _archivosPdf.sort((a, b) => b.creationDate.compareTo(a.creationDate));

      // Aplicar filtros y actualizar la vista
      _applyFilters();
    } catch (e) {
      if (!_mounted) return;
      _errorMessage = 'Error al cargar los archivos PDF: ${e.toString()}';
      LoggerService.error(_errorMessage);
    } finally {
      if (_mounted) {
        _isLoadingPagePDF = false;
        notifyListeners();
      }
    }
  }

  // Método para compartir archivos
  Future<bool> compartirArchivo(GuideFile archivo) async {
    try {
      _isSharing = true;
      _sharingFileId =
          archivo.fullPath.isNotEmpty ? archivo.fullPath : archivo.fileName;
      _errorMessage = '';
      notifyListeners();

      // Si es un archivo local (tiene ruta completa)
      if (archivo.fullPath.isNotEmpty) {
        final file = XFile(archivo.fullPath);
        final result = await Share.shareXFiles(
          [file],
          text: 'Compartir ${archivo.fileName}',
          subject: archivo.fileName,
        );

        _isSharing = false;
        _sharingFileId = null;
        notifyListeners();
        return result.status == ShareResultStatus.success ||
            result.status == ShareResultStatus.dismissed;
      }
      // Si es un archivo del backend (no tiene ruta completa)
      else {
        Guia? guiaEncontrada;
        try {
          // Intentamos buscar primero por nombre exacto
          guiaEncontrada = _guiaProvider.guias.firstWhere(
            (guia) => guia.nombre == archivo.fileName,
            orElse: () => throw Exception('Nombre exacto no encontrado'),
          );
        } catch (e) {
          // Si no encontramos por nombre exacto, buscamos por nombre parcial
          for (var guia in _guiaProvider.guias) {
            if (archivo.fileName.contains(guia.nombre) ||
                guia.nombre.contains(archivo.fileName)) {
              guiaEncontrada = guia;
              break;
            }
          }

          // Si aún no encontramos, usamos el primer elemento como fallback
          if (guiaEncontrada == null && _guiaProvider.guias.isNotEmpty) {
            guiaEncontrada = _guiaProvider.guias.first;
          }
        }

        if (guiaEncontrada == null) {
          _errorMessage = 'No se encontró la guía en el servidor';
          _isSharing = false;
          _sharingFileId = null;
          notifyListeners();
          return false;
        }

        // Descargar el archivo
        final bytes = await _guiaProvider.downloadGuia(guiaEncontrada.id);
        if (bytes == null) {
          _errorMessage = 'No se pudo descargar la guía';
          _isSharing = false;
          _sharingFileId = null;
          notifyListeners();
          return false;
        }

        try {
          // Guardar temporalmente para compartir
          final directory = await getGuiasDirectory();
          final tempDir = Directory('${directory.path}/temp');
          if (!await tempDir.exists()) {
            await tempDir.create(recursive: true);
          }

          final tempFile = File('${tempDir.path}/${archivo.fileName}');
          await tempFile.writeAsBytes(bytes);

          // Compartir el archivo usando XFile
          final file = XFile(tempFile.path);
          final result = await Share.shareXFiles(
            [file],
            text: 'Compartir ${archivo.fileName}',
            subject: archivo.fileName,
          );

          _isSharing = false;
          _sharingFileId = null;
          notifyListeners();
          return result.status == ShareResultStatus.success ||
              result.status == ShareResultStatus.dismissed;
        } catch (fileError) {
          // Si falla compartir como archivo, intentar compartir solo el texto
          try {
            await Share.share(
              'Archivo: ${archivo.fileName}',
              subject: 'Compartir guía',
            );

            _isSharing = false;
            _sharingFileId = null;
            notifyListeners();
            return true;
          } catch (textShareError) {
            _errorMessage = 'Error al compartir el archivo: $fileError';
            _isSharing = false;
            _sharingFileId = null;
            notifyListeners();
            return false;
          }
        }
      }
    } catch (e) {
      _errorMessage = 'No se pudo compartir el archivo: $e';
      _isSharing = false;
      _sharingFileId = null;
      notifyListeners();

      // Si falla todo lo anterior, intentar compartir solo como texto
      try {
        await Share.share(
          'Archivo: ${archivo.fileName}',
          subject: 'Compartir guía',
        );
        return true;
      } catch (_) {
        return false;
      }
    }
  }

  // Método simplificado para cargar archivos CSV (sin paginación)
  Future<void> cargarArchivosCSV({bool isAdmin = false}) async {
    if (!_mounted) return;

    _isLoadingPageCSV = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await _cargarArchivosCsvLocales();

      // Aplicar filtros
      _filteredCsvFiles = _filterFiles(_archivosCsv);
    } catch (e) {
      if (!_mounted) return;
      _errorMessage = 'Error al cargar los archivos CSV: ${e.toString()}';
    } finally {
      if (_mounted) {
        _isLoadingPageCSV = false;
        notifyListeners();
      }
    }
  }

  // Método para verificar si un archivo específico se está compartiendo
  bool isSharingFile(GuideFile file) {
    return _isSharing &&
        (_sharingFileId == file.fullPath || _sharingFileId == file.fileName);
  }

  // Método para verificar si un archivo específico se está subiendo
  bool isUploadingFile(GuideFile file) {
    return _isUploading &&
        (_uploadingFileId == file.fullPath ||
            _uploadingFileId == file.fileName);
  }

  // Función para buscar/filtrar guías
  void searchGuias(String value) {
    _searchText = value;
    _applyFilters();
  }

  // Método para limpiar todos los filtros
  void clearFilters() {
    _searchText = '';
    searchController.clear();
    _applyFilters();
  }

  // Aplicar todos los filtros actuales
  void _applyFilters() {
    // Filtrar archivos locales y del servidor por separado
    final filteredLocalPdfs = _filterFiles(_archivosPdfLocales);
    final filteredServerPdfs = _filterFiles(_archivosPdf);

    // Combinar las listas con los archivos locales primero
    _filteredPdfFiles = [...filteredLocalPdfs, ...filteredServerPdfs];

    // Filtrar archivos CSV
    _filteredCsvFiles = _filterFiles(_archivosCsv);
    notifyListeners();
  }

  // Método para filtrar archivos según los criterios actuales
  List<GuideFile> _filterFiles(List<GuideFile> files) {
    if (_searchText.isEmpty) {
      return List.from(files);
    }

    final searchLower = _searchText.toLowerCase();
    return files.where((file) {
      return file.fileName.toLowerCase().contains(searchLower) ||
          (file.serieCorrelativo?.toLowerCase().contains(searchLower) ??
              false) ||
          (file.usernameUsuario?.toLowerCase().contains(searchLower) ?? false);
    }).toList();
  }

  // Método para subir un archivo PDF local al servidor
  Future<bool> subirArchivoLocal(GuideFile archivo) async {
    _isUploading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Verificar si el archivo existe
      final file = File(archivo.fullPath);
      if (!await file.exists()) {
        _errorMessage = 'El archivo no existe en la ruta: ${archivo.fullPath}';
        _isUploading = false;
        notifyListeners();
        return false;
      }

      // Verificar si el usuario está autenticado
      final userId = _authProvider.userId;
      if (userId == null) {
        _errorMessage = 'Usuario no autenticado';
        _isUploading = false;
        notifyListeners();
        return false;
      }

      // Leer el archivo como bytes
      final bytes = await file.readAsBytes();

      // Subir el archivo al backend
      final response = await _guiaProvider.uploadGuia(
        archivo.fileName,
        bytes,
        userId,
      );

      // Si la respuesta es exitosa
      if (response != null) {
        LoggerService.info(
            'Guía subida exitosamente: ${response.id} - ${response.nombre}');

        // Eliminar el archivo local después de la subida exitosa
        _eliminarArchivoLocal(archivo);

        // Recargar la lista de archivos
        _cargarArchivosLocales();
        _cargarGuiasDesdeBackend();
        return true;
      } else {
        // Verificar si el error es porque la guía ya existe
        final errorMsg = _guiaProvider.error?.toLowerCase() ?? '';

        // Verificar si es un error 500 (que puede indicar guía duplicada en el servidor)
        if (errorMsg.contains('código: 500') ||
            errorMsg.contains('error interno del servidor') ||
            errorMsg.contains('ya existe') ||
            errorMsg.contains('already exists') ||
            errorMsg.contains('duplicate')) {
          LoggerService.info(
              'Detectado posible error de guía duplicada: $errorMsg');
          _errorMessage =
              'Esta guía ya existe en el servidor, se eliminará de forma local.';

          // Como posiblemente ya existe en el servidor, eliminamos el archivo local
          _eliminarArchivoLocal(archivo);

          // Recargar solo la lista de archivos locales
          //_cargarArchivosLocales();
          await cargarArchivos(isAdmin: isAdmin);
        } else {
          _errorMessage =
              'Error del servidor al subir ${archivo.fileName}: ${_guiaProvider.error}';
        }
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error al subir el archivo ${archivo.fileName}: $e';
      LoggerService.error(_errorMessage);
      return false;
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }

  // Método para restaurar el estado anterior de los archivos (para uso en manejo de errores UI)
  void restoreFilesState(List<GuideFile> pdfFiles, List<GuideFile> csvFiles) {
    // Restaurar las listas filtradas
    _filteredPdfFiles = pdfFiles;
    _filteredCsvFiles = csvFiles;
    notifyListeners();
  }

  // Método para limpiar el mensaje de error
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // Método para verificar si hay error específico de guía ya existente
  bool get isGuiaExistsError {
    final errorMsg = _errorMessage.toLowerCase();
    return errorMsg.contains('ya existe en el servidor') ||
        errorMsg.contains('código: 500') ||
        errorMsg.contains('error interno del servidor');
  }

  // Método para obtener el mensaje de error y limpiarlo
  String getErrorAndClear() {
    final error = _errorMessage;
    _errorMessage = '';
    return error;
  }

  // Método privado para eliminar archivos locales
  Future<void> _eliminarArchivoLocal(GuideFile archivo) async {
    try {
      final file = File(archivo.fullPath);
      if (await file.exists()) {
        await file.delete();
        LoggerService.info(
            'Archivo local eliminado después de subir al servidor: ${archivo.fullPath}');

        // Eliminar el archivo de la lista local antes de recargar
        _archivosPdfLocales.removeWhere((a) => a.fullPath == archivo.fullPath);
      }
    } catch (deleteError) {
      LoggerService.warning(
          'No se pudo eliminar el archivo local después de subirlo: $deleteError');
    }

    // Esperar un momento para asegurar que los cambios del sistema de archivos se reflejen
    await Future.delayed(const Duration(milliseconds: 200));
  }

  // Método privado para cargar archivos locales
  Future<void> _cargarArchivosLocales() async {
    try {
      // Obtener directorio de guías
      final Directory guiasDir = await getGuiasDirectory();

      if (!await guiasDir.exists()) {
        await guiasDir.create(recursive: true);
        return;
      }

      final List<GuideFile> tempFiles = [];

      // Limpiar la lista antes de cargar
      _archivosPdfLocales.clear();

      // Listar archivos en el directorio
      await for (final FileSystemEntity entity in guiasDir.list()) {
        try {
          // Solo procesar archivos que existan y sean PDF
          if (entity is File &&
              await entity.exists() &&
              path.extension(entity.path).toLowerCase() == '.pdf') {
            final GuideFile archivo = GuideFile.fromFile(entity);
            tempFiles.add(archivo);
          }
        } catch (e) {
          LoggerService.error('Error al procesar archivo local: $e');
        }
      }

      // Ordenar por fecha de creación (más reciente primero)
      tempFiles.sort((a, b) => b.creationDate.compareTo(a.creationDate));

      // Asignar a la lista de PDFs locales
      _archivosPdfLocales.addAll(tempFiles);
    } catch (e) {
      LoggerService.error('Error al cargar archivos PDF locales: $e');
    }
  }

  // Método privado para cargar guías desde el backend
  Future<void> _cargarGuiasDesdeBackend() async {
    try {
      // Determinar si es desktop
      final isDesktop =
          MediaQuery.of(navigatorKey.currentContext!).size.width > 600;

      // Cargar guías del backend según el rol de usuario y plataforma
      if (isAdmin || isDesktop) {
        // Administrador o Desktop: cargar todas las guías
        await _guiaProvider.loadGuias(all: true);
      } else {
        // Usuario normal en móvil: cargar solo sus guías
        final userId = _authProvider.userId;
        if (userId != null) {
          await _guiaProvider.loadGuiasByUsuario(userId, all: true);
        }
      }

      if (!_mounted) {
        return;
      }
      // Convertir las guías del backend en objetos GuideFile y agregarlos
      _archivosPdf.addAll(
          _guiaProvider.guias.map((guia) => GuideFile.fromGuia(guia)).toList());

      // Ordenar por fecha de creación (más reciente primero)
      _archivosPdf.sort((a, b) => b.creationDate.compareTo(a.creationDate));

      // Después de haber obtenido y ordenado los archivos, inicializar las listas filtradas
      _applyFilters();
    } catch (e) {
      if (!_mounted) {
        return;
      }
      _errorMessage = 'Error al cargar las guías: ${e.toString()}';
    }
  }

  // Método simplificado para subir archivo con modal, siguiendo exactamente el patrón de NewGuideController
  Future<bool> subirArchivoConModal(
      BuildContext context, GuideFile archivo) async {
    LoggerService.info(
        'Iniciando subida de archivo con modal: ${archivo.fileName}');

    if (!context.mounted) {
      LoggerService.warning(
          'Contexto no montado al iniciar subirArchivoConModal');
      return false;
    }

    // Guardar referencia al contexto original y navigator
    final NavigatorState navigator = Navigator.of(context, rootNavigator: true);
    // Guardar una referencia adicional del contexto global para usar después
    final BuildContext originalContext = context;

    // Mostrar modal de procesamiento (exactamente como NewGuideController)
    ProcesandoModal.show(
      context,
      title: 'Subiendo guía',
      message: 'Subiendo archivo al servidor...',
    );

    try {
      LoggerService.info(
          'Modal mostrado, procesando archivo: ${archivo.fileName}');

      // Subir el archivo
      final success = await subirArchivoLocal(archivo);

      LoggerService.info(
          'Subida ${success ? "exitosa" : "fallida"}, cerrando modal...');

      // Cerrar modal usando el navigator guardado
      try {
        if (navigator.mounted) {
          navigator.pop();
          LoggerService.info(
              'Modal cerrado correctamente usando navigator global');
        } else if (context.mounted) {
          Navigator.of(context).pop();
          LoggerService.info('Modal cerrado correctamente usando context');
        } else {
          LoggerService.warning(
              'Contexto no montado al intentar cerrar modal, usando timer de seguridad');
          // No podemos cerrar el modal aquí, se manejará con un timer
        }
      } catch (navError) {
        LoggerService.error('Error al intentar cerrar el modal: $navError');
      }

      // Verificar si es un error de guía duplicada (hacer esto antes de verificar el contexto)
      final bool esGuiaDuplicada = !success && isGuiaExistsError;

      if (esGuiaDuplicada) {
        LoggerService.info(
            'Guía duplicada detectada, eliminando archivo local');

        // Eliminar archivo y actualizar lista - esto debe hacerse independientemente del contexto
        await _eliminarArchivoLocal(archivo);
        await cargarArchivos(isAdmin: isAdmin);
      }

      // Esperar un momento para asegurar que el Navigator se estabilice
      await Future.delayed(const Duration(milliseconds: 500));

      // Buscar un contexto válido para mostrar modales
      BuildContext? contextToUse;
      if (originalContext.mounted) {
        contextToUse = originalContext;
        LoggerService.info('Usando contexto original para mostrar modal');
      } else {
        // Intentar usar el contexto del navigatorKey global
        contextToUse = navigatorKey.currentContext;
        LoggerService.info('Intentando usar contexto global del navigatorKey');
      }

      // Si el contexto ya no está montado, intentar obtener uno nuevo
      if (contextToUse == null || !contextToUse.mounted) {
        LoggerService.warning(
            'No se encontró un contexto válido para mostrar modal');

        try {
          // Si tenemos el navigatorKey y está montado, usamos su contexto actual
          if (navigator.mounted) {
            contextToUse = navigator.context;
            LoggerService.info(
                'Usando contexto del navigator global para mostrar modal');
          }
        } catch (e) {
          LoggerService.error(
              'Error al intentar acceder al contexto del navigator: $e');
        }
      }

      // Si aún no tenemos un contexto válido, regresamos el resultado
      if (contextToUse == null || !contextToUse.mounted) {
        LoggerService.warning(
            'No se pudo encontrar un contexto válido para mostrar cualquier tipo de modal');
        return success || esGuiaDuplicada;
      }

      // Mostrar el modal adecuado según el resultado
      if (success) {
        // Actualizar la lista
        await cargarArchivos(isAdmin: isAdmin);

        // Mostrar éxito
        await ResultadoModal.showSuccess(
          contextToUse,
          title: 'Éxito',
          message: 'Archivo subido exitosamente',
        );
        return true;
      } else if (esGuiaDuplicada) {
        // Ya hemos eliminado el archivo y actualizado la lista arriba

        LoggerService.info('Mostrando modal de advertencia de guía duplicada');
        // Mostrar advertencia
        await ResultadoModal.showWarning(
          contextToUse,
          title: 'Guía ya registrada',
          message:
              'Esta guía ya existe en el servidor y se ha eliminado de su dispositivo.',
          details: [
            const Text(
                'La guía detectada ya se encuentra registrada en el servidor.'),
            const SizedBox(height: 8),
            const Text(
                'El archivo local ha sido eliminado para evitar duplicados.'),
          ],
        );
        return true;
      } else {
        //final errorMsg = getErrorAndClear();

        // Mostrar error
        await ResultadoModal.showError(
          contextToUse,
          title: 'Advertencia',
          message:
              'El archivo ya existe en el servidor, se eliminó de su dispositivo.',
          //details: [Text(errorMsg)],
        );
        return false;
      }
    } catch (e) {
      LoggerService.error('Excepción en subirArchivoConModal: $e');

      // Cerrar modal usando el navigator guardado para mayor seguridad
      try {
        if (navigator.mounted) {
          navigator.pop();
          LoggerService.info(
              'Modal cerrado después de excepción usando navigator global');
        } else if (context.mounted) {
          Navigator.of(context).pop();
          LoggerService.info('Modal cerrado después de excepción');
        } else {
          LoggerService.warning(
              'No se pudo cerrar el modal después de la excepción');
        }
      } catch (navError) {
        LoggerService.error(
            'Error al intentar cerrar el modal después de excepción: $navError');
      }

      // Esperar un momento para asegurar que el Navigator se estabilice
      await Future.delayed(const Duration(milliseconds: 500));

      // Buscar un contexto válido para mostrar el modal de error
      BuildContext? contextForError;
      if (originalContext.mounted) {
        contextForError = originalContext;
      } else {
        contextForError = navigatorKey.currentContext;
      }

      if (contextForError != null && contextForError.mounted) {
        // Mostrar error
        await ResultadoModal.showError(
          contextForError,
          title: 'Error',
          message: 'Ocurrió un error inesperado',
          details: [Text(e.toString())],
        );
      } else {
        LoggerService.error(
            'No se pudo mostrar el modal de error: no hay contexto disponible');
      }

      return false;
    }
  }
}

extension FirstWhereExt<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
