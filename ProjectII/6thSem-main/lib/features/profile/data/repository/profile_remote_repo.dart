import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:foodrush/features/profile/domain/entity/profile_enity.dart';
import 'package:foodrush/features/profile/domain/respository/profile_repository.dart';

import '../../../../core/failure/failure.dart';

final profileRemoteRepoProvider = Provider<IProfileRepository>(
  (ref) => ProfileRemoteRepositoryImpl(
    profileRemoteDataSource: ref.read(profileRemoteDataSourceProvider),
  ),
);

class ProfileRemoteRepositoryImpl implements IProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRemoteRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile) {
    return profileRemoteDataSource.updateProfile(profile);
  }

  @override
  Future<Either<Failure, List<ProfileEntity>>> getUser() {
    throw UnimplementedError();
  }

   @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return profileRemoteDataSource.uploadProfilePicture(file);
  }
}
