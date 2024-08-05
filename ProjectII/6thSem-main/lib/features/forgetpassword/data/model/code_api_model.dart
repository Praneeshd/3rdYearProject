import 'package:foodrush/features/forgetpassword/domain/entity/code_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'code_api_model.g.dart';

@JsonSerializable()
class CodeApiModel {
  @JsonKey(name: '_id')
  final String? userId;
  final int resetCode;

  CodeApiModel({
    this.userId,
    required this.resetCode,
  });

  factory CodeApiModel.fromJson(Map<String, dynamic> json) =>
      _$CodeApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CodeApiModelToJson(this);

  // To entity
  factory CodeApiModel.toEntity(CodeApiModel apiModel) {
    return CodeApiModel(
      userId: apiModel.userId,
      resetCode: apiModel.resetCode,
    );
  }

  // From entity
  factory CodeApiModel.fromEntity(CodeEntity entity) {
    return CodeApiModel(
      userId: entity.id,
      resetCode: entity.resetCode,
    );
  }
}
