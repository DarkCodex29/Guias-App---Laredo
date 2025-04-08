import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:app_guias/providers/guia.provider.dart';
import 'package:app_guias/providers/auth.provider.dart';
import 'package:app_guias/models/guia.dart';

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
  List<GuideFile> _archivosCsv =
      []; // Dejamos esta lista para mantener compatibilidad
  bool _isLoading = false;
  String _errorMessage = '';
  late GuiaProvider _guiaProvider;
  late AuthProvider _authProvider;
  bool _mounted =
      true; // Variable para controlar si el controlador está montado

  // Getters
  List<GuideFile> get archivosPdf => _archivosPdf;
  List<GuideFile> get archivosCsv => _archivosCsv;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get isAdmin => _authProvider.role == 'ADMINISTRADOR';
  bool get mounted => _mounted;

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

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  void initialize(BuildContext context) {
    // Verificar que el componente sigue montado
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
      return; // Verificar si el controlador sigue montado
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Limpiar la lista antes de cargar nuevos archivos
      _archivosPdf.clear();

      // Cargar archivos CSV locales (siempre se cargan independientemente del rol)
      await _cargarArchivosCsvLocales();

      // Cargar guías del backend según el rol de usuario
      if (isAdmin) {
        // Administrador: cargar todas las guías
        await _guiaProvider.loadGuias();
      } else {
        // Usuario normal: cargar solo sus guías
        final userId = _authProvider.userId;
        if (userId != null) {
          await _guiaProvider.loadGuiasByUsuario(userId);
        }
      }

      if (!_mounted) {
        return; // Verificar nuevamente después de operaciones asíncronas
      }

      // Convertir las guías del backend en objetos GuideFile y agregarlos
      _archivosPdf.addAll(
          _guiaProvider.guias.map((guia) => GuideFile.fromGuia(guia)).toList());

      // Ordenar por fecha de creación (más reciente primero)
      _archivosPdf.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    } catch (e) {
      if (!_mounted) {
        return; // Verificar antes de actualizar el estado de error
      }
      _errorMessage = 'Error al cargar las guías: ${e.toString()}';
    } finally {
      if (_mounted) {
        // Solo notificar si seguimos montados
        _isLoading = false;
        _isLoadingPagePDF = false;
        _isLoadingPageCSV = false;
        notifyListeners();
      }
    }
  }

  // Método para cargar los archivos CSV locales (mantenemos esta funcionalidad)
  Future<void> _cargarArchivosCsvLocales() async {
    try {
      final Directory directory =
          Directory('/storage/emulated/0/Download/Guias');

      if (!await directory.exists()) {
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
          // Ignoramos errores de archivos individuales para que el proceso continúe
          // con los demás archivos que sí se pueden procesar
        }
      }
      // Ordenar por fecha de creación (más reciente primero)
      tempCsv.sort((a, b) => b.creationDate.compareTo(a.creationDate));
      _archivosCsv = tempCsv;

      // Actualizar el total de páginas para CSV
      final totalItems = _archivosCsv.length;
      final pageSize = 10; // Tamaño de página fijo para CSV
      final totalPages = (totalItems / pageSize).ceil();
      _guiaProvider.setTotalPagesCSV(totalPages);

      // Si hay archivos, calcular la página actual
      if (totalItems > 0) {
        final startIndex = (_guiaProvider.currentPageCSV - 1) * pageSize;
        final endIndex = startIndex + pageSize;

        if (startIndex < _archivosCsv.length) {
          _archivosCsv = _archivosCsv.sublist(startIndex,
              endIndex > _archivosCsv.length ? _archivosCsv.length : endIndex);
        } else {
          // Si el índice de inicio está fuera de rango, ir a la última página
          final lastPage = totalPages;
          await _guiaProvider.goToPageCSV(lastPage);
          final lastPageStartIndex = (lastPage - 1) * pageSize;
          final lastPageEndIndex = lastPageStartIndex + pageSize;
          _archivosCsv = _archivosCsv.sublist(
              lastPageStartIndex,
              lastPageEndIndex > _archivosCsv.length
                  ? _archivosCsv.length
                  : lastPageEndIndex);
        }
      }
    } catch (e) {
      _archivosCsv = [];
    }
  }

  Future<bool> abrirArchivo(GuideFile archivo) async {
    try {
      // Si es un archivo local (tiene ruta completa)
      if (archivo.fullPath.isNotEmpty) {
        final result = await OpenFile.open(archivo.fullPath);
        return result.type == ResultType.done;
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
          notifyListeners();
          return false;
        }

        // Descargar el archivo
        final bytes = await _guiaProvider.downloadGuia(guiaEncontrada.id);
        if (bytes == null) {
          _errorMessage = 'No se pudo descargar la guía';
          notifyListeners();
          return false;
        }

        try {
          // Guardar temporalmente y abrir
          final tempDir = Directory('/storage/emulated/0/Download/Guias/temp');
          if (!await tempDir.exists()) {
            await tempDir.create(recursive: true);
          }

          final tempFile = File('${tempDir.path}/${archivo.fileName}');
          await tempFile.writeAsBytes(bytes);

          final result = await OpenFile.open(tempFile.path);
          return result.type == ResultType.done;
        } catch (fileError) {
          _errorMessage = 'Error al abrir el archivo descargado: $fileError';
          notifyListeners();
          return false;
        }
      }
    } catch (e) {
      _errorMessage = 'No se pudo abrir el archivo: $e';
      notifyListeners();
      return false;
    }
  }

  // Métodos para paginación PDF
  Future<void> nextPagePDF() async {
    if (!_mounted) return;

    if (_guiaProvider.currentPagePDF < _guiaProvider.totalPagesPDF) {
      _isLoadingPagePDF = true;
      notifyListeners();

      try {
        await _guiaProvider.nextPagePDF();
        await _cargarArchivosPDFSinLimpiar();
      } catch (e) {
        _errorMessage =
            'Error al cargar la siguiente página PDF: ${e.toString()}';
      } finally {
        if (_mounted) {
          _isLoadingPagePDF = false;
          notifyListeners();
        }
      }
    }
  }

  Future<void> previousPagePDF() async {
    if (!_mounted) return;

    if (_guiaProvider.currentPagePDF > 1) {
      _isLoadingPagePDF = true;
      notifyListeners();

      try {
        await _guiaProvider.previousPagePDF();
        await _cargarArchivosPDFSinLimpiar();
      } catch (e) {
        _errorMessage =
            'Error al cargar la página anterior PDF: ${e.toString()}';
      } finally {
        if (_mounted) {
          _isLoadingPagePDF = false;
          notifyListeners();
        }
      }
    }
  }

  Future<void> goToPagePDF(int page) async {
    if (!_mounted) return;

    if (page >= 1 &&
        page <= _guiaProvider.totalPagesPDF &&
        page != _guiaProvider.currentPagePDF) {
      _isLoadingPagePDF = true;
      notifyListeners();

      try {
        await _guiaProvider.goToPagePDF(page);
        await _cargarArchivosPDFSinLimpiar();
      } catch (e) {
        _errorMessage = 'Error al cargar la página $page PDF: ${e.toString()}';
      } finally {
        if (_mounted) {
          _isLoadingPagePDF = false;
          notifyListeners();
        }
      }
    }
  }

  // Método para cargar archivos PDF sin limpiar la lista actual
  Future<void> _cargarArchivosPDFSinLimpiar() async {
    if (!_mounted) return;

    _isLoadingPagePDF = true;
    notifyListeners();

    try {
      final authProvider = _authProvider;
      final isAdmin = authProvider.role == 'ADMINISTRADOR';

      // Cargar archivos PDF desde el backend
      if (isAdmin) {
        // Administrador: cargar todas las guías
        await _guiaProvider.loadGuias(page: _guiaProvider.currentPagePDF);
      } else {
        // Usuario normal: cargar solo sus guías
        final userId = _authProvider.userId;
        if (userId != null) {
          await _guiaProvider.loadGuiasByUsuario(userId,
              page: _guiaProvider.currentPagePDF);
        }
      }

      if (!_mounted) return;

      // Actualizar la lista de archivos PDF
      _archivosPdf.clear();
      _archivosPdf.addAll(
          _guiaProvider.guias.map((guia) => GuideFile.fromGuia(guia)).toList());

      // Ordenar por fecha de creación (más reciente primero)
      _archivosPdf.sort((a, b) => b.creationDate.compareTo(a.creationDate));

      _isLoadingPagePDF = false;
      notifyListeners();
    } catch (e) {
      if (!_mounted) return;
      _errorMessage = 'Error al cargar los archivos PDF: ${e.toString()}';
      _isLoadingPagePDF = false;
      notifyListeners();
    }
  }

  // Métodos para paginación CSV
  Future<void> nextPageCSV() async {
    if (!_mounted) return;

    if (_guiaProvider.currentPageCSV < _guiaProvider.totalPagesCSV) {
      _isLoadingPageCSV = true;
      notifyListeners();

      try {
        await _guiaProvider.nextPageCSV();
        await _cargarArchivosCSVSinLimpiar();
      } catch (e) {
        _errorMessage =
            'Error al cargar la siguiente página CSV: ${e.toString()}';
      } finally {
        if (_mounted) {
          _isLoadingPageCSV = false;
          notifyListeners();
        }
      }
    }
  }

  Future<void> previousPageCSV() async {
    if (!_mounted) return;

    if (_guiaProvider.currentPageCSV > 1) {
      _isLoadingPageCSV = true;
      notifyListeners();

      try {
        await _guiaProvider.previousPageCSV();
        await _cargarArchivosCSVSinLimpiar();
      } catch (e) {
        _errorMessage =
            'Error al cargar la página anterior CSV: ${e.toString()}';
      } finally {
        if (_mounted) {
          _isLoadingPageCSV = false;
          notifyListeners();
        }
      }
    }
  }

  Future<void> goToPageCSV(int page) async {
    if (!_mounted) return;

    if (page >= 1 &&
        page <= _guiaProvider.totalPagesCSV &&
        page != _guiaProvider.currentPageCSV) {
      _isLoadingPageCSV = true;
      notifyListeners();

      try {
        await _guiaProvider.goToPageCSV(page);
        await _cargarArchivosCSVSinLimpiar();
      } catch (e) {
        _errorMessage = 'Error al cargar la página $page CSV: ${e.toString()}';
      } finally {
        if (_mounted) {
          _isLoadingPageCSV = false;
          notifyListeners();
        }
      }
    }
  }

  // Método para cargar archivos CSV sin limpiar la lista actual
  Future<void> _cargarArchivosCSVSinLimpiar() async {
    if (!_mounted) return;

    _isLoadingPageCSV = true;
    notifyListeners();

    try {
      // Cargar archivos CSV locales
      final directory = Directory('/storage/emulated/0/Download/Guias');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
        _archivosCsv = [];
        _guiaProvider.setTotalPagesCSV(0);
        _isLoadingPageCSV = false;
        notifyListeners();
        return;
      }

      // Obtener lista de archivos de manera asíncrona
      final files = await directory.list().toList();
      final csvFiles = files
          .where((file) =>
              file is File &&
              file.path.toLowerCase().endsWith('.csv') &&
              file.statSync().type == FileSystemEntityType.file)
          .map((file) => GuideFile.fromFile(file))
          .toList();

      // Ordenar por fecha de creación (más reciente primero)
      csvFiles.sort((a, b) => b.creationDate.compareTo(a.creationDate));

      // Calcular el total de páginas
      final totalItems = csvFiles.length;
      final pageSize = 10; // Tamaño de página fijo para CSV
      final totalPages = (totalItems / pageSize).ceil();

      // Actualizar el total de páginas en el provider
      _guiaProvider.setTotalPagesCSV(totalPages);

      // Si no hay archivos, asegurarse de que la página actual sea 1
      if (totalItems == 0) {
        _archivosCsv = [];
        _isLoadingPageCSV = false;
        notifyListeners();
        return;
      }

      // Calcular el índice de inicio y fin para la página actual
      final startIndex = (_guiaProvider.currentPageCSV - 1) * pageSize;
      final endIndex = startIndex + pageSize;

      // Actualizar la lista de archivos CSV
      if (startIndex < csvFiles.length) {
        _archivosCsv = csvFiles.sublist(startIndex,
            endIndex > csvFiles.length ? csvFiles.length : endIndex);
      } else {
        // Si el índice de inicio está fuera de rango, ir a la última página
        final lastPage = totalPages;
        await _guiaProvider.goToPageCSV(lastPage);
        final lastPageStartIndex = (lastPage - 1) * pageSize;
        final lastPageEndIndex = lastPageStartIndex + pageSize;
        _archivosCsv = csvFiles.sublist(
            lastPageStartIndex,
            lastPageEndIndex > csvFiles.length
                ? csvFiles.length
                : lastPageEndIndex);
      }

      _isLoadingPageCSV = false;
      notifyListeners();
    } catch (e) {
      if (!_mounted) return;
      _errorMessage = 'Error al cargar los archivos CSV: ${e.toString()}';
      _isLoadingPageCSV = false;
      notifyListeners();
    }
  }

  // Para compatibilidad con la vista
  Future<void> cargarArchivosPDF({bool isAdmin = false}) async {
    return cargarArchivos(isAdmin: isAdmin);
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
          final tempDir = Directory('/storage/emulated/0/Download/Guias/temp');
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

  Future<void> cargarArchivosCSV({bool isAdmin = false}) async {
    if (!_mounted) return;

    _isLoadingPageCSV = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Cargar archivos CSV locales
      final directory = Directory('/storage/emulated/0/Download/Guias');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
        _archivosCsv = [];
        _guiaProvider.setTotalPagesCSV(0);
        _isLoadingPageCSV = false;
        notifyListeners();
        return;
      }

      // Obtener lista de archivos de manera asíncrona
      final files = await directory.list().toList();
      final csvFiles = files
          .where((file) =>
              file is File &&
              file.path.toLowerCase().endsWith('.csv') &&
              file.statSync().type == FileSystemEntityType.file)
          .map((file) => GuideFile.fromFile(file))
          .toList();

      // Ordenar por fecha de creación (más reciente primero)
      csvFiles.sort((a, b) => b.creationDate.compareTo(a.creationDate));

      // Calcular el total de páginas
      final totalItems = csvFiles.length;
      final pageSize = 10; // Tamaño de página fijo para CSV
      final totalPages = (totalItems / pageSize).ceil();

      // Actualizar el total de páginas en el provider
      _guiaProvider.setTotalPagesCSV(totalPages);

      // Si no hay archivos, asegurarse de que la página actual sea 1
      if (totalItems == 0) {
        _archivosCsv = [];
        _isLoadingPageCSV = false;
        notifyListeners();
        return;
      }

      // Calcular el índice de inicio y fin para la página actual
      final startIndex = (_guiaProvider.currentPageCSV - 1) * pageSize;
      final endIndex = startIndex + pageSize;

      // Actualizar la lista de archivos CSV
      if (startIndex < csvFiles.length) {
        _archivosCsv = csvFiles.sublist(startIndex,
            endIndex > csvFiles.length ? csvFiles.length : endIndex);
      } else {
        // Si el índice de inicio está fuera de rango, ir a la última página
        final lastPage = totalPages;
        await _guiaProvider.goToPageCSV(lastPage);
        final lastPageStartIndex = (lastPage - 1) * pageSize;
        final lastPageEndIndex = lastPageStartIndex + pageSize;
        _archivosCsv = csvFiles.sublist(
            lastPageStartIndex,
            lastPageEndIndex > csvFiles.length
                ? csvFiles.length
                : lastPageEndIndex);
      }

      _isLoadingPageCSV = false;
      notifyListeners();
    } catch (e) {
      if (!_mounted) return;
      _errorMessage = 'Error al cargar los archivos CSV: ${e.toString()}';
      _isLoadingPageCSV = false;
      notifyListeners();
    }
  }

  // Método para verificar si un archivo específico se está compartiendo
  bool isSharingFile(GuideFile file) {
    if (!_isSharing) return false;
    return _sharingFileId == file.fullPath || _sharingFileId == file.fileName;
  }
}
