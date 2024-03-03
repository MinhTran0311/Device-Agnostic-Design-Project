import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/statistic/cubit/statistic_cubit.dart';
import 'package:flutter_application_1/widgets/app_bar.dart';
import 'package:flutter_application_1/widgets/info_container.dart';
import 'package:flutter_application_1/widgets/loading_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key, this.cubit});

  final cubit;

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  late final _cubit;
  @override
  void initState() {
    _cubit = widget.cubit;
    _cubit.getResult();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBar(
      body: Scaffold(body: BlocBuilder<StatisticCubit, StatisticState>(
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
            InfoContainer(
                color: Colors.cyan,
                text:
                    "Total correct answer: ${_calculateTotalCorrectAnswer()}"),
            SizedBox(height: 24),
            _buildStatisticResult(),
          ],
        );
      })),
    );
  }

  int _calculateTotalCorrectAnswer() {
    if (_cubit.state.results == null) {
      return 0;
    }

    int totalCorrectAnswers = _cubit.state.results.values
        .fold(0, (sum, element) => sum + (element as int));
    return totalCorrectAnswers;
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
