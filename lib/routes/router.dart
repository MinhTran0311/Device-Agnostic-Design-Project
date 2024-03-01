import 'package:flutter_application_1/screens/home/cubit/home_cubit.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:flutter_application_1/screens/question_screen/cubit/question_cubit.dart';
import 'package:flutter_application_1/screens/question_screen/question_screen.dart';
import 'package:flutter_application_1/screens/statistic/statistic_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) {
          final cubit = HomeCubit();
          return BlocProvider(
              create: (context) => cubit,
              child: HomeScreen(
                cubit: cubit,
              ));
        }),
    GoRoute(path: '/statistic', builder: (context, state) => StatisticScreen()),
    GoRoute(
        path: '/question/:id',
        builder: (context, state) {
          final cubit = QuestionCubit();
          return BlocProvider(
            create: (context) => cubit,
            child: QuestionScreen(
              topicId: int.parse(state.pathParameters['id']!),
              cubit: cubit,
            ),
          );
        }),
  ],
);
