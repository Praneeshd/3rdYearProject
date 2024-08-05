// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailApiModel _$EmailApiModelFromJson(Map<String, dynamic> json) =>
    EmailApiModel(
      userId: json['_id'] as String?,
      email: json['email'] as String,
    );

Map<String, dynamic> _$EmailApiModelToJson(EmailApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'email': instance.email,
    };
