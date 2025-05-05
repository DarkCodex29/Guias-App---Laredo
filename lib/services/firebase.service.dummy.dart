import 'package:app_guias/models/ubigeo.dart';
import 'package:app_guias/domain/repositories/ubigeo.repository.dart';

class FirebaseServiceDummy implements UbigeoRepository {
  Future<void> initializeUbigeo() async {}

  @override
  Future<List<DepartamentoModel>> getDepartamentos() async => [];

  @override
  Future<List<ProvinciaModel>> getProvincias(String departamentoId) async => [];

  @override
  Future<List<DistritoModel>> getDistritos(String provinciaId) async => [];

  @override
  Future<bool> existenDatos() async => false;
}
