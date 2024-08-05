import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/features/profile/domain/entity/profile_enity.dart';
import 'package:foodrush/features/profile/domain/use_case/image_use_case.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/use_case/profile_use_case.dart';
import '../state/profile_state.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>(
  (ref) {
    return ProfileViewModel(
      profileUseCase: ref.read(profileUsecaseProvider),
      uploadImageUseCase: ref.read(uploadImageUseCaseProvider),
    );
  },
);

class ProfileViewModel extends StateNotifier<ProfileState> {
  final ProfileUseCase profileUseCase;
  final UploadImageUseCase _uploadImageUsecase;

  ProfileViewModel({
    required this.profileUseCase,
    required UploadImageUseCase uploadImageUseCase,
  })  : _uploadImageUsecase = uploadImageUseCase,
        super(ProfileState.initial()) {
    getUser(); // Call getUser during initialization
  }


  void updateProfile(BuildContext context, ProfileEntity profile) async {
    state = state.copyWith(isLoading: true);
    var data = await profileUseCase.updateProfile(profile);

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Profile Updated Successfully',
          context: context,
          color: Colors.green,
        );
      },
    );
  }

  void getUser() async {
    state = state.copyWith(isLoading: true);
    var data = await profileUseCase.getUser();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, profiles: r),
    );
  }

  Future<void> uploadImage(File file) async {
    state = state.copyWith(isLoading: true);
    var data = await _uploadImageUsecase.uploadProfilePicture(file);

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          imageName: imageName,
        );
      },
    );
  }
}
