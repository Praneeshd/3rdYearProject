// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderApiModel _$OrderApiModelFromJson(Map<String, dynamic> json) =>
    OrderApiModel(
      orderId: json['_id'] as String?,
      foodName: json['foodName'] as String,
      quantity: json['quantity'] as int,
      foodPrice: (json['foodPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderApiModelToJson(OrderApiModel instance) =>
    <String, dynamic>{
      '_id': instance.orderId,
      'foodName': instance.foodName,
      'quantity': instance.quantity,
      'foodPrice': instance.foodPrice,
    };
