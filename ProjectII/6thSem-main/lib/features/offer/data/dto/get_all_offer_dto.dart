import 'package:foodrush/features/offer/data/model/offers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_offer_dto.g.dart';

@JsonSerializable()
class GetAllOfferDTO {
  final bool success;
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'foods')
  final List<OfferAPIModel> data;

  GetAllOfferDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllOfferDTOToJson(this);

  factory GetAllOfferDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllOfferDTOFromJson(json);
}
