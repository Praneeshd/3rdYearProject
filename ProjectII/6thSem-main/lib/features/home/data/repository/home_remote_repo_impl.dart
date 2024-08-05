import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/home/data/data_source/home_remote_data_source.dart';
import 'package:foodrush/features/home/domain/entity/home_entity.dart';
import 'package:foodrush/features/home/domain/repository/home_repository.dart';

final homeRemoteRepositoryProvider =
    Provider.autoDispose<IHomeRepository>((ref) {
  return HomeRemoteRepoImpl(ref.read(homeRemoteDatasourceProvider));
});

class HomeRemoteRepoImpl implements IHomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  const HomeRemoteRepoImpl(this.homeRemoteDataSource);

  @override
  Future<Either<Failure, List<HomeEntity>>> getAllHome({
    required int page,
  }) async {
    try {
      final result = await homeRemoteDataSource.getAllHome(page);

      return result.fold(
        (failure) => Left(failure),
        (homeList) => Right(homeList),
      );
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
