import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/offer/data/data_source/offers_data_source.dart';
import 'package:foodrush/features/offer/domain/entity/offer_entity.dart';
import 'package:foodrush/features/offer/domain/repository/offer_repository.dart';

final offerRemoteRepositoryProvider =
    Provider.autoDispose<IOfferRepository>((ref) {
  return OfferRemoteRepoImpl(ref.read(offerRemoteDatasourceProvider));
});

class OfferRemoteRepoImpl implements IOfferRepository {
  final OfferRemoteDataSource offerRemoteDataSource;

  const OfferRemoteRepoImpl(this.offerRemoteDataSource);

  @override
  Future<Either<Failure, List<FoodEntity>>> getAllOffer({
    required int page,
  }) async {
    try {
      final result = await offerRemoteDataSource.getAllOffer(page);

      return result.fold(
        (failure) => Left(failure),
        (offerList) => Right(offerList),
      );
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
