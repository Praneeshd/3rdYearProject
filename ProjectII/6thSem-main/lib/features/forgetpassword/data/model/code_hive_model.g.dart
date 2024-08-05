// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CodeHiveModelAdapter extends TypeAdapter<CodeHiveModel> {
  @override
  final int typeId = 0;

  @override
  CodeHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CodeHiveModel(
      userId: fields[0] as String?,
      resetCode: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CodeHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.resetCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CodeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
