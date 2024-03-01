import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/constants.dart';
import 'package:flutter_application_1/models/topic.dart';
import 'package:flutter_application_1/screens/home/cubit/home_cubit.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'home_screen_test.mocks.dart';

@GenerateMocks([HomeCubit])
void main() {
  final topics = [
    TopicModel(id: 1, name: 'Test 1', questionPath: '123'),
    TopicModel(id: 2, name: 'Test 2', questionPath: '123'),
  ];
  group('HomeScreen Tests', () {
    late MockHomeCubit mockHomeCubit;
    late StreamController<HomeState> streamController;

    setUp(() {
      mockHomeCubit = MockHomeCubit();
      streamController = StreamController<HomeState>.broadcast();
      when(mockHomeCubit.stream).thenAnswer((_) => streamController.stream);
      when(mockHomeCubit.state)
          .thenReturn(HomeState(topics: topics, loadState: LoadState.success));
    });

    tearDown(() {
      streamController.close();
    });

    testWidgets("displays topics from API on application open",
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<HomeCubit>(
          create: (_) => mockHomeCubit,
          child: HomeScreen(cubit: mockHomeCubit),
        ),
      ));

      verify(mockHomeCubit.getTopics()).called(1);

      await tester.pumpAndSettle();

      // Assert
      for (final topic in topics) {
        expect(find.text(topic.name), findsOneWidget);
      }
    });
  });
}
