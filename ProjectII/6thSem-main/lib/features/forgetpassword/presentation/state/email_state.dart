class EmailState {
  final bool isLoading;
  final String? error;
  final bool? showMessage;

  EmailState({
    required this.isLoading,
    this.error,
    this.showMessage,
  });

  factory EmailState.initial() {
    return EmailState(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }

  EmailState copyWith({
    bool? isLoading,
    String? error,
    String? imageName,
    bool? showMessage,
  }) {
    return EmailState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
    );
  }

  @override
  String toString() => 'EmailState(isLoading: $isLoading, error: $error)';
}
