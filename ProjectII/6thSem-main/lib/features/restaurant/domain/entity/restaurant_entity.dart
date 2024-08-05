import 'package:equatable/equatable.dart';

class RestaurantEntity extends Equatable {
  final String restaurantId;
  final String restaurantName;
  final String? restaurantImageUrl;
  final String restaurantLocation;
  final int? restaurantContact;

  const RestaurantEntity({
    required this.restaurantId,
    required this.restaurantName,
    this.restaurantImageUrl,
    required this.restaurantLocation,
    this.restaurantContact,
  });

  @override
  List<Object?> get props => [
        restaurantId,
        restaurantName,
        restaurantImageUrl,
        restaurantLocation,
        restaurantContact,
      ];

  factory RestaurantEntity.fromJson(Map<String, dynamic> json) {
    return RestaurantEntity(
      restaurantId: json['_id'],
      restaurantName: json['restaurantName'],
      restaurantImageUrl: json['restaurantImageUrl'],
      restaurantLocation: json['restaurantLocation'],
      restaurantContact: json['restaurantContact'],
    );
  }
}
