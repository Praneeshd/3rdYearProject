// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantAPIModel _$RestaurantAPIModelFromJson(Map<String, dynamic> json) =>
    RestaurantAPIModel(
      restaurantId: json['_id'] as String,
      restaurantName: json['restaurantName'] as String,
      restaurantImageUrl: json['restaurantImageUrl'] as String?,
      restaurantLocation: json['restaurantLocation'] as String,
      restaurantContact: json['restaurantContact'] as int?,
    );

Map<String, dynamic> _$RestaurantAPIModelToJson(RestaurantAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.restaurantId,
      'restaurantName': instance.restaurantName,
      'restaurantImageUrl': instance.restaurantImageUrl,
      'restaurantLocation': instance.restaurantLocation,
      'restaurantContact': instance.restaurantContact,
    };
