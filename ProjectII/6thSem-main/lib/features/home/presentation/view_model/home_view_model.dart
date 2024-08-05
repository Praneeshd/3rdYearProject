
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/features/home/domain/use_case/get_all_home_usecase.dart';
import 'package:foodrush/features/home/presentation/state/home_state.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(
    getAllHomeUsecase: ref.read(GetAllHomeUsecaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final GetAllHomeUsecase getAllHomeUsecase;

  HomeViewModel({
    required this.getAllHomeUsecase,
  }) : super(HomeState.initialState()) {
    getAllHome();
  }
  Future resetState() async {
    state = HomeState.initialState();
    getAllHome();
  }

  Future<void> getAllHome() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final homes = currentState.homes;
    final hasReachedMax = currentState.hasReachedMax;

    if (!hasReachedMax) {
      try {
        // get data from data source
        final result = await getAllHomeUsecase.getAllHome(page);
        result.fold(
          (failure) {
            state = state.copyWith(hasReachedMax: true, isLoading: false);
          },
          (data) {
            if (data.isEmpty) {
              state = state.copyWith(hasReachedMax: true);
            } else {
              state = state.copyWith(
                homes: [...homes, ...data],
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

  void getAllRestaurant() {}
}
