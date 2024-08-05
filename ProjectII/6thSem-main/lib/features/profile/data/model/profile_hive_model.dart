import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/features/profile/domain/entity/profile_enity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/constants/hive_table_constant.dart';


part 'profile_hive_model.g.dart';

final profileHiveModelProvider = Provider(
  (ref) => ProfileHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.profileTableId)
class ProfileHiveModel {
  @HiveField(0)
  final String profileId;
  @HiveField(1)
  final String? firstName;
  @HiveField(2)
  final String? lastName;
  @HiveField(3)
  final String? email;
  @HiveField(4)
  final String? password;
  @HiveField(5)
  final String? number;
  @HiveField(6)
  final String? location;
   @HiveField(7)
  final String? bio;

  // empty constructor
  ProfileHiveModel.empty()
      : this(
          profileId: '',
          firstName: '',
          lastName: '',
          email: '',
          password: '',
          number: '',
          location: '',
          bio: ''
        );

  ProfileHiveModel({
    String? profileId,
    this.firstName,
    this.lastName, 
    this. email, 
    this. password, 
    this. number,    
    this.location, 
    this. bio, 



  }) : profileId = profileId ?? const Uuid().v4();

  // Convert Hive Object to Entity
  ProfileEntity toEntity() => ProfileEntity(
        profileId: profileId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        number: number,
        location: location,
        bio: bio,
      );

  // Convert Entity to Hive Object
  ProfileHiveModel toHiveModel(ProfileEntity entity) => ProfileHiveModel(
        // profileId: entity.profileId,
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        password: entity.password,
        number: entity.number,
        location: entity.location,
        bio: entity.bio

      );

  // Convert Hive List to Entity List
  List<ProfileEntity> toEntityList(List<ProfileHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'profileId: $profileId, firstName: $firstName,lastName:$lastName, email:$email,password:$password,number: $number, location :$location, bio: $bio'; 
  }
}