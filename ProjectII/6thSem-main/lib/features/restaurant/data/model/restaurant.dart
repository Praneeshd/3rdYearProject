import 'package:foodrush/features/restaurant/domain/entity/restaurant_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class RestaurantAPIModel {
  @JsonKey(name: '_id')
  final String restaurantId;
  final String restaurantName;
  final String? restaurantImageUrl;
  final String restaurantLocation;
   final int? restaurantContact;

  RestaurantAPIModel({
    required this.restaurantId,
    required this.restaurantName,
    this.restaurantImageUrl,
    required this.restaurantLocation,
    this.restaurantContact,
  });

  factory RestaurantAPIModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantAPIModelToJson(this);

  // From entity to model
  factory RestaurantAPIModel.fromEntity(RestaurantEntity entity) {
    return RestaurantAPIModel(
      restaurantId: entity.restaurantId,
      restaurantName: entity.restaurantName,
      restaurantImageUrl: entity.restaurantImageUrl,
      restaurantLocation: entity.restaurantLocation,
      restaurantContact: entity.restaurantContact
    );
  }

  // From model to entity
  static RestaurantEntity toEntity(RestaurantAPIModel model) {
    return RestaurantEntity(
      restaurantId: model.restaurantId,
      restaurantName: model.restaurantName,
      restaurantImageUrl: model.restaurantImageUrl,
      restaurantLocation: model.restaurantLocation,
      restaurantContact: model.restaurantContact
    );
  }
}
