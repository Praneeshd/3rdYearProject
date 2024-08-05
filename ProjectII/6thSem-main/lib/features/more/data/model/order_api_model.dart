import 'package:foodrush/features/more/domain/entity/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_api_model.g.dart';

@JsonSerializable()
class OrderApiModel {
  @JsonKey(name: '_id')
  final String? orderId; // Assuming there's an order ID
  final String foodName;
  final int quantity;
  final double foodPrice;

  OrderApiModel({
    this.orderId,
    required this.foodName,
    required this.quantity,
    required this.foodPrice,
  });

  factory OrderApiModel.fromJson(Map<String, dynamic> json) =>
      _$OrderApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderApiModelToJson(this);


// From entity
factory OrderApiModel.fromEntity(OrderEntity entity) {
  return OrderApiModel(
    orderId: entity.orderId,
    foodName: entity.foodName,
    quantity: entity.quantity,
    foodPrice: entity.foodPrice,
  );
}

}
