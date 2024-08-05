import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/forgetpassword/domain/repository/email_repository.dart';

final emailUseCaseProvider = Provider.autoDispose<EmailUseCase>(
  (ref) => EmailUseCase(ref.watch(emailRepositoryProvider)),
);

class EmailUseCase {
  final IEmailRepository _emailRepository;

  EmailUseCase(this._emailRepository);

  Future<Either<Failure, bool>> sendemailUser(
    String email,
  ) async {
    
    return await _emailRepository.sendemailUser(email);
  }
}
