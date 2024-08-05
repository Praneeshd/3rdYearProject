import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/features/offer/domain/entity/offer_entity.dart';
import 'package:foodrush/features/offer/domain/repository/offer_repository.dart';

import '../../../../core/failure/failure.dart';

final GetAllOfferUsecaseProvider = Provider.autoDispose<GetAllOfferUsecase>(
  (ref) => GetAllOfferUsecase(repository: ref.read(offerRepositoryProvider)),
);

class GetAllOfferUsecase {
  final IOfferRepository repository;

  GetAllOfferUsecase({required this.repository});

  Future<Either<Failure, List<FoodEntity>>> getAllOffer(int page) async {
    return await repository.getAllOffer(page: page);
  }
}
