import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/auth/data/repository/auth_remote_repository.dart';
import 'package:foodrush/features/auth/domain/entity/auth_entity.dart';

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  return ref.read(userRemoteRepositoryProvider);
});

abstract class IUserRepository {
  Future<Either<Failure, bool>> registerUser(AuthEntity user);

  Future<Either<Failure, bool>> loginUser(String email, String password);
}
