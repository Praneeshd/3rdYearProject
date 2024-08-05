import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/features/profile/domain/entity/profile_enity.dart';
import 'package:foodrush/features/profile/domain/respository/profile_repository.dart';

import '../../../../core/failure/failure.dart';

final profileUsecaseProvider = Provider<ProfileUseCase>(
  (ref) => ProfileUseCase(
    profileRepository: ref.watch(profileRepositoryProvider),
  ),
);

class ProfileUseCase {
  final IProfileRepository profileRepository;

  ProfileUseCase({required this.profileRepository});

  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile) {
    return profileRepository.updateProfile(profile);
  }

  // Future<Either<Failure, List<ProfileEntity>>> getUser() {
  //   return profileRepository.getUser();
  // }
    Future<Either<Failure, List<ProfileEntity>>> getUser() async {
    try {
      final data = await profileRepository.getUser();
      return data;
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

}