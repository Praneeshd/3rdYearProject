import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String? profileId;
  final String? image;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? number;
  final String? location;
  final String? bio;

  @override
  List<Object?> get props => [
        profileId,
        firstName,
        image,
        lastName,
        email,
        password,
        number,
        location,
        bio
      ];

  const ProfileEntity({
    this.profileId,
    this.image,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.number,
    this.location,
    this.bio
  });

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
        profileId: json["profileId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        number: json["number"],
        location: json["location"],
        bio: json["bio"]
      );

  Map<String, dynamic> toJson() => {
        "profileId": profileId,
        "firstName": firstName,
        "lastName" :lastName,
        "email": email,
        "password": password,
        "number": number,
        "location": location,
        "bio": bio
      };

  @override
  String toString() {
    return 'ProfileEntity(profileId: $profileId, firstName: $firstName,lastName: $lastName, email: $email,password:$password, number: $number, location:$location,bio: $bio)';
  }
}
