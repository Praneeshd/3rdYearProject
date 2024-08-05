

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/more/domain/entity/order_entity.dart';
import 'package:foodrush/features/more/domain/repository/order_repo_impl.dart';

final createOrderUseCaseProvider = Provider.autoDispose<CreateOrderUseCase>(
  (ref) => CreateOrderUseCase(ref.read(orderRepositoryProvider)),
);

class CreateOrderUseCase {
  final IOrderRepository _orderRepository;

  CreateOrderUseCase(this._orderRepository);

  Future<Either<Failure, bool>> createOrder(OrderEntity order) async {
    return await _orderRepository.createOrder(order);
  }
}
