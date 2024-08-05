// Assuming you have an OrderEntity class
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/core/failure/failure.dart';
import 'package:foodrush/features/more/data/data_source/add_to_cart_data_source.dart';
import 'package:foodrush/features/more/domain/entity/order_entity.dart';
import 'package:foodrush/features/more/domain/repository/order_repo_impl.dart';

final orderRemoteRepositoryProvider = Provider<IOrderRepository>((ref) {
  return OrderRemoteRepository(
    ref.read(orderRemoteDataSourceProvider),
  );
});

class OrderRemoteRepository implements IOrderRepository {
  final OrderRemoteDataSource _orderRemoteDataSource;
  OrderRemoteRepository(this._orderRemoteDataSource);

  @override
  Future<Either<Failure, bool>> createOrder(OrderEntity order) {
    return _orderRemoteDataSource.createOrder(order);
  }
}
