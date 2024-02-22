import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:flutter_application_1/screens/question_screen/question_screen.dart';
import 'package:flutter_application_1/screens/statistic/statistic_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/statistic', builder: (context, state) => StatisticScreen()),
    GoRoute(
        path: '/question/:id',
        builder: (context, state) {
          return QuestionScreen(
              topicId: int.parse(state.pathParameters['id']!));
        }),
  ],
);
