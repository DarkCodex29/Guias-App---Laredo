import 'package:app_guias/models/ubigeo.dart';

abstract class UbigeoRepository {
  Future<List<DepartamentoModel>> getDepartamentos();
  Future<List<ProvinciaModel>> getProvincias(String codigoDepartamento);
  Future<List<DistritoModel>> getDistritos(String codigoProvincia);
  Future<bool> existenDatos();
}
