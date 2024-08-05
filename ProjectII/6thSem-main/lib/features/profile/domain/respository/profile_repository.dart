import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/common/provider/is_network_provider.dart';
import 'package:foodrush/features/profile/domain/entity/profile_enity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/profile_local_repo.dart';
import '../../data/repository/profile_remote_repo.dart';


final profileRepositoryProvider = Provider<IProfileRepository>(
  (ref) {
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (internetStatus == ConnectivityStatus.isConnected) {
      print("INTERNET ACCESS");
      // If internet is available then return remote repo
      return ref.watch(profileRemoteRepoProvider);
    } else {
      print("NO INTERNET ACCESS");
      // If internet is not available then return local repo
      return ref.watch(profileLocalRepoProvider);
    }
  },
);

abstract class IProfileRepository {
  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile);
  Future<Either<Failure, List<ProfileEntity>>> getUser();
   Future<Either<Failure, String>> uploadProfilePicture(File file);

}