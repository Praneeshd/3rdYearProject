import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:foodrush/features/auth/domain/entity/auth_entity.dart';
import 'package:foodrush/features/auth/domain/repository/auth_repository.dart';

final userRemoteRepositoryProvider = Provider<IUserRepository>((ref) {
  return UserRemoteRepositoy(
    ref.read(userRemoteDataSourceProvider),
  );
});

class UserRemoteRepositoy implements IUserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  UserRemoteRepositoy(this._userRemoteDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return _userRemoteDataSource.loginUser(email, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) {
    return _userRemoteDataSource.registerUser(user);
  }
}
