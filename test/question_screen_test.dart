import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/question.dart';
import 'package:flutter_application_1/models/topic.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:flutter_application_1/screens/question_screen/cubit/question_cubit.dart';
import 'package:flutter_application_1/screens/question_screen/question_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'question_screen_test.mocks.dart';

@GenerateMocks([QuestionCubit])
void main() {
  final question = QuestionModel(
      id: 1,
      question: "How are you?",
      options: ["Good", "Not good", "Fade out"],
      answerPostPath: "123.com");
  group('QuestionScreen Tests', () {
    late MockQuestionCubit mockQuestionCubit;
    late StreamController<QuestionState> streamController;

    setUp(() {
      mockQuestionCubit = MockQuestionCubit();
      streamController = StreamController<QuestionState>.broadcast();
      when(mockQuestionCubit.stream).thenAnswer((_) => streamController.stream);
      when(mockQuestionCubit.state)
          .thenReturn(QuestionState(topicId: 1, question: question));
      // when(mockQuestionCubit.checkAnswer(answer)).thenReturn(
      //     QuestionState(topicId: 1, question: question, result: true));
    });

    tearDown(() {
      streamController.close();
    });

    testWidgets("displays question and answers", (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<QuestionCubit>(
          create: (_) => mockQuestionCubit,
          child: QuestionScreen(topicId: 1, cubit: mockQuestionCubit),
        ),
      ));

      verify(mockQuestionCubit.getQuestion(any)).called(1);

      await tester.pumpAndSettle();
      tester.widgetList(find.byType(Text)).forEach((widget) => print(widget));

      // Assert
      expect(find.text(question.question), findsOneWidget);
      for (final option in question.options) {
        expect(find.text(option), findsOneWidget);
      }
    });

    // testWidgets("select the correct answer", (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(
    //     home: BlocProvider<QuestionCubit>(
    //       create: (_) => mockQuestionCubit,
    //       child: QuestionScreen(topicId: 1, cubit: mockQuestionCubit),
    //     ),
    //   ));

    //   await tester.tap(find.text(question.options.first));
    //   await tester.pump();
    //   tester.widgetList(find.byType(Text)).forEach((widget) => print(widget));

    //   expect(find.text('Correct!'), findsOneWidget);
    // });
  });
}
