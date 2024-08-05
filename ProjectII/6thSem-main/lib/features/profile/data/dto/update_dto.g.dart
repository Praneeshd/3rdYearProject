// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllProfileDTO _$GetAllProfileDTOFromJson(Map<String, dynamic> json) =>
    GetAllProfileDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => ProfileApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllProfileDTOToJson(GetAllProfileDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
