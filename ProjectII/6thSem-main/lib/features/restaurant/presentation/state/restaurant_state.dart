

import 'package:foodrush/features/restaurant/domain/entity/restaurant_entity.dart';

class RestaurantState {
  final bool isLoading;
  final List<RestaurantEntity> restaurants;
  final bool showMessage;
  final int page;
  final bool hasReachedMax;

  RestaurantState({
    required this.isLoading,
    required this.restaurants,
    required this.showMessage,
    required this.page,
    required this.hasReachedMax,
  });

  factory RestaurantState.initialState() => RestaurantState(
        isLoading: false,
        restaurants: [],
        showMessage: false,
        page: 0,
        hasReachedMax: false,
      );

  RestaurantState copyWith({
    bool? isLoading,
    List <RestaurantEntity>? restaurants,
    bool? showMessage,
    int? page,
    bool? hasReachedMax,
  }) {
    return RestaurantState(
      isLoading: isLoading ?? this.isLoading,
      restaurants: restaurants ?? this.restaurants,
      showMessage: showMessage ?? this.showMessage,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
