part of 'statistic_cubit.dart';

@freezed
class StatisticState with _$StatisticState {
  factory StatisticState({
    @Default({}) Map<String, dynamic> results,
    @Default(LoadState.initial) LoadState loadState,
  }) = _StatisticState;
}
