import 'package:foodrush/features/restaurant/data/model/restaurant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_restaurant_dto.g.dart'; //dart run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class GetAllRestaurantDTO {
  final bool success;
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'restaurants')
  final List<RestaurantAPIModel> data;

  GetAllRestaurantDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllRestaurantDTOToJson(this);

  factory GetAllRestaurantDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllRestaurantDTOFromJson(json);
}
