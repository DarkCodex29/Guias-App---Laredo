// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ubigeo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DepartamentoAdapter extends TypeAdapter<Departamento> {
  @override
  final int typeId = 3;

  @override
  Departamento read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Departamento(
      codigo: fields[0] as String,
      nombre: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Departamento obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.codigo)
      ..writeByte(1)
      ..write(obj.nombre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepartamentoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProvinciaAdapter extends TypeAdapter<Provincia> {
  @override
  final int typeId = 4;

  @override
  Provincia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Provincia(
      codigo: fields[0] as String,
      nombre: fields[1] as String,
      codigoDepartamento: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Provincia obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.codigo)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.codigoDepartamento);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvinciaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DistritoAdapter extends TypeAdapter<Distrito> {
  @override
  final int typeId = 5;

  @override
  Distrito read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Distrito(
      codigo: fields[0] as String,
      nombre: fields[1] as String,
      codigoProvincia: fields[2] as String,
      codigoDepartamento: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Distrito obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.codigo)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.codigoProvincia)
      ..writeByte(3)
      ..write(obj.codigoDepartamento);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistritoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DepartamentoModelAdapter extends TypeAdapter<DepartamentoModel> {
  @override
  final int typeId = 6;

  @override
  DepartamentoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DepartamentoModel(
      codigo: fields[0] as String,
      nombre: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DepartamentoModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.codigo)
      ..writeByte(1)
      ..write(obj.nombre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepartamentoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProvinciaModelAdapter extends TypeAdapter<ProvinciaModel> {
  @override
  final int typeId = 7;

  @override
  ProvinciaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProvinciaModel(
      codigo: fields[0] as String,
      nombre: fields[1] as String,
      codigoDepartamento: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProvinciaModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.codigo)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.codigoDepartamento);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvinciaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DistritoModelAdapter extends TypeAdapter<DistritoModel> {
  @override
  final int typeId = 8;

  @override
  DistritoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DistritoModel(
      codigo: fields[0] as String,
      nombre: fields[1] as String,
      codigoProvincia: fields[2] as String,
      codigoDepartamento: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DistritoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.codigo)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.codigoProvincia)
      ..writeByte(3)
      ..write(obj.codigoDepartamento);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistritoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
