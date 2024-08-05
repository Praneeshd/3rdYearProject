import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/core/network/local_network/hive_service.dart';
import 'package:foodrush/features/auth/data/model/auth_hive_model.dart';
import 'package:foodrush/features/auth/domain/entity/auth_entity.dart';

final userLocalDataSourceProvider = Provider(
  (ref) => UserLocalDataSource(
    ref.read(hiveServiceProvider),
    ref.read(userHiveModelProvider),
  ),
);

class UserLocalDataSource {
  final HiveService _hiveService;
  final AuthHiveModel _userHiveModel;

  UserLocalDataSource(this._hiveService, this._userHiveModel);

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      await _hiveService.addUser(_userHiveModel.toHiveModel(user));
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> loginUser(
    String email,
    String password,
  ) async {
    try {
      AuthHiveModel? users = await _hiveService.login(email, password);
     if (users == null) {
        return Left(Failure(error: 'Email or password is wrong'));
      } else {
        return const Right(true);
      }
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
