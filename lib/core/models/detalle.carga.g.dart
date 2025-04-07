// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detalle.carga.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetalleCargaAdapter extends TypeAdapter<DetalleCarga> {
  @override
  final int typeId = 2;

  @override
  DetalleCarga read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetalleCarga(
      id: fields[0] as int?,
      producto: fields[1] as String,
      cantidad: fields[2] as double,
      unidadMedida: fields[3] as String,
      campo: fields[4] as String,
      cuartel: fields[5] as String,
      jiron: fields[6] as String,
      variedad: fields[7] as String,
      fechaCorte: fields[8] as DateTime,
      pesoKg: fields[9] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DetalleCarga obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.producto)
      ..writeByte(2)
      ..write(obj.cantidad)
      ..writeByte(3)
      ..write(obj.unidadMedida)
      ..writeByte(4)
      ..write(obj.campo)
      ..writeByte(5)
      ..write(obj.cuartel)
      ..writeByte(6)
      ..write(obj.jiron)
      ..writeByte(7)
      ..write(obj.variedad)
      ..writeByte(8)
      ..write(obj.fechaCorte)
      ..writeByte(9)
      ..write(obj.pesoKg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetalleCargaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
