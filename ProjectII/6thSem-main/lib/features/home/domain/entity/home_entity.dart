import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final String foodId;
  final String foodName;
  final int foodPrice;
  final String foodDescription;
  final String? foodCategory;
  final String? foodImageUrl;
  final String? foodLocation;

  const HomeEntity({
    required this.foodId,
    required this.foodName,
    required this.foodPrice,
    required this.foodDescription,
    this.foodCategory,
    this.foodImageUrl,
    this.foodLocation,
  });

  @override
  List<Object?> get props => [
        foodId,
        foodName,
        foodPrice,
        foodDescription,
        foodCategory,
        foodImageUrl,
        foodLocation
      ];

  factory HomeEntity.fromJson(Map<String, dynamic> json) {
    return HomeEntity(
      foodId: json['_id'],
      foodName: json['foodName'],
      foodPrice: json['foodPrice'],
      foodDescription: json['foodDescription'],
      foodCategory: json['foodCategory'],
      foodImageUrl: json['foodImageUrl'],
      foodLocation: json['foodLocation'],
    );
  }
}
