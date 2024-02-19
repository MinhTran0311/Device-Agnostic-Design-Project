import 'package:flutter_application_1/injection_setup.dart';
import 'package:flutter_application_1/models/constants.dart';
import 'package:flutter_application_1/models/topic.dart';
import 'package:flutter_application_1/services/question_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  final _questionService = injector<QuestionService>();

  Future<void> getTopics() async {
    emit(state.copyWith(loadState: LoadState.loading));
    try {
      final topics = await _questionService.getTopics();
      emit(state.copyWith(topics: topics, loadState: LoadState.success));
    } catch (e) {
      emit(state.copyWith(loadState: LoadState.failure));
    }
  }
}
