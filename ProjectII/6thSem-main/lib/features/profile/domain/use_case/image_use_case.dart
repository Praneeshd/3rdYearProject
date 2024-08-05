import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/profile/domain/respository/profile_repository.dart';

final uploadImageUseCaseProvider = Provider.autoDispose<UploadImageUseCase>(
  (ref) => UploadImageUseCase(ref.read(profileRepositoryProvider)),
);

class UploadImageUseCase {
  final IProfileRepository profileRepository;

  UploadImageUseCase(this.profileRepository);

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await profileRepository.uploadProfilePicture(file);
  }
}