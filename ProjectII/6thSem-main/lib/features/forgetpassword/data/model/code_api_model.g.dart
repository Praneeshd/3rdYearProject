// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodeApiModel _$CodeApiModelFromJson(Map<String, dynamic> json) => CodeApiModel(
      userId: json['_id'] as String?,
      resetCode: json['resetCode'] as int,
    );

Map<String, dynamic> _$CodeApiModelToJson(CodeApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'resetCode': instance.resetCode,
    };
