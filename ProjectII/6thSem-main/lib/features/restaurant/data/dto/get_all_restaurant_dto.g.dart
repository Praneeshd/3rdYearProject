// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_restaurant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllRestaurantDTO _$GetAllRestaurantDTOFromJson(Map<String, dynamic> json) =>
    GetAllRestaurantDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['restaurants'] as List<dynamic>)
          .map((e) => RestaurantAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllRestaurantDTOToJson(
        GetAllRestaurantDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'restaurants': instance.data,
    };
