part of 'question_cubit.dart';

@freezed
class QuestionState with _$QuestionState {
  factory QuestionState({
    int? topicId,
    QuestionModel? question,
    bool? result,
    @Default(LoadState.initial) LoadState loadState,
  }) = _QuestionState;
}
