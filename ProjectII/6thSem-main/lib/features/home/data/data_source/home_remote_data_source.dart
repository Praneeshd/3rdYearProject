import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/api_endpoint.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/core/network/remote_network/http_service.dart';
import 'package:foodrush/features/home/data/dto/get_all_home_dto.dart';
import 'package:foodrush/features/home/data/model/home.dart';
import 'package:foodrush/features/home/domain/entity/home_entity.dart';

final homeRemoteDatasourceProvider = Provider.autoDispose<HomeRemoteDataSource>(
  (ref) => HomeRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class HomeRemoteDataSource {
  final Dio dio;
  HomeRemoteDataSource({required this.dio});

  // Get all Offers with pagination
  Future<Either<Failure, List<HomeEntity>>> getAllHome(int page) async {
    try {
      print(page);
      var response = await dio.get(
        ApiEndpoints.foods,
        queryParameters: {
          'page': page,
          '_limit': ApiEndpoints.limitPage,
        },
      );

      if (response.statusCode == 200) {
        GetAllHomeDTO homeAddDTO = GetAllHomeDTO.fromJson(response.data);
        print('error founded $homeAddDTO');
        List<HomeEntity> homeList =
            homeAddDTO.data.map((home) => HomeAPIModel.toEntity(home)).toList();

        return Right(homeList);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
