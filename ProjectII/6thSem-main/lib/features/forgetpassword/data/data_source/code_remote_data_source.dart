import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/api_endpoint.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/core/network/remote_network/http_service.dart';
import 'package:foodrush/core/shared_prefs/user_shared_prefs.dart';

final resetCodeRemoteDataSourceProvider = Provider(
  (ref) => CodeRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class CodeRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  CodeRemoteDataSource({required this.userSharedPrefs, required this.dio});

  Future<Either<Failure, bool>> sendresetCodeUser(
    int resetCode,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.sendcode,
        data: {
          "restCode": resetCode,
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
