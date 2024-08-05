import 'package:equatable/equatable.dart';

class FoodEntity extends Equatable {
  final String offerId;
  final String foodName;
  final int foodPrice;
  final String foodDescription;
  final String? foodCategory;
  final String? foodImageUrl;
  final String? foodLocation;

  const FoodEntity({
    required this.offerId,
    required this.foodName,
    required this.foodPrice,
    required this.foodDescription,
    this.foodCategory,
    this.foodImageUrl,
    this.foodLocation,
  });

  @override
  List<Object?> get props => [
        offerId,
        foodName,
        foodPrice,
        foodDescription,
        foodCategory,
        foodImageUrl,
        foodLocation,
      ];

  factory FoodEntity.fromJson(Map<String, dynamic> json) {
    return FoodEntity(
      offerId: json['_id'],
      foodName: json['foodName'],
      foodPrice: json['foodPrice'],
      foodDescription: json['foodDescription'],
      foodCategory: json['foodCategory'],
      foodImageUrl: json['foodImageUrl'],
      foodLocation: json['foodLocation'],
    );
  }
}
