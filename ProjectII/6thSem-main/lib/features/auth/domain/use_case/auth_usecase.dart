import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/auth/domain/entity/auth_entity.dart';
import 'package:foodrush/features/auth/domain/repository/auth_repository.dart';

final userUseCaseProvider = Provider((ref) {
  return UserUseCase(ref.read(userRepositoryProvider));
});

class UserUseCase {
  final IUserRepository _userRepository;

  UserUseCase(this._userRepository);

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    return await _userRepository.registerUser(user);
  }

  Future<Either<Failure, bool>> loginUser(String email, String password) async {
    return await _userRepository.loginUser(email, password);
  }
}
