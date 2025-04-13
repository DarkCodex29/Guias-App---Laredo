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
  List<GuideFile> _archivosCsv =
      []; // Dejamos esta lista para mantener compatibilidad
  bool _isLoading = false;
  String _errorMessage = '';
  late GuiaProvider _guiaProvider;
  late AuthProvider _authProvider;
  bool _mounted =
      true; // Variable para controlar si el controlador está montado

  // Variable para controlar acciones en progreso y evitar doble click
  bool _isProcessingAction = false;

  // Getters
  List<GuideFile> get archivosPdf => _archivosPdf;
  List<GuideFile> get archivosCsv => _archivosCsv;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get isAdmin => _authProvider.role == 'ADMINISTRADOR';
  bool get mounted => _mounted;
  bool get isProcessingAction => _isProcessingAction;

  // Variables para controlar el estado de carga por tipo de archivo
  bool _isLoadingPagePDF = false;
  bool _isLoadingPageCSV = false;
  bool _isSharing = false;
  String? _sharingFileId; // Identificador del archivo que se está compartiendo
  bool get isLoadingPagePDF => _isLoadingPagePDF;
  bool get isLoadingPageCSV => _isLoadingPageCSV;
  bool get isSharing => _isSharing;
  String? get sharingFileId => _sharingFileId;

  // Para compatibilidad con código existente
  bool get isLoadingPage => _isLoadingPagePDF;

  // Variables para búsqueda y filtrado
  String _searchText = '';
  List<GuideFile> _filteredPdfFiles = [];
  List<GuideFile> _filteredCsvFiles = [];

  // Getters para búsqueda y filtrado
  String get searchText => _searchText;
  List<GuideFile> get filteredPdfFiles => _filteredPdfFiles;
  List<GuideFile> get filteredCsvFiles => _filteredCsvFiles;

  final TextEditingController searchController = TextEditingController();

  List<GuideFile> get archivosPdfLocales => _archivosPdfLocales;

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

    // Establecer estados de carga para mostrar Shimmer
    _isLoadingPagePDF = true;
    _isLoadingPageCSV = true;
    notifyListeners();

    // Cargar las guías apropiadas según el rol
    cargarArchivos(isAdmin: isAdmin);
  }

  Future<void> cargarArchivos({bool isAdmin = false}) async {
    if (!_mounted) {
      return;
    }

    _isLoading = true;
    _errorMessage = '';
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

      // Listar archivos en el directorio
      await for (final FileSystemEntity entity in guiasDir.list()) {
        try {
          if (entity is File &&
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
    if (!_isSharing) return false;
    return _sharingFileId == file.fullPath || _sharingFileId == file.fileName;
  }

  // Función para buscar/filtrar guías
  void searchGuias(String value) {
    _searchText = value;

    // Filtrar archivos del servidor
    final serverPdfFiles = _archivosPdf.where((file) {
      return file.fileName.toLowerCase().contains(value.toLowerCase()) ||
          (file.serieCorrelativo?.toLowerCase().contains(value.toLowerCase()) ??
              false) ||
          (file.usernameUsuario?.toLowerCase().contains(value.toLowerCase()) ??
              false);
    }).toList();

    // Filtrar archivos locales
    final localPdfFiles = _archivosPdfLocales.where((file) {
      return file.fileName.toLowerCase().contains(value.toLowerCase()) ||
          (file.serieCorrelativo?.toLowerCase().contains(value.toLowerCase()) ??
              false);
    }).toList();

    // Combinar ambas listas manteniendo los locales primero
    _filteredPdfFiles = [...localPdfFiles, ...serverPdfFiles];

    // Filtrar archivos CSV
    _filteredCsvFiles = _archivosCsv.where((file) {
      return file.fileName.toLowerCase().contains(value.toLowerCase()) ||
          (file.serieCorrelativo?.toLowerCase().contains(value.toLowerCase()) ??
              false);
    }).toList();

    notifyListeners();
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

    return files.where((file) {
      // Filtrar por texto de búsqueda
      return file.fileName.toLowerCase().contains(_searchText.toLowerCase()) ||
          (file.serieCorrelativo != null &&
              file.serieCorrelativo!
                  .toLowerCase()
                  .contains(_searchText.toLowerCase())) ||
          (file.usernameUsuario != null &&
              file.usernameUsuario!
                  .toLowerCase()
                  .contains(_searchText.toLowerCase()));
    }).toList();
  }

  // Método para subir un archivo PDF local al servidor
  Future<bool> subirArchivoLocal(GuideFile archivo) async {
    _isSharing = true;
    _sharingFileId = archivo.fullPath;
    notifyListeners();

    try {
      // Verificar que el archivo existe
      final file = File(archivo.fullPath);
      if (!await file.exists()) {
        _errorMessage = 'El archivo no existe';
        return false;
      }

      // Leer el archivo como bytes
      final bytes = await file.readAsBytes();

      // Llamar al provider para subir el archivo
      final userId = _authProvider.userId;
      if (userId == null) {
        _errorMessage = 'Usuario no autenticado';
        return false;
      }

      // El método uploadGuia devuelve un Guia? (puede ser nulo)
      final guia = await _guiaProvider.uploadGuia(
        archivo.fileName,
        bytes,
        userId.toString(),
      );

      if (guia != null) {
        // Si la subida fue exitosa, eliminar el archivo local
        try {
          if (await file.exists()) {
            await file.delete();
            LoggerService.info(
                'Archivo local eliminado después de subir al servidor: ${archivo.fullPath}');
          }
        } catch (deleteError) {
          LoggerService.warning(
              'No se pudo eliminar el archivo local después de subirlo: $deleteError');
        }
        await cargarArchivosPDF(isAdmin: isAdmin);
        return true;
      } else {
        _errorMessage = _guiaProvider.error ?? 'Error al subir el archivo';
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error al subir el archivo: $e';
      return false;
    } finally {
      _isSharing = false;
      _sharingFileId = null;
      notifyListeners();
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
