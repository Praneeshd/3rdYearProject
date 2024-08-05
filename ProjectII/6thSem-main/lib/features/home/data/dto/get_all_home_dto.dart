import 'package:foodrush/features/home/data/model/home.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_home_dto.g.dart'; //dart run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class GetAllHomeDTO {
  final bool success;
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'foods')
  final List<HomeAPIModel> data;

  GetAllHomeDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllHomeDTOToJson(this);

  factory GetAllHomeDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllHomeDTOFromJson(json);
}
