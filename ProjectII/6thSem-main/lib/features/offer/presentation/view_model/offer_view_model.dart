
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodrush/features/offer/domain/use_case/get_all_usecase.dart';
import 'package:foodrush/features/offer/presentation/state/offer_state.dart';

final offerViewModelProvider =
    StateNotifierProvider.autoDispose<OfferViewModel, OfferState>(
  (ref) => OfferViewModel(
    getAllOfferUsecase: ref.read(GetAllOfferUsecaseProvider),
  ),
);

class OfferViewModel extends StateNotifier<OfferState> {
  final GetAllOfferUsecase getAllOfferUsecase;

  OfferViewModel({
    required this.getAllOfferUsecase,
  }) : super(OfferState.initialState()) {
    getAllOffer();
  }
  Future resetState() async {
    state = OfferState.initialState();
    getAllOffer();
  }

  Future<void> getAllOffer() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final offers = currentState.offers;
    final hasReachedMax = currentState.hasReachedMax;

    if (!hasReachedMax) {
      try {
        // get data from data source
        final result = await getAllOfferUsecase.getAllOffer(page);
        result.fold(
          (failure) {
            state = state.copyWith(hasReachedMax: true, isLoading: false);
          },
          (data) {
            if (data.isEmpty) {
              state = state.copyWith(hasReachedMax: true);
            } else {
              state = state.copyWith(
                offers: [...offers, ...data],
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
