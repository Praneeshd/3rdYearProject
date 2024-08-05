import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/router/app_route.dart';
import 'package:foodrush/features/auth/domain/entity/auth_entity.dart';
import 'package:foodrush/features/auth/domain/use_case/auth_usecase.dart';
import 'package:foodrush/features/auth/domain/use_case/login_usecase.dart';
import 'package:foodrush/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
      ref.read(userUseCaseProvider), ref.read(loginUseCaseProvider)),
);

class AuthViewModel extends StateNotifier<AuthState> {
  final UserUseCase _userUseCase;
  final LoginUseCase _loginUseCase;

  AuthViewModel(this._userUseCase, this._loginUseCase)
      : super(AuthState.initial());

  Future<void> registerUser(AuthEntity entity) async {
    state = state.copyWith(isLoading: true);
    final result = await _userUseCase.registerUser(entity);
    state = state.copyWith(isLoading: false);
    result.fold(
      (failure) => state = state.copyWith(error: failure.error),
      (success) => state = state.copyWith(isLoading: false, showMessage: true),
    );
  }

  //Login
  Future<void> loginuser(
      BuildContext context, String email, String password) async {
    state = state.copyWith(isLoading: true);
    final result = await _loginUseCase.loginUser(email, password);
    state = state.copyWith(isLoading: false);
    result.fold(
      (failure) => state = state.copyWith(
        error: failure.error,
        showMessage: true,
      ),
      (success) {
        state = state.copyWith(
          isLoading: false,
          showMessage: false,
          error: null,
        );

        Navigator.popAndPushNamed(context, AppRoute.homeRoute);
      },
    );
  }

  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
