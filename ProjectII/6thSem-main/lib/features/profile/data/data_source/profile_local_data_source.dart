import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/network/local_network/hive_service.dart';
import 'package:foodrush/features/profile/data/model/profile_hive_model.dart';
import 'package:foodrush/features/profile/domain/entity/profile_enity.dart';

import '../../../../core/failure/failure.dart';

// Dependency Injection using Riverpod
final profileLocalDataSourceProvider = Provider<ProfileLocalDataSource>((ref) {
  return ProfileLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      profileHiveModel: ref.read(profileHiveModelProvider));
});

class ProfileLocalDataSource {
  final HiveService hiveService;
  final ProfileHiveModel profileHiveModel;

  ProfileLocalDataSource({
    required this.hiveService,
    required this.profileHiveModel,
  });

  // Add Profile
  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile) async {
    try {
      // Convert Entity to Hive Object
      final hiveProfile = profileHiveModel.toHiveModel(profile);
      // Add to Hive
      await hiveService.updateProfile(hiveProfile);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}