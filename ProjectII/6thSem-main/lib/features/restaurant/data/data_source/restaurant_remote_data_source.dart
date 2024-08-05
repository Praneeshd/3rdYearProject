import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/api_endpoint.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/core/network/remote_network/http_service.dart';
import 'package:foodrush/features/restaurant/data/dto/get_all_restaurant_dto.dart';
import 'package:foodrush/features/restaurant/data/model/restaurant.dart';
import 'package:foodrush/features/restaurant/domain/entity/restaurant_entity.dart';

final restaurantRemoteDatasourceProvider =
    Provider.autoDispose<RestaurantRemoteDataSource>(
  (ref) => RestaurantRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class RestaurantRemoteDataSource {
  final Dio dio;
  RestaurantRemoteDataSource({required this.dio});

  // Get all Restaurants with pagination
  Future<Either<Failure, List<RestaurantEntity>>> getAllRestaurant(
      int page) async {
    try {
      print(page);
      var response = await dio.get(
        ApiEndpoints.restaurants,
        queryParameters: {
          'page': page,
          '_limit': ApiEndpoints.limitPage,
        },
      );

      if (response.statusCode == 200) {
        GetAllRestaurantDTO restaurantAddDTO =
            GetAllRestaurantDTO.fromJson(response.data);
        print('error founded $restaurantAddDTO');
        List<RestaurantEntity> restaurantList = restaurantAddDTO.data
            .map((restaurant) => RestaurantAPIModel.toEntity(restaurant))
            .toList();

        return Right(restaurantList);
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
