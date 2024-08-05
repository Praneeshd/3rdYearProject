import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String? orderId;
  final String foodName;
  final int quantity;
  final double foodPrice;

  const OrderEntity({
    this.orderId,
    required this.foodName,
    required this.quantity,
    required this.foodPrice,
  });

    @override
  List<Object?> get props =>
      [orderId, foodName, quantity, foodPrice];
}
