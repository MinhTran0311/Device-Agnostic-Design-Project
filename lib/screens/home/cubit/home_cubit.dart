import 'dart:convert';

import 'package:flutter_application_1/injection_setup.dart';
import 'package:flutter_application_1/models/constants.dart';
import 'package:flutter_application_1/models/topic.dart';
import 'package:flutter_application_1/services/topic_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  final _topicService = injector<TopicService>();

  Future<void> getTopics() async {
    emit(state.copyWith(loadState: LoadState.loading));
    try {
      final topics = await _topicService.getTopics();
      emit(state.copyWith(topics: topics, loadState: LoadState.success));
      await saveTopicIds();
    } catch (e) {
      emit(state.copyWith(loadState: LoadState.failure));
    }
  }

  Future<void> saveTopicIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map<String, int> topicsMap = {};

    state.topics.forEach((element) {
      topicsMap[element.id.toString()] = 0;
    });
    if (!prefs.containsKey(genericPracticeMode)) {
      await prefs.setString(resultKey, json.encode(topicsMap));
    }
  }

  Future<String> getTheFewestCorrectTopic() async {
    await setGenericMode(true);
    return await _topicService.getTheFewestCorrectTopic();
  }

  Future<void> setGenericMode(bool mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(genericPracticeMode, mode);
  }
}
