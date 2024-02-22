import 'dart:convert';

import 'package:flutter_application_1/injection_setup.dart';
import 'package:flutter_application_1/models/constants.dart';
import 'package:flutter_application_1/services/topic_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'statistic_state.dart';
part 'statistic_cubit.freezed.dart';

class StatisticCubit extends Cubit<StatisticState> {
  StatisticCubit() : super(StatisticState());

  final _topicService = injector<TopicService>();

  Future<void> getResult() async {
    emit(state.copyWith(loadState: LoadState.loading));
    Map<String, int> results = {};

    final topics = await _topicService.getTopics();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedMap = prefs.getString(resultKey)!;

    final mapOfResult = Map<String, int>.from(json.decode(encodedMap));

    for (int i = 0; i < mapOfResult.length; i++) {
      String currentId = mapOfResult.keys.elementAt(i);
      String topicName = topics
          .where((element) => element.id.toString() == currentId)
          .first
          .name;
      int topicScore = mapOfResult[currentId]!;
      results[topicName] = topicScore;
    }

    emit(state.copyWith(loadState: LoadState.success, results: results));
  }
}
