import 'package:foodrush/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_api_model.g.dart';

@JsonSerializable()
class EmailApiModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String email;

  EmailApiModel({
    this.userId,
    required this.email,
  });

  factory EmailApiModel.fromJson(Map<String, dynamic> json) =>
      _$EmailApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmailApiModelToJson(this);

  // To entity
  factory EmailApiModel.toEntity(EmailApiModel apiModel) {
    return EmailApiModel(
      userId: apiModel.userId,
      email: apiModel.email,
    );
  }

  // From entity
  factory EmailApiModel.fromEntity(AuthEntity entity) {
    return EmailApiModel(
      userId: entity.id,
      email: entity.email,
    );
  }
}
