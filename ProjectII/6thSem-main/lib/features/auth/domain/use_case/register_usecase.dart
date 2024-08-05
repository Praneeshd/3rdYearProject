import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/auth/domain/entity/auth_entity.dart';
import 'package:foodrush/features/auth/domain/repository/auth_repository.dart';

final registerUseCaseProvider = Provider.autoDispose<RegisterUseCase>(
  (ref) => RegisterUseCase(ref.read(userRepositoryProvider)),
);

class RegisterUseCase {
  final IUserRepository _userRepository;

  RegisterUseCase(this._userRepository);

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    return await _userRepository.registerUser(user);
  }
}
