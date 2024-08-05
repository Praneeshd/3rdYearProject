import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/restaurant/data/repository/restaurant_remote_impl.dart';
import 'package:foodrush/features/restaurant/domain/entity/restaurant_entity.dart';

final restaurantRepositoryProvider = Provider.autoDispose<IRestaurantRepository>(
  (ref) {
    return ref.read(restaurantRemoteRepositoryProvider);
  },
);

abstract class IRestaurantRepository {
  Future<Either<Failure, List<RestaurantEntity>>> getAllRestaurant({
    required int page,
  });
}
