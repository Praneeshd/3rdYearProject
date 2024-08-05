import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/features/more/domain/entity/order_entity.dart';
import 'package:foodrush/features/more/domain/usecase/order_usecase.dart';
import 'package:foodrush/features/more/presentaion/state/order_state.dart';


final orderViewModelProvider = StateNotifierProvider<OrderViewModel, OrderState>(
  (ref) => OrderViewModel(
      ref.read(createOrderUseCaseProvider )),
);

class OrderViewModel extends StateNotifier<OrderState> {
  final CreateOrderUseCase _createOrderUseCase;

  OrderViewModel(this._createOrderUseCase) : super(OrderState.initial());

  Future<void> createOrder(OrderEntity order) async {
    state = state.copyWith(isLoading: true);
    final result = await _createOrderUseCase.createOrder(order);
    state = state.copyWith(isLoading: false);
    result.fold(
      (failure) => state = state.copyWith(
        error: failure.error,
        showMessage: true,
      ),
      (success) {
        state = state.copyWith(
          isLoading: false,
          showMessage: false,
          error: null,
        ); 
      },
      
    );
  }

  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }
    void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
