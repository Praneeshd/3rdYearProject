import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/router/app_route.dart';
import 'package:foodrush/features/forgetpassword/domain/usecase/sendcode_usecase.dart';
import 'package:foodrush/features/forgetpassword/presentation/state/email_state.dart';

final resetCodeViewModelProvider =
    StateNotifierProvider<CodeViewModel, EmailState>(
  (ref) => CodeViewModel(ref.read(codeUseCaseProvider)),
);

class CodeViewModel extends StateNotifier<EmailState> {
  final CodeUseCase _codeUseCase;

  CodeViewModel(this._codeUseCase) : super(EmailState.initial());

  Future<void> sendresetCode(BuildContext context, int resetCode, String email) async {
    state = state.copyWith(isLoading: true);
    final result = await _codeUseCase.sendresetCodeUser(resetCode , email);
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
        Navigator.popAndPushNamed(context, AppRoute.changepasswordRoute);
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
