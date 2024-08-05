import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/api_endpoint.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/core/network/remote_network/http_service.dart';
import 'package:foodrush/core/shared_prefs/user_shared_prefs.dart';
import 'package:foodrush/features/more/data/model/order_api_model.dart';
import 'package:foodrush/features/more/domain/entity/order_entity.dart';

final orderRemoteDataSourceProvider = Provider(
  (ref) => OrderRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class OrderRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  OrderRemoteDataSource({required this.userSharedPrefs, required this.dio});
  Future<Either<Failure, bool>> createOrder(OrderEntity order) async {
    try {
      // Convert your OrderEntity to the API model if needed
      OrderApiModel apiModel = OrderApiModel.fromEntity(order);

      // Make a POST request to create an order
      Response response = await dio.post(
        ApiEndpoints.createOrder,
        data: {
          "foodName": apiModel.foodName,
          "order": apiModel.quantity,
          "orderprice": apiModel.foodPrice
        },
      );

      if (response.statusCode == 201) {
        // 201 is usually used for successful creation
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
