import 'package:foodrush/features/home/domain/entity/home_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable()
class HomeAPIModel {
  @JsonKey(name: '_id')
  final String foodId;
  final String foodName;
  final int foodPrice;
  final String foodDescription;
  final String? foodCategory;
  final String? foodImageUrl;
  final String? foodLocation;

  HomeAPIModel({
    required this.foodId,
    required this.foodName,
    required this.foodPrice,
    required this.foodDescription,
    this.foodCategory,
    this.foodImageUrl,
    this.foodLocation,
  });

  factory HomeAPIModel.fromJson(Map<String, dynamic> json) =>
      _$HomeAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeAPIModelToJson(this);

  // From entity to model
  factory HomeAPIModel.fromEntity(HomeEntity entity) {
    return HomeAPIModel(
      foodId: entity.foodId,
      foodName: entity.foodName,
      foodPrice: entity.foodPrice,
      foodDescription: entity.foodDescription,
      foodCategory: entity.foodCategory,
      foodImageUrl: entity.foodImageUrl,
      foodLocation: entity.foodLocation,
    );
  }

  // From model to entity
  static HomeEntity toEntity(HomeAPIModel model) {
    return HomeEntity(
      foodId: model.foodId,
      foodName: model.foodName,
      foodPrice: model.foodPrice,
      foodDescription: model.foodDescription,
      foodCategory: model.foodCategory,
      foodImageUrl: model.foodImageUrl,
      foodLocation: model.foodLocation,
    );
  }
}
