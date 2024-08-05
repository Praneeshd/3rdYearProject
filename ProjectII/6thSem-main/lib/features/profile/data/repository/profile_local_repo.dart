import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/features/profile/domain/entity/profile_enity.dart';
import 'package:foodrush/features/profile/domain/respository/profile_repository.dart';

import '../../../../core/failure/failure.dart';
import '../data_source/profile_local_data_source.dart';

final profileLocalRepoProvider = Provider<IProfileRepository>((ref) {
  return ProfileLocalRepositoryImpl(
    profileLocalDataSource: ref.read(profileLocalDataSourceProvider),
  );
});

class ProfileLocalRepositoryImpl implements IProfileRepository {
  final ProfileLocalDataSource profileLocalDataSource;

  ProfileLocalRepositoryImpl({
    required this.profileLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile) {
    return profileLocalDataSource.updateProfile(profile);
  }

  @override
  Future<Either<Failure, List<ProfileEntity>>> getUser() {
    // TODO: implement getUserDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}