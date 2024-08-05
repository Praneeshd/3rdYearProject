class OrderState {
  final bool isLoading;
  final String? error;
  final bool showMessage;

  OrderState({
    required this.isLoading,
    this.error,
    required this.showMessage,
  });

  factory OrderState.initial() {
    return OrderState(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }

  OrderState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
    );
  }

  @override
  String toString() => 'OrderState(isLoading: $isLoading, error: $error)';
}
