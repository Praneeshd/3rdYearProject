import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/network/remote_network/http_service.dart';
import 'package:foodrush/core/shared_prefs/user_shared_prefs.dart';
import 'package:foodrush/features/profile/data/dto/update_dto.dart';
import 'package:foodrush/features/profile/data/model/profile_api_model.dart';
import 'package:foodrush/features/profile/domain/entity/profile_enity.dart';
import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';

final profileRemoteDataSourceProvider = Provider(
  (ref) => ProfileRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class ProfileRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  ProfileRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile) async {
    try {
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));

      FormData formData = FormData.fromMap({
        'firstName': profile.firstName,
        'lastName': profile.lastName,
        'number': profile.number,
      });

      var response = await dio.post(
        ApiEndpoints.updateProfile,
        data: formData,
        options: Options(
          headers: {
            'Authorization': '$token',
          },
        ),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<ProfileEntity>>> getUser() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      String? userId;
      var data0 = await userSharedPrefs.getUserId();
      data0.fold(
        (l) => userId = null,
        (r) => userId = r!,
      );

      var response = await dio.get(
        ApiEndpoints.getUser + userId!,
        options: Options(
          headers: {
            'Authorization': '$token',
          },
        ),
      );

      if (response.statusCode == 200) {
        GetAllProfileDTO profileAddDTO =
            GetAllProfileDTO.fromJson(response.data);
        List<ProfileApiModel> profileList = profileAddDTO.data
            .map((profile) => ProfileApiModel.toEntity(profile))
            .toList();

        return Right(profileList.cast<ProfileEntity>());
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

  // Upload image using multipart
  Future<Either<Failure, String>> uploadProfilePicture(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      return Right(response.data["data"]);
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
