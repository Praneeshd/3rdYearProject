import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/auth/domain/repository/auth_repository.dart';

final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
  (ref) => LoginUseCase(ref.watch(userRepositoryProvider)),
);

class LoginUseCase {
  final IUserRepository _userRepository;

  LoginUseCase(this._userRepository);

  Future<Either<Failure, bool>> loginUser(
    String email,
    String password,
  ) async {
    return await _userRepository.loginUser(email, password);
  }
}
