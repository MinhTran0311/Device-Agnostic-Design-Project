import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/constants.dart';
import 'package:flutter_application_1/models/question.dart';
import 'package:flutter_application_1/models/topic.dart';
import 'package:flutter_application_1/screens/home/cubit/home_cubit.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:flutter_application_1/screens/question_screen/cubit/question_cubit.dart';
import 'package:flutter_application_1/screens/question_screen/question_screen.dart';
import 'package:flutter_application_1/screens/statistic/cubit/statistic_cubit.dart';
import 'package:flutter_application_1/screens/statistic/statistic_screen.dart';
import 'package:flutter_application_1/services/question_service.dart';
import 'package:flutter_application_1/services/topic_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen_test.mocks.dart';

@GenerateMocks([TopicService, QuestionService, NavigatorObserver])
void main() {
  final question = QuestionModel(
      id: 1,
      question: "How are you?",
      options: ["Good", "Not good", "Fade out"],
      answerPostPath: "123.com");
  const topicId = 1;

  final topics = [
    TopicModel(id: 1, name: 'Test 1', questionPath: '123'),
    TopicModel(id: 2, name: 'Test 2', questionPath: '123'),
    TopicModel(id: 3, name: 'Test 3', questionPath: '123'),
  ];
  final score = [10, 5, 3];
  group('HomeScreen Tests', () {
    late HomeCubit homeCubit;
    late MockTopicService mockTopicService;
    late MockNavigatorObserver mockObserver;

    setUp(() {
      GetIt.instance.reset();

      mockTopicService = MockTopicService();

      GetIt.instance.registerSingleton<TopicService>(mockTopicService);

      homeCubit = HomeCubit(
        topicService: GetIt.instance<TopicService>(),
      );
      mockObserver = MockNavigatorObserver();
    });

    testWidgets("1. Displays topics from API on application open",
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

    // testWidgets("6. The generic practice will choose the fewest correct answer topic",
    //     (WidgetTester tester) async {
    //   // Set up

    //   when(mockTopicService.getTopics()).thenAnswer((_) async => topics);
    //   SharedPreferences.setMockInitialValues({
    //     resultKey: json.encode({
    //       topics[0].id.toString(): score[0],
    //       topics[1].id.toString(): score[1],
    //       topics[2].id.toString(): score[2]
    //     }),
    //   });

    //   // Act
    //   await tester.pumpWidget(MaterialApp(
    //     home: BlocProvider<HomeCubit>(
    //       create: (_) => homeCubit,
    //       child: HomeScreen(cubit: homeCubit),
    //     ),
    //     navigatorObservers: [mockObserver],
    //   ));

    //   await tester.pumpAndSettle();
    //   tester.widgetList(find.byType(Text)).forEach((widget) => print(widget));
    //   await tester.tap(find.text("Generic Pratice!"));
    //   await tester.pumpAndSettle();

    //   // Assert
    //   verify(mockObserver.didPush(any, any));

    //   var expectedRoute = "/question/3";
    //   verify(mockObserver.didPush(
    //     argThat(predicate(
    //         (Route<dynamic> route) => route.settings.name == expectedRoute)),
    //     any,
    //   ));
    // });
  });

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

    testWidgets("2. Displays question and answers",
        (WidgetTester tester) async {
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

    testWidgets("3. Select the correct answer", (WidgetTester tester) async {
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

    testWidgets("3. Select the wrong answer", (WidgetTester tester) async {
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

    test(
        "The fewest correct topicId is selected if not in Generic Practice mode",
        () async {
      SharedPreferences.setMockInitialValues({genericPracticeMode: true});

      when(mockTopicService.getTheFewestCorrectTopic())
          .thenAnswer((_) async => topics[2].id.toString());

      var topicId = await questionCubit.getTopicIdForNextQuestion();
      expect(topicId, topics[2].id.toString());
    });
  });

  group('StatisticScreen Tests', () {
    late StatisticCubit statisticCubit;
    late MockTopicService mockTopicService;

    setUp(() {
      GetIt.instance.reset();

      mockTopicService = MockTopicService();

      GetIt.instance.registerSingleton<TopicService>(mockTopicService);

      statisticCubit = StatisticCubit(
        topicService: GetIt.instance<TopicService>(),
      );

      SharedPreferences.setMockInitialValues({
        resultKey: json.encode({
          topics[0].id.toString(): score[0],
          topics[1].id.toString(): score[1],
          topics[2].id.toString(): score[2]
        }),
      });
    });

    testWidgets("4. Displays the total correct answer",
        (WidgetTester tester) async {
      // Set up
      when(mockTopicService.getTopics()).thenAnswer((_) async => topics);

      // Act
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<StatisticCubit>(
          create: (_) => statisticCubit,
          child: StatisticScreen(cubit: statisticCubit),
        ),
      ));

      await tester.pumpAndSettle();

      // Assert
      expect(find.text("Total correct answer: 18"), findsOneWidget);
    });

    testWidgets("5. Displays the topic-specific statistics correct answer",
        (WidgetTester tester) async {
      // Set up
      when(mockTopicService.getTopics()).thenAnswer((_) async => topics);

      // Act
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<StatisticCubit>(
          create: (_) => statisticCubit,
          child: StatisticScreen(cubit: statisticCubit),
        ),
      ));

      await tester.pumpAndSettle();

      // Assert
      for (int i = 0; i < topics.length; i++) {
        expect(find.text("${topics[i].name}: ${score[i]}"), findsOneWidget);
      }
    });
  });
}
