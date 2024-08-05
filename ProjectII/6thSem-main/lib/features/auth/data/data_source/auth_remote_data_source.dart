import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/api_endpoint.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/core/network/remote_network/http_service.dart';
import 'package:foodrush/core/shared_prefs/user_shared_prefs.dart';
import 'package:foodrush/features/auth/data/model/auth_api_model.dart';
import 'package:foodrush/features/auth/domain/entity/auth_entity.dart';

final userRemoteDataSourceProvider = Provider(
  (ref) => UserRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class UserRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  UserRemoteDataSource({required this.userSharedPrefs, required this.dio});

  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      AuthApiModel apiModel = AuthApiModel.fromEntity(user);
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          "firstName": apiModel.firstName,
          "lastName": apiModel.lastName,
          "email": apiModel.email,
          "password": apiModel.password,
        },
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> loginUser(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        }, 
      );
      if (response.statusCode == 200) {
        // retrieve token
        String token = response.data["token"];
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
