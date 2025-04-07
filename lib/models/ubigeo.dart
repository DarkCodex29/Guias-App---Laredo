import 'package:app_guias/core/models/base_model.dart';
import 'package:hive/hive.dart';

part 'ubigeo.g.dart';

@HiveType(typeId: 3)
class Departamento extends BaseEntity {
  @HiveField(0)
  final String codigo;

  @HiveField(1)
  final String nombre;

  Departamento({
    required this.codigo,
    required this.nombre,
  });

  @override
  String get id => codigo;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Departamento &&
          runtimeType == other.runtimeType &&
          codigo == other.codigo;

  @override
  int get hashCode => codigo.hashCode;
}

@HiveType(typeId: 4)
class Provincia extends BaseEntity {
  @HiveField(0)
  final String codigo;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  final String codigoDepartamento;

  Provincia({
    required this.codigo,
    required this.nombre,
    required this.codigoDepartamento,
  });

  @override
  String get id => codigo;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Provincia &&
          runtimeType == other.runtimeType &&
          codigo == other.codigo;

  @override
  int get hashCode => codigo.hashCode;
}

@HiveType(typeId: 5)
class Distrito extends BaseEntity {
  @HiveField(0)
  final String codigo;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  final String codigoProvincia;

  @HiveField(3)
  final String codigoDepartamento;

  Distrito({
    required this.codigo,
    required this.nombre,
    required this.codigoProvincia,
    required this.codigoDepartamento,
  });

  @override
  String get id => codigo;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Distrito &&
          runtimeType == other.runtimeType &&
          codigo == other.codigo;

  @override
  int get hashCode => codigo.hashCode;
}

// Modelos para Firebase
@HiveType(typeId: 6)
class DepartamentoModel extends BaseModel {
  @HiveField(0)
  final String codigo;

  @HiveField(1)
  final String nombre;

  DepartamentoModel({
    required this.codigo,
    required this.nombre,
  });

  @override
  String get id => codigo;

  @override
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nombre': nombre,
    };
  }

  factory DepartamentoModel.fromMap(Map<String, dynamic> map) {
    return DepartamentoModel(
      codigo: map['codigo'] ?? '',
      nombre: map['nombre'] ?? '',
    );
  }
}

@HiveType(typeId: 7)
class ProvinciaModel extends BaseModel {
  @HiveField(0)
  final String codigo;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  final String codigoDepartamento;

  ProvinciaModel({
    required this.codigo,
    required this.nombre,
    required this.codigoDepartamento,
  });

  @override
  String get id => codigo;

  @override
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nombre': nombre,
      'codigoDepartamento': codigoDepartamento,
    };
  }

  factory ProvinciaModel.fromMap(Map<String, dynamic> map) {
    return ProvinciaModel(
      codigo: map['codigo'] ?? '',
      nombre: map['nombre'] ?? '',
      codigoDepartamento: map['codigoDepartamento'] ?? '',
    );
  }
}

@HiveType(typeId: 8)
class DistritoModel extends BaseModel {
  @HiveField(0)
  final String codigo;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  final String codigoProvincia;

  @HiveField(3)
  final String codigoDepartamento;

  DistritoModel({
    required this.codigo,
    required this.nombre,
    required this.codigoProvincia,
    required this.codigoDepartamento,
  });

  @override
  String get id => codigo;

  @override
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nombre': nombre,
      'codigoProvincia': codigoProvincia,
      'codigoDepartamento': codigoDepartamento,
    };
  }

  factory DistritoModel.fromMap(Map<String, dynamic> map) {
    return DistritoModel(
      codigo: map['codigo'] ?? '',
      nombre: map['nombre'] ?? '',
      codigoProvincia: map['codigoProvincia'] ?? '',
      codigoDepartamento: map['codigoDepartamento'] ?? '',
    );
  }
}
