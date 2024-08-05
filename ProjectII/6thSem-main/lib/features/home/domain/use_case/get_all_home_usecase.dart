import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/features/home/domain/entity/home_entity.dart';
import 'package:foodrush/features/home/domain/repository/home_repository.dart';

import '../../../../core/failure/failure.dart';

final GetAllHomeUsecaseProvider = Provider.autoDispose<GetAllHomeUsecase>(
  (ref) => GetAllHomeUsecase(repository: ref.read(homeRepositoryProvider)),
);

class GetAllHomeUsecase {
  final IHomeRepository repository;

  GetAllHomeUsecase({required this.repository});

  Future<Either<Failure, List<HomeEntity>>> getAllHome(int page) async {
    return await repository.getAllHome(page: page);
  }
}
