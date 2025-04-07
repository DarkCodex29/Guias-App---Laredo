enum LoadingState {
  initial,
  loading,
  success,
  error,
}

class LoadingStateData<T> {
  final LoadingState state;
  final T? data;
  final String? error;

  const LoadingStateData({
    this.state = LoadingState.initial,
    this.data,
    this.error,
  });

  factory LoadingStateData.initial() => const LoadingStateData();

  factory LoadingStateData.loading() =>
      const LoadingStateData(state: LoadingState.loading);

  factory LoadingStateData.success(T data) => LoadingStateData(
        state: LoadingState.success,
        data: data,
      );

  factory LoadingStateData.error(String error) => LoadingStateData(
        state: LoadingState.error,
        error: error,
      );

  LoadingStateData<T> copyWith({
    LoadingState? state,
    T? data,
    String? error,
  }) {
    return LoadingStateData<T>(
      state: state ?? this.state,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  bool get isLoading => state == LoadingState.loading;
  bool get isSuccess => state == LoadingState.success;
  bool get isError => state == LoadingState.error;
  bool get isInitial => state == LoadingState.initial;
}
