import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/router/app_route.dart';
import 'package:foodrush/features/forgetpassword/domain/usecase/sendemail_usecase.dart';
import 'package:foodrush/features/forgetpassword/presentation/state/email_state.dart';

final emailViewModelProvider =
    StateNotifierProvider<EmailViewModel, EmailState>(
  (ref) => EmailViewModel(ref.read(emailUseCaseProvider)),
);

class EmailViewModel extends StateNotifier<EmailState> {
  final EmailUseCase _emailUseCase;

  EmailViewModel(this._emailUseCase) : super(EmailState.initial());

  Future<void> sendemailuser(BuildContext context, String email) async {
    state = state.copyWith(isLoading: true);
    print(email);
    final result = await _emailUseCase.sendemailUser(email);
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
        Navigator.popAndPushNamed(context, AppRoute.codeRoute,
         arguments: {
    'email': email,
  });
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
