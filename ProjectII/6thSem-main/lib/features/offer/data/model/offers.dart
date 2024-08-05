import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/offer_entity.dart';

part 'offers.g.dart';

@JsonSerializable()
class OfferAPIModel {
  @JsonKey(name: '_id')
  final String offerId;
  final String foodName;
  final int foodPrice;
  final String foodDescription;
  final String? foodCategory;
  final String? foodImageUrl;
  final String? foodLocation;

  OfferAPIModel({
    required this.offerId,
    required this.foodName,
    required this.foodPrice,
    required this.foodDescription,
    this.foodCategory,
    this.foodImageUrl,
    this.foodLocation,
  });

  factory OfferAPIModel.fromJson(Map<String, dynamic> json) =>
      _$OfferAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferAPIModelToJson(this);

  // From entity to model
  factory OfferAPIModel.fromEntity(FoodEntity entity) {
    return OfferAPIModel(
      offerId: entity.offerId,
      foodName: entity.foodName,
      foodPrice: entity.foodPrice,
      foodDescription: entity.foodDescription,
      foodCategory: entity.foodCategory,
      foodImageUrl: entity.foodImageUrl,
      foodLocation: entity.foodLocation,
    );
  }

  // From model to entity
  static FoodEntity toEntity(OfferAPIModel model) {
    return FoodEntity(
      offerId: model.offerId,
      foodName: model.foodName,
      foodPrice: model.foodPrice,
      foodDescription: model.foodDescription,
      foodCategory: model.foodCategory,
      foodImageUrl: model.foodImageUrl,
      foodLocation: model.foodLocation,
    );
  }
}
