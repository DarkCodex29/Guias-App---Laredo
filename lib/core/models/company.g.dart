// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompanyAdapter extends TypeAdapter<Company> {
  @override
  final int typeId = 1;

  @override
  Company read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Company(
      companyName: fields[0] as String,
      ruc: fields[1] as String,
      address: fields[2] as String,
      defaultValues: (fields[3] as Map).cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Company obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.companyName)
      ..writeByte(1)
      ..write(obj.ruc)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.defaultValues);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
