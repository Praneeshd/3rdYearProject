
import 'package:foodrush/features/profile/domain/entity/profile_enity.dart';
import 'package:json_annotation/json_annotation.dart';


part 'profile_api_model.g.dart';


@JsonSerializable()
class ProfileApiModel {
  @JsonKey(name: '_id')
  final String? profileId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? number;
  final String? location;
  final String? bio;

  const ProfileApiModel({
    required this.profileId,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.number,
    this.location,
    this.bio,
  });
        
  factory ProfileApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileApiModelToJson(this);

  // To entity
  factory ProfileApiModel.toEntity(ProfileApiModel apiModel) {
    return ProfileApiModel(
      profileId: apiModel.profileId,
      firstName: apiModel.firstName,
      lastName: apiModel.lastName,
      email: apiModel.email,
      password: apiModel.password,
      number: apiModel.number,
      location: apiModel.location,
      bio: apiModel.bio
    );
  }

  // From entity
  factory ProfileApiModel.fromEntity(ProfileEntity entity) {
    return ProfileApiModel(
      profileId: entity.profileId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
      number: entity.number,
      location: entity.location,
      bio: entity.bio
    );
  }

}