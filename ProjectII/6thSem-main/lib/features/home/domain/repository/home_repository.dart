import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/home/data/repository/home_remote_repo_impl.dart';
import 'package:foodrush/features/home/domain/entity/home_entity.dart';

final homeRepositoryProvider = Provider.autoDispose<IHomeRepository>(
  (ref) {
    return ref.read(homeRemoteRepositoryProvider);
  },
);

abstract class IHomeRepository {
  Future<Either<Failure, List<HomeEntity>>> getAllHome({
    required int page,
  });
}
