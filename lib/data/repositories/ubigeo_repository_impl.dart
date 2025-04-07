import 'package:app_guias/models/ubigeo.dart';
import 'package:app_guias/domain/repositories/ubigeo.repository.dart';
import 'package:app_guias/services/firebase.service.dart';

class UbigeoRepositoryImpl implements UbigeoRepository {
  final FirebaseService _firebaseService;

  UbigeoRepositoryImpl(this._firebaseService);

  @override
  Future<List<DepartamentoModel>> getDepartamentos() async {
    return await _firebaseService.getDepartamentos();
  }

  @override
  Future<List<ProvinciaModel>> getProvincias(String departamentoId) async {
    return await _firebaseService.getProvincias(departamentoId);
  }

  @override
  Future<List<DistritoModel>> getDistritos(String provinciaId) async {
    return await _firebaseService.getDistritos(provinciaId);
  }

  @override
  Future<bool> existenDatos() async {
    return await _firebaseService.existenDatos();
  }
}
