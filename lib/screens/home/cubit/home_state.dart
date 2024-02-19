part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default([]) List<TopicModel> topics,
    @Default(LoadState.initial) LoadState loadState,
  }) = _HomeState;
}
