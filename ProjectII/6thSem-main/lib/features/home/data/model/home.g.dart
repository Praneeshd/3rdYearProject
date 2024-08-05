// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeAPIModel _$HomeAPIModelFromJson(Map<String, dynamic> json) => HomeAPIModel(
      foodId: json['_id'] as String,
      foodName: json['foodName'] as String,
      foodPrice: json['foodPrice'] as int,
      foodDescription: json['foodDescription'] as String,
      foodCategory: json['foodCategory'] as String?,
      foodImageUrl: json['foodImageUrl'] as String?,
      foodLocation: json['foodLocation'] as String?,
    );

Map<String, dynamic> _$HomeAPIModelToJson(HomeAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.foodId,
      'foodName': instance.foodName,
      'foodPrice': instance.foodPrice,
      'foodDescription': instance.foodDescription,
      'foodCategory': instance.foodCategory,
      'foodImageUrl': instance.foodImageUrl,
      'foodLocation': instance.foodLocation,
    };
