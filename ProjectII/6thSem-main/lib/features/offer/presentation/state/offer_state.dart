import 'package:foodrush/features/offer/domain/entity/offer_entity.dart';

class OfferState {
  final bool isLoading;
  final List<FoodEntity> offers;
  final bool showMessage;
  final int page;
  final bool hasReachedMax;

  OfferState({
    required this.isLoading,
    required this.offers,
    required this.showMessage,
    required this.page,
    required this.hasReachedMax,
  });

  factory OfferState.initialState() => OfferState(
        isLoading: false,
        offers: [],
        showMessage: false,
        page: 0,
        hasReachedMax: false,
      );

  OfferState copyWith({
    bool? isLoading,
    List<FoodEntity>? offers,
    bool? showMessage,
    int? page,
    bool? hasReachedMax,
  }) {
    return OfferState(
      isLoading: isLoading ?? this.isLoading,
      offers: offers ?? this.offers,
      showMessage: showMessage ?? this.showMessage,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
