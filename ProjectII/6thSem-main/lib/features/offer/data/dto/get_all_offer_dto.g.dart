// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_offer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllOfferDTO _$GetAllOfferDTOFromJson(Map<String, dynamic> json) =>
    GetAllOfferDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['foods'] as List<dynamic>)
          .map((e) => OfferAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllOfferDTOToJson(GetAllOfferDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'foods': instance.data,
    };
