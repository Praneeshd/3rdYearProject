import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/config/constants/api_endpoint.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/core/network/remote_network/http_service.dart';
import 'package:foodrush/features/offer/data/dto/get_all_offer_dto.dart';
import 'package:foodrush/features/offer/data/model/offers.dart';
import 'package:foodrush/features/offer/domain/entity/offer_entity.dart';

final offerRemoteDatasourceProvider =
    Provider.autoDispose<OfferRemoteDataSource>(
  (ref) => OfferRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class OfferRemoteDataSource {
  final Dio dio;
  OfferRemoteDataSource({required this.dio});

  // Get all Offers with pagination
  Future<Either<Failure, List<FoodEntity>>> getAllOffer(int page) async {
    try {
      print(page);
      var response = await dio.get(
        ApiEndpoints.offers,
        queryParameters: {
          'page': page,
          '_limit': ApiEndpoints.limitPage,
        },
      );
      print(response.data);

      // print("API Response Data: ${response.data}");

      if (response.statusCode == 200) {
        GetAllOfferDTO offerAddDTO = GetAllOfferDTO.fromJson(response.data);
        print('error founded $offerAddDTO');
        List<FoodEntity> offerList = offerAddDTO.data
            .map((offer) => OfferAPIModel.toEntity(offer))
            .toList();

        return Right(offerList);
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
