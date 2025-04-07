import 'package:app_guias/core/models/base_model.dart';
import 'package:app_guias/models/ubigeo.dart';

class UbigeoMapper extends BaseMapper<DepartamentoModel, Departamento> {
  @override
  Departamento toEntity(DepartamentoModel model) {
    return Departamento(
      codigo: model.codigo,
      nombre: model.nombre,
    );
  }

  @override
  DepartamentoModel toModel(Departamento entity) {
    return DepartamentoModel(
      codigo: entity.codigo,
      nombre: entity.nombre,
    );
  }
}

class ProvinciaMapper extends BaseMapper<ProvinciaModel, Provincia> {
  @override
  Provincia toEntity(ProvinciaModel model) {
    return Provincia(
      codigo: model.codigo,
      nombre: model.nombre,
      codigoDepartamento: model.codigoDepartamento,
    );
  }

  @override
  ProvinciaModel toModel(Provincia entity) {
    return ProvinciaModel(
      codigo: entity.codigo,
      nombre: entity.nombre,
      codigoDepartamento: entity.codigoDepartamento,
    );
  }
}

class DistritoMapper extends BaseMapper<DistritoModel, Distrito> {
  @override
  Distrito toEntity(DistritoModel model) {
    return Distrito(
      codigo: model.codigo,
      nombre: model.nombre,
      codigoProvincia: model.codigoProvincia,
      codigoDepartamento: model.codigoDepartamento,
    );
  }

  @override
  DistritoModel toModel(Distrito entity) {
    return DistritoModel(
      codigo: entity.codigo,
      nombre: entity.nombre,
      codigoProvincia: entity.codigoProvincia,
      codigoDepartamento: entity.codigoDepartamento,
    );
  }
}
