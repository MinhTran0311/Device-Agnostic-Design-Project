import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/topic.dart';
import 'package:flutter_application_1/screens/home/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cubit = HomeCubit();

  @override
  void initState() {
    _cubit.getTopics();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _cubit,
        child: Scaffold(
            body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          if (state.loadState.isLoading) {
            return const LoadingIndicator(
              indicatorType: Indicator.orbit,
              colors: [Colors.red],
              strokeWidth: 2,
            );
          }
          return SafeArea(
            child: Column(
              children: [
                Text("Topics"),
                SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return _buildTopicInfo(
                            context, _cubit.state.topics[index]);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 24),
                      itemCount: _cubit.state.topics.length),
                ),
              ],
            ),
          );
        })));
  }

  Widget _buildTopicInfo(BuildContext context, TopicModel topic) {
    return ElevatedButton(
        onPressed: () => context.go("/question/${topic.id}"),
        child: Text('Name: ${topic.name}'));
  }
}
