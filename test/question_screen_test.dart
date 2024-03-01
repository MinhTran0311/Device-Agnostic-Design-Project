import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/question.dart';
import 'package:flutter_application_1/models/topic.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:flutter_application_1/screens/question_screen/cubit/question_cubit.dart';
import 'package:flutter_application_1/screens/question_screen/question_screen.dart';
import 'package:flutter_application_1/services/question_service.dart';
import 'package:flutter_application_1/services/topic_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'question_screen_test.mocks.dart';

final GetIt injector = GetIt.instance;

@GenerateMocks([QuestionService, TopicService])
void main() {
  final question = QuestionModel(
      id: 1,
      question: "How are you?",
      options: ["Good", "Not good", "Fade out"],
      answerPostPath: "123.com");
  const topicId = 1;
  group('QuestionScreen Tests', () {
    late QuestionCubit questionCubit;
    late MockQuestionService mockQuestionService;
    late MockTopicService mockTopicService;

    setUp(() {
      GetIt.instance.reset();

      mockQuestionService = MockQuestionService();
      mockTopicService = MockTopicService();

      GetIt.instance.registerSingleton<QuestionService>(mockQuestionService);
      GetIt.instance.registerSingleton<TopicService>(mockTopicService);

      questionCubit = QuestionCubit(
        questionService: GetIt.instance<QuestionService>(),
        topicService: GetIt.instance<TopicService>(),
      );
    });

    testWidgets("displays question and answers", (WidgetTester tester) async {
      //Set up
      when(mockQuestionService.getQuestion(topicId))
          .thenAnswer((_) async => question);

      // Act
      await tester.pumpWidget(MaterialApp(
          home: QuestionScreen(topicId: topicId, cubit: questionCubit)));

      await tester.pumpAndSettle();

      // Assert
      expect(find.text(question.question), findsOneWidget);
      for (final option in question.options) {
        expect(find.text(option), findsOneWidget);
      }
    });

    testWidgets("select the correct answer", (WidgetTester tester) async {
      //Set up
      final selectedOption = question.options.first;
      when(mockQuestionService.getQuestion(topicId))
          .thenAnswer((_) async => question);

      when(mockQuestionService.checkAnswer(
              topicId, question.id, selectedOption))
          .thenAnswer((_) async => true);

      // Act
      await tester.pumpWidget(
          MaterialApp(home: QuestionScreen(topicId: 1, cubit: questionCubit)));

      await tester.pumpAndSettle();

      await tester.tap(find.text(selectedOption));
      await tester.pump();

      expect(find.text('Correct!'), findsOneWidget);
    });

    testWidgets("select the wrong answer", (WidgetTester tester) async {
      //Set up
      final selectedOption = question.options.first;
      when(mockQuestionService.getQuestion(topicId))
          .thenAnswer((_) async => question);

      when(mockQuestionService.checkAnswer(
              topicId, question.id, selectedOption))
          .thenAnswer((_) async => false);

      // Act
      await tester.pumpWidget(
          MaterialApp(home: QuestionScreen(topicId: 1, cubit: questionCubit)));

      await tester.pumpAndSettle();

      await tester.tap(find.text(selectedOption));
      await tester.pump();

      expect(find.text('You have the wrong answer!'), findsOneWidget);
    });
  });
}
