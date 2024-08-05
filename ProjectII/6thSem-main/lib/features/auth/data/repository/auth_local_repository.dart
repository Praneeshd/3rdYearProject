import 'package:dartz/dartz.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:foodrush/features/auth/domain/entity/auth_entity.dart';
import 'package:foodrush/features/auth/domain/repository/auth_repository.dart';

class UserLocalRepository implements IUserRepository {
  final UserLocalDataSource _userLocalDataSource;

  UserLocalRepository(this._userLocalDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) {
    return _userLocalDataSource.loginUser(email, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(AuthEntity user) {
    return _userLocalDataSource.registerUser(user);
  }
}
