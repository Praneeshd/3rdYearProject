import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/restaurant/data/data_source/restaurant_remote_data_source.dart';
import 'package:foodrush/features/restaurant/domain/entity/restaurant_entity.dart';
import 'package:foodrush/features/restaurant/domain/repository/restaurant_repository.dart';
final restaurantRemoteRepositoryProvider =
    Provider.autoDispose<IRestaurantRepository>((ref) {
  return RestaurantRemoteRepoImpl(ref.read(restaurantRemoteDatasourceProvider));
});

class RestaurantRemoteRepoImpl implements IRestaurantRepository {
  final RestaurantRemoteDataSource restaurantRemoteDataSource;

  const RestaurantRemoteRepoImpl(this.restaurantRemoteDataSource);

  @override
  Future<Either<Failure, List<RestaurantEntity>>> getAllRestaurant({
    required int page,
  }) async {
    try {
      final result = await restaurantRemoteDataSource.getAllRestaurant(page);

      return result.fold(
        (failure) => Left(failure),
        (restaurantList) => Right(restaurantList),
      );
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
