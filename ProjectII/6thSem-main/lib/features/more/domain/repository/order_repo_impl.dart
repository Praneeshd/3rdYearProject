import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/more/data/repository/order_remote_repository.dart';
import 'package:foodrush/features/more/domain/entity/order_entity.dart';

final orderRepositoryProvider = Provider<IOrderRepository>((ref) {
  return ref.read(orderRemoteRepositoryProvider);
});

abstract class IOrderRepository {
  Future<Either<Failure, bool>> createOrder(OrderEntity order);
}
