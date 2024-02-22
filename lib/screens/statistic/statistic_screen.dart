import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/statistic/cubit/statistic_cubit.dart';
import 'package:flutter_application_1/widgets/app_bar.dart';
import 'package:flutter_application_1/widgets/info_container.dart';
import 'package:flutter_application_1/widgets/loading_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  final _cubit = StatisticCubit();
  @override
  void initState() {
    _cubit.getResult();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBar(
      body: BlocProvider(
          create: (context) => _cubit,
          child: Scaffold(body: BlocBuilder<StatisticCubit, StatisticState>(
              builder: (context, state) {
            if (state.loadState.isLoading) {
              return const LoadingIcon();
            }
            return Column(
              children: [
                const Center(
                  child: Text("Result", style: const TextStyle(fontSize: 24)),
                ),
                SizedBox(height: 24),
                _buildStatisticResult(),
              ],
            );
          }))),
    );
  }

  Widget _buildStatisticResult() {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            String topicName = _cubit.state.results.keys.elementAt(index);
            String topicScore =
                _cubit.state.results.values.elementAt(index).toString();
            return InfoContainer(text: '$topicName: $topicScore');
          },
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemCount: _cubit.state.results.length),
    );
  }
}
