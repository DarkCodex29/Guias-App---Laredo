import 'package:app_guias/core/models/detalle.carga.dart';
import 'package:app_guias/core/services/detalle.carga.service.dart';
import 'package:app_guias/presentation/controllers/guide/guide.flow.controller.dart';
import 'package:app_guias/providers/campo.provider.dart';
import 'package:app_guias/providers/jiron.provider.dart';
import 'package:app_guias/providers/cuartel.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class ModalDetalleCargaController extends ChangeNotifier {
  GuideFlowController? _flowController;
  bool _isInitialized = false;
  CampoProvider? _campoProvider;
  JironProvider? _jironProvider;
  CuartelProvider? _cuartelProvider;
  List<String> _camposSugeridos = [];
  List<String> _jironesSugeridos = [];
  List<String> _cuartelesSugeridos = [];
  bool _isLoadingJirones = false;
  bool _isLoadingCuarteles = false;

  bool get isInitialized => _isInitialized;
  GuideFlowController get flowController => _flowController!;
  List<String> get camposSugeridos => _camposSugeridos;
  List<String> get jironesSugeridos => _jironesSugeridos;
  List<String> get cuartelesSugeridos => _cuartelesSugeridos;
  bool get isLoadingJirones => _isLoadingJirones;
  bool get isLoadingCuarteles => _isLoadingCuarteles;

  final _detalleCargaService = DetalleCargaService();
  List<DetalleCarga> _detalleCargas = [];

  final TextEditingController productoController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController unidadMedidaController = TextEditingController();
  final TextEditingController campoController = TextEditingController();
  final TextEditingController jironController = TextEditingController();
  final TextEditingController cuartelController = TextEditingController();
  final TextEditingController variedadController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();

  DateTime? fecha;
  int? editingIndex;
  bool _isJironEnabled = false;
  bool _isCuartelEnabled = false;
  List<String> _productosSugeridos = [];

  bool get isJironEnabled => _isJironEnabled;
  bool get isCuartelEnabled => _isCuartelEnabled;
  List<String> get productosSugeridos => _productosSugeridos;

  final List<String> _productos = [
    'CAÑA DE AZÚCAR',
  ];

  List<DetalleCarga> get detalleCargas => _detalleCargas;

  Timer? _debounceTimer;

  ModalDetalleCargaController({GuideFlowController? flowController})
      : _flowController = flowController {
    _setupListeners();
  }

  Future<void> init() async {
    if (_isInitialized) return;

    if (_campoProvider != null) {
      await _loadCampos();
    }

    await loadDetalleCargas();

    _isInitialized = true;
    _updateFieldProgress();
    notifyListeners();
  }

  void setCampoProvider(CampoProvider provider) {
    if (_campoProvider != null) return;
    _campoProvider = provider;

    _loadCampos().then((_) {
      _updateCamposSugeridos('');
    });
  }

  Future<void> _loadCampos() async {
    if (_campoProvider == null) return;

    try {
      await _campoProvider!.loadCampos();
      _updateCamposSugeridos('');
      notifyListeners();
    } catch (e) {
      // Manejar el error si es necesario
    }
  }

  void _updateCamposSugeridos(String query) {
    if (_campoProvider == null) return;

    if (query.isEmpty) {
      _camposSugeridos = _campoProvider!.campos.map((campo) {
        return _campoProvider!.formatCampoDisplay(campo);
      }).toList();
    } else {
      _camposSugeridos = _campoProvider!.campos.where((campo) {
        final formattedCampo = _campoProvider!.formatCampoDisplay(campo);
        return formattedCampo.toLowerCase().contains(query.toLowerCase());
      }).map((campo) {
        return _campoProvider!.formatCampoDisplay(campo);
      }).toList();
    }
    notifyListeners();
  }

  void setFlowController(GuideFlowController controller) {
    _flowController = controller;
  }

  void setJironProvider(JironProvider provider) {
    _jironProvider = provider;
  }

  void setCuartelProvider(CuartelProvider provider) {
    _cuartelProvider = provider;
  }

  void _setupListeners() {
    productoController.addListener(_onProductoChanged);
    cantidadController.addListener(_onFieldChanged);
    campoController.addListener(_onCampoChanged);
    jironController.addListener(_onJironChanged);
    cuartelController.addListener(_onFieldChanged);
    variedadController.addListener(_onFieldChanged);
    fechaController.addListener(_onFieldChanged);

    // Inicializar fecha
    fecha = DateTime.now();
    fechaController.text = DateFormat('dd-MM-yyyy').format(fecha!);
    _productosSugeridos = _productos;
  }

  void _onProductoChanged() {
    final query = productoController.text.toLowerCase();
    _productosSugeridos = _productos
        .where((producto) => producto.toLowerCase().contains(query))
        .toList();
    _onFieldChanged();
  }

  void _onCampoChanged() {
    _debounceTimer?.cancel();

    _updateCamposSugeridos(campoController.text);
    _isJironEnabled = campoController.text.isNotEmpty;
    _isCuartelEnabled = false;
    jironController.clear();
    cuartelController.clear();
    _jironesSugeridos = [];
    _cuartelesSugeridos = [];

    if (_isJironEnabled && _camposSugeridos.contains(campoController.text)) {
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        _loadJirones();
      });
    }

    _onFieldChanged();
  }

  void _onJironChanged() {
    _isCuartelEnabled = jironController.text.isNotEmpty;
    cuartelController.clear();
    _cuartelesSugeridos = [];

    if (_isCuartelEnabled && _jironesSugeridos.contains(jironController.text)) {
      _loadCuarteles();
    }

    _onFieldChanged();
  }

  void _onFieldChanged() {
    _validateAllFields();
    _updateFieldProgress();
    notifyListeners();
  }

  void _validateAllFields() {
    validateFields();
  }

  void _updateFieldProgress() {
    if (_flowController == null) return;

    int completedFields = 0;
    const totalFields = 7;

    if (productoController.text.isNotEmpty) completedFields++;
    if (cantidadController.text.isNotEmpty) completedFields++;
    if (unidadMedidaController.text.isNotEmpty) completedFields++;
    if (campoController.text.isNotEmpty) completedFields++;
    if (jironController.text.isNotEmpty) completedFields++;
    if (cuartelController.text.isNotEmpty) completedFields++;
    if (fecha != null) completedFields++;

    _flowController!.updateStepProgress(
      GuideStep.detalleCarga,
      completedFields,
      totalFields,
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    productoController.dispose();
    cantidadController.dispose();
    unidadMedidaController.dispose();
    campoController.dispose();
    jironController.dispose();
    cuartelController.dispose();
    variedadController.dispose();
    fechaController.dispose();
    super.dispose();
  }

  void clear() {
    productoController.clear();
    cantidadController.clear();
    unidadMedidaController.clear();
    campoController.clear();
    jironController.clear();
    cuartelController.clear();
    variedadController.clear();

    // Reiniciar la fecha al día actual
    fecha = DateTime.now();
    fechaController.text = DateFormat('dd-MM-yyyy').format(fecha!);

    editingIndex = null;
    _isJironEnabled = false;
    _isCuartelEnabled = false;
    _isLoadingJirones = false;
    _isLoadingCuarteles = false;

    // Reiniciar las sugerencias
    _productosSugeridos = _productos;
    _camposSugeridos = [];
    _jironesSugeridos = [];
    _cuartelesSugeridos = [];

    if (_campoProvider != null) {
      _loadCampos();
    }

    notifyListeners();
  }

  Future<void> loadDetalleCargas() async {
    try {
      _detalleCargas = await _detalleCargaService.getAllDetalles();

      if (_campoProvider != null) {
        await _campoProvider!.loadCampos();

        for (var i = 0; i < _detalleCargas.length; i++) {
          var detalle = _detalleCargas[i];
          detalle.id = i; // Asignar el índice correcto
          final campo = await _campoProvider!.getCampoById(detalle.campo);
          if (campo != null) {
            final formattedCampo = _campoProvider!.formatCampoDisplay(campo);
            detalle.campo = formattedCampo;
          }
        }
      }

      _updateFieldProgress();
      notifyListeners();
    } catch (e) {
      debugPrint('Error al cargar detalles: $e');
    }
  }

  String? validateFields() {
    if (cantidadController.text.isEmpty) return 'Cantidad es obligatoria';
    if (campoController.text.isEmpty) return 'Campo es obligatorio';
    if (jironController.text.isEmpty) return 'Jirón es obligatorio';
    if (cuartelController.text.isEmpty) return 'Cuartel es obligatorio';
    if (variedadController.text.isEmpty) return 'Variedad es obligatoria';
    if (fecha == null) return 'Fecha es obligatoria';
    return null;
  }

  Future<bool> saveDetalleCarga(BuildContext context) async {
    try {
      if (productoController.text.isEmpty) {
        _showError(context, 'Por favor, seleccione un producto');
        return false;
      }

      if (cantidadController.text.isEmpty) {
        _showError(context, 'Por favor, ingrese una cantidad');
        return false;
      }

      double cantidad;
      try {
        cantidad = double.parse(cantidadController.text.replaceAll(',', '.'));
        if (cantidad <= 0) {
          _showError(context, 'La cantidad debe ser mayor a 0');
          return false;
        }
      } catch (e) {
        _showError(context, 'Por favor, ingrese una cantidad válida');
        return false;
      }

      if (unidadMedidaController.text.isEmpty) {
        _showError(context, 'Por favor, seleccione una unidad de medida');
        return false;
      }

      if (campoController.text.isEmpty) {
        _showError(context, 'Por favor, seleccione un campo');
        return false;
      }

      if (jironController.text.isEmpty) {
        _showError(context, 'Por favor, seleccione un jirón');
        return false;
      }

      if (cuartelController.text.isEmpty) {
        _showError(context, 'Por favor, seleccione un cuartel');
        return false;
      }

      if (variedadController.text.isEmpty) {
        _showError(context, 'Por favor, ingrese una variedad');
        return false;
      }

      if (fecha == null) {
        _showError(context, 'Por favor, seleccione una fecha de corte');
        return false;
      }

      final detalleCarga = DetalleCarga(
        id: editingIndex,
        producto: productoController.text,
        cantidad: cantidad,
        unidadMedida: unidadMedidaController.text.toUpperCase(),
        campo: campoController.text,
        jiron: jironController.text,
        cuartel: cuartelController.text,
        variedad: variedadController.text,
        fechaCorte: fecha!,
        pesoKg: _calcularPesoKg(cantidad, unidadMedidaController.text),
      );

      try {
        if (editingIndex != null) {
          await _detalleCargaService.updateDetalle(editingIndex!, detalleCarga);
          if (_detalleCargas.length > editingIndex!) {
            _detalleCargas[editingIndex!] = detalleCarga;
          }
        } else {
          await _detalleCargaService.saveDetalle(detalleCarga);
          _detalleCargas.add(detalleCarga);
        }

        if (context.mounted) {
          _showSnackBar(context, 'Detalle guardado exitosamente', Colors.green);
        }
        clear();
        _updateFieldProgress();
        return true;
      } catch (e) {
        if (context.mounted) {
          _showError(context,
              'Error al guardar: El índice no existe en la base de datos');
        }
        return false;
      }
    } catch (e) {
      debugPrint('Error al guardar detalle de carga: $e');
      if (context.mounted) {
        _showSnackBar(context, 'Error al guardar detalle: $e', Colors.red);
      }
      return false;
    }
  }

  double _calcularPesoKg(double cantidad, String unidadMedida) {
    if (unidadMedida.toUpperCase() == 'TM') {
      return cantidad * 1000;
    }
    return cantidad;
  }

  void editDetalleCarga(DetalleCarga detalle, int index) {
    productoController.text = detalle.producto;
    cantidadController.text = detalle.cantidad.toString();
    unidadMedidaController.text = detalle.unidadMedida;
    campoController.text = detalle.campo;
    jironController.text = detalle.jiron;
    cuartelController.text = detalle.cuartel;
    variedadController.text = detalle.variedad;
    fecha = detalle.fechaCorte;
    fechaController.text = DateFormat('dd-MM-yyyy').format(detalle.fechaCorte);
    editingIndex = index;
    _isJironEnabled = true;
    _isCuartelEnabled = true;

    // Cargar las sugerencias correspondientes
    _loadJirones().then((_) {
      _loadCuarteles();
    });

    _updateFieldProgress();
    notifyListeners();
  }

  Future<void> _loadJirones() async {
    if (_jironProvider == null || _campoProvider == null) {
      return;
    }

    _isLoadingJirones = true;
    notifyListeners();

    try {
      final campoCode = _campoProvider!.getCampoCode(campoController.text);
      final campoCodeTrimmed = campoCode?.trim();

      if (campoCodeTrimmed != null) {
        final jirones =
            await _jironProvider!.getJironesByCampo(campoCodeTrimmed);
        _jironesSugeridos = jirones
            .map((jiron) => _jironProvider!.formatJironDisplay(jiron))
            .toList();
      }
    } catch (e) {
      // Manejar el error si es necesario
    } finally {
      _isLoadingJirones = false;
      notifyListeners();
    }
  }

  Future<void> _loadCuarteles() async {
    _isLoadingCuarteles = true;
    notifyListeners();

    try {
      final campoCode = _campoProvider!.getCampoCode(campoController.text);
      final campoCodeTrimmed = campoCode?.trim();
      final jironCode = _jironProvider?.getJironCode(jironController.text);
      final jironCodeTrimmed = jironCode?.trim();

      if (campoCodeTrimmed != null && jironCodeTrimmed != null) {
        final cuarteles = await _cuartelProvider!.getCuartelesByCampo(
          campoCodeTrimmed,
          all: true,
        );

        // Filtrar cuarteles por jirón
        final cuartelesFiltrados = cuarteles
            .where((cuartel) => cuartel.jiron.trim() == jironCodeTrimmed)
            .map((cuartel) => _cuartelProvider!.formatCuartelDisplay(cuartel))
            .toList();

        _cuartelesSugeridos = cuartelesFiltrados;
      } else {
        debugPrint('No se pudo obtener el código del campo o jirón');
      }
    } catch (e) {
      debugPrint('Error al cargar cuarteles: $e');
    } finally {
      _isLoadingCuarteles = false;
      notifyListeners();
    }
  }

  Future<bool> confirmarEliminacion(BuildContext context, int index) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Está seguro que desea eliminar este detalle?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (result == true) {
      _detalleCargas.removeAt(index);
      notifyListeners();
      return true;
    }
    return false;
  }

  double calcularPesoTotal() {
    return _detalleCargas.fold(0.0, (sum, item) => sum + item.pesoKg);
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
