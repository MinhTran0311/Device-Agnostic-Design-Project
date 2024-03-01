import 'dart:convert';

import 'package:flutter_application_1/injection_setup.dart';
import 'package:flutter_application_1/models/constants.dart';
import 'package:flutter_application_1/models/question.dart';
import 'package:flutter_application_1/services/question_service.dart';
import 'package:flutter_application_1/services/topic_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'question_state.dart';
part 'question_cubit.freezed.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit({
    QuestionService? questionService,
    TopicService? topicService,
  })  : _questionService = questionService ?? injector<QuestionService>(),
        _topicService = topicService ?? injector<TopicService>(),
        super(QuestionState());

  final QuestionService _questionService;
  final TopicService _topicService;

  Future<void> getQuestion(int id) async {
    emit(state.copyWith(topicId: id, loadState: LoadState.loading));

    try {
      final question = await _questionService.getQuestion(id);
      emit(state.copyWith(question: question, loadState: LoadState.success));
    } catch (e) {
      emit(state.copyWith(loadState: LoadState.failure));
    }
  }

  Future<void> checkAnswer(String answer) async {
    emit(state.copyWith(loadState: LoadState.loading));
    try {
      final result = await _questionService.checkAnswer(
          state.topicId!, state.question!.id, answer);
      emit(state.copyWith(result: result, loadState: LoadState.success));
      if (result) {
        setCorrectAnswer();
      }
    } catch (e) {
      emit(state.copyWith(loadState: LoadState.failure, result: null));
    }
  }

  Future<void> setCorrectAnswer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(resultKey)) {
      String encodedMap = prefs.getString(resultKey)!;
      Map<String, dynamic> decodedMap = json.decode(encodedMap);

      int currentScore = decodedMap[state.topicId.toString()]!;
      decodedMap[state.topicId.toString()] = currentScore + 1;

      await prefs.setString(resultKey, json.encode(decodedMap));
    }
  }

  Future<String> getTopicIdForNextQuestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(genericPracticeMode)) {
      if (prefs.getBool(genericPracticeMode)!) {
        return await _topicService.getTheFewestCorrectTopic();
      }
    }
    return state.topicId!.toString();
  }
}
