import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/constants.dart';
import 'package:flutter_application_1/models/topic.dart';
import 'package:flutter_application_1/screens/home/cubit/home_cubit.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:flutter_application_1/services/topic_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'home_screen_test.mocks.dart';

@GenerateMocks([TopicService])
void main() {
  final topics = [
    TopicModel(id: 1, name: 'Test 1', questionPath: '123'),
    TopicModel(id: 2, name: 'Test 2', questionPath: '123'),
  ];
  group('HomeScreen Tests', () {
    late HomeCubit homeCubit;
    late MockTopicService mockTopicService;

    setUp(() {
      GetIt.instance.reset();

      mockTopicService = MockTopicService();

      GetIt.instance.registerSingleton<TopicService>(mockTopicService);

      homeCubit = HomeCubit(
        topicService: GetIt.instance<TopicService>(),
      );
    });

    testWidgets("displays topics from API on application open",
        (WidgetTester tester) async {
      // Set up
      when(mockTopicService.getTopics()).thenAnswer((_) async => topics);

      // Act
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<HomeCubit>(
          create: (_) => homeCubit,
          child: HomeScreen(cubit: homeCubit),
        ),
      ));

      await tester.pumpAndSettle();

      // Assert
      for (final topic in topics) {
        expect(find.text(topic.name), findsOneWidget);
      }
    });
  });
}
