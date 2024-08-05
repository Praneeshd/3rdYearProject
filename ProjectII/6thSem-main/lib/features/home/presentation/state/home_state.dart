import 'package:foodrush/features/home/domain/entity/home_entity.dart';

class HomeState {
  final bool isLoading;
  final List<HomeEntity> homes;
  final bool showMessage;
  final int page;
  final bool hasReachedMax;

  HomeState({
    required this.isLoading,
    required this.homes,
    required this.showMessage,
    required this.page,
    required this.hasReachedMax,
  });

  factory HomeState.initialState() => HomeState(
        isLoading: false,
        homes: [],
        showMessage: false,
        page: 0,
        hasReachedMax: false,
      );

  HomeState copyWith({
    bool? isLoading,
    List<HomeEntity>? homes,
    bool? showMessage,
    int? page,
    bool? hasReachedMax,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      homes: homes ?? this.homes,
      showMessage: showMessage ?? this.showMessage,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
