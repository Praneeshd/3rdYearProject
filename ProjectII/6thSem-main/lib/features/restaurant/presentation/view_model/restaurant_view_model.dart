import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/features/restaurant/domain/use_case/get_all_restaurant_usecase.dart';
import 'package:foodrush/features/restaurant/presentation/state/restaurant_state.dart';

final restaurantViewModelProvider =
    StateNotifierProvider.autoDispose<RestaurantViewModel, RestaurantState>(
  (ref) => RestaurantViewModel(
    getAllRestaurantUsecase: ref.read(GetAllRestaurantUsecaseProvider),
  ),
);

class RestaurantViewModel extends StateNotifier<RestaurantState> {
  final GetAllRestaurantUsecase getAllRestaurantUsecase;

  RestaurantViewModel({
    required this.getAllRestaurantUsecase,
  }) : super(RestaurantState.initialState()) {
    getAllRestaurant();
  }
  Future resetState() async {
    state = RestaurantState.initialState();
    getAllRestaurant();
  }

  Future<void> getAllRestaurant() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final restaurants = currentState.restaurants;
    final hasReachedMax = currentState.hasReachedMax;

    if (!hasReachedMax) {
      try {
        // get data from data source
        final result = await getAllRestaurantUsecase.getAllRestaurant(page);
        result.fold(
          (failure) {
            state = state.copyWith(hasReachedMax: true, isLoading: false);
          },
          (data) {
            if (data.isEmpty) {
              state = state.copyWith(hasReachedMax: true);
            } else {
              state = state.copyWith(
                restaurants: [...restaurants, ...data],
                page: page,
                isLoading: false,
              );
            }
          },
        );
      } catch (e) {
        state = state.copyWith(hasReachedMax: true, isLoading: false);
      }
    }
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
