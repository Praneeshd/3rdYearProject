import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/offer/data/repository/offer_remote_repo_impl.dart';

import '../entity/offer_entity.dart';

final offerRepositoryProvider = Provider.autoDispose<IOfferRepository>(
  (ref) {
    return ref.read(offerRemoteRepositoryProvider);
  },
);

abstract class IOfferRepository {
  Future<Either<Failure, List<FoodEntity>>> getAllOffer({
    required int page,
  });
}
