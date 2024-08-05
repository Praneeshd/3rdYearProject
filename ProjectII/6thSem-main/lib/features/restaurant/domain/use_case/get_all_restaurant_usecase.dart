import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/features/restaurant/domain/entity/restaurant_entity.dart';
import 'package:foodrush/features/restaurant/domain/repository/restaurant_repository.dart';

import '../../../../core/failure/failure.dart';

final GetAllRestaurantUsecaseProvider = Provider.autoDispose<GetAllRestaurantUsecase>(
  (ref) => GetAllRestaurantUsecase(repository: ref.read(restaurantRepositoryProvider)),
);

class GetAllRestaurantUsecase {
  final IRestaurantRepository repository;

  GetAllRestaurantUsecase({required this.repository});

  Future<Either<Failure, List<RestaurantEntity>>> getAllRestaurant(int page) async {
    return await repository.getAllRestaurant(page: page);
  }
}
