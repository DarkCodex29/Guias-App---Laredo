import 'package:app_guias/models/ubigeo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_guias/domain/repositories/ubigeo.repository.dart';
import 'package:app_guias/core/errors/failures.dart';
import 'package:app_guias/services/storage/ubigeo.storage.service.dart';

class FirebaseService implements UbigeoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UbigeoStorageService _storageService = UbigeoStorageService();
  bool _isInitialized = false;

  // Inicializar todos los datos de ubigeo
  Future<void> initializeUbigeo() async {
    if (_isInitialized) return;

    try {
      // Inicializar el servicio de almacenamiento
      await _storageService.init();

      // Verificar si ya tenemos datos locales
      if (_storageService.hasData()) {
        _isInitialized = true;
        return;
      }

      // Cargar departamentos
      final departamentosSnapshot =
          await _firestore.collection('departamentos').get();
      final departamentos = departamentosSnapshot.docs.map((doc) {
        return DepartamentoModel(
          codigo: doc.id,
          nombre: doc.data()['nombre'] ?? 'Sin nombre',
        );
      }).toList();

      // Cargar provincias
      final provinciasSnapshot =
          await _firestore.collection('provincias').get();
      final provincias = provinciasSnapshot.docs.map((doc) {
        final data = doc.data();
        return ProvinciaModel(
          codigo: doc.id,
          nombre: data['nombre'] ?? 'Sin nombre',
          codigoDepartamento: data['codigoDepartamento'] ?? '',
        );
      }).toList();

      // Cargar distritos
      final distritosSnapshot = await _firestore.collection('distritos').get();
      final distritos = distritosSnapshot.docs.map((doc) {
        final data = doc.data();
        return DistritoModel(
          codigo: doc.id,
          nombre: data['nombre'] ?? 'Sin nombre',
          codigoProvincia: data['codigoProvincia'] ?? '',
          codigoDepartamento: data['codigoDepartamento'] ?? '',
        );
      }).toList();

      // Guardar en almacenamiento local
      await _storageService.saveDepartamentos(departamentos);
      await _storageService.saveProvincias(provincias);
      await _storageService.saveDistritos(distritos);

      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
      throw ServerFailure(message: 'Error al cargar datos de ubigeo: $e');
    }
  }

  @override
  Future<List<DepartamentoModel>> getDepartamentos() async {
    try {
      if (!_isInitialized) {
        await initializeUbigeo();
      }
      return _storageService.getDepartamentos();
    } catch (e) {
      throw ServerFailure(message: 'Error al obtener departamentos: $e');
    }
  }

  @override
  Future<List<ProvinciaModel>> getProvincias(String departamentoId) async {
    try {
      if (!_isInitialized) {
        await initializeUbigeo();
      }
      return _storageService
          .getProvincias()
          .where((p) => p.codigoDepartamento == departamentoId)
          .toList();
    } catch (e) {
      throw ServerFailure(message: 'Error al obtener provincias: $e');
    }
  }

  @override
  Future<List<DistritoModel>> getDistritos(String provinciaId) async {
    try {
      if (!_isInitialized) {
        await initializeUbigeo();
      }
      return _storageService
          .getDistritos()
          .where((d) => d.codigoProvincia == provinciaId)
          .toList();
    } catch (e) {
      throw ServerFailure(message: 'Error al obtener distritos: $e');
    }
  }

  @override
  Future<bool> existenDatos() async {
    if (!_isInitialized) {
      await initializeUbigeo();
    }
    return _storageService.hasData();
  }
}
