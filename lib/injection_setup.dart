import 'package:flutter_application_1/services/network/api_service.dart';
import 'package:flutter_application_1/services/network/dio_provider.dart';
import 'package:flutter_application_1/services/question_service.dart';
import 'package:flutter_application_1/services/topic_service.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector
    ..registerFactories()
    ..registerLazySingletons()
    ..registerSingletons();
}

extension InjectorExtensions on GetIt {
  void registerFactories() {
    registerFactory<TopicService>(TopicService.new);
    registerFactory<QuestionService>(QuestionService.new);
  }

  void registerLazySingletons() {}

  void registerSingletons() {
    registerSingleton<DioProvider>(DioProvider());
    registerSingleton<ApiService>(ApiService(get<DioProvider>().getInstance()));
  }
}
