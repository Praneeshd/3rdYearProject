// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferAPIModel _$OfferAPIModelFromJson(Map<String, dynamic> json) =>
    OfferAPIModel(
      offerId: json['_id'] as String,
      foodName: json['foodName'] as String,
      foodPrice: json['foodPrice'] as int,
      foodDescription: json['foodDescription'] as String,
      foodCategory: json['foodCategory'] as String?,
      foodImageUrl: json['foodImageUrl'] as String?,
      foodLocation: json['foodLocation'] as String?,
    );

Map<String, dynamic> _$OfferAPIModelToJson(OfferAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.offerId,
      'foodName': instance.foodName,
      'foodPrice': instance.foodPrice,
      'foodDescription': instance.foodDescription,
      'foodCategory': instance.foodCategory,
      'foodImageUrl': instance.foodImageUrl,
      'foodLocation': instance.foodLocation,
    };
