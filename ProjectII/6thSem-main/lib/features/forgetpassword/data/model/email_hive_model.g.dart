// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmailHiveModelAdapter extends TypeAdapter<EmailHiveModel> {
  @override
  final int typeId = 0;

  @override
  EmailHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmailHiveModel(
      userId: fields[0] as String?,
      email: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EmailHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
