enum LoadState {
  initial,
  loading,
  success,
  failure,
  loadingMore;

  const LoadState();

  bool get isLoading => this == LoadState.loading;
  bool get isFailed => this == LoadState.failure;
}
