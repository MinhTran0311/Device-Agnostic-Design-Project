import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/constants.dart';
import 'package:flutter_application_1/models/question.dart';
import 'package:flutter_application_1/screens/question_screen/cubit/question_cubit.dart';
import 'package:flutter_application_1/widgets/app_bar.dart';
import 'package:flutter_application_1/widgets/info_container.dart';
import 'package:flutter_application_1/widgets/loading_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.topicId, required this.cubit});

  final int topicId;
  final QuestionCubit cubit;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final QuestionCubit _cubit = QuestionCubit();

  @override
  void initState() {
    _cubit.getQuestion(widget.topicId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBar(
      body: BlocProvider(
          create: (context) => _cubit,
          child: Scaffold(body: BlocBuilder<QuestionCubit, QuestionState>(
              builder: (context, state) {
            if (state.loadState.isLoading && _cubit.state.question == null) {
              return const LoadingIcon();
            }
            return Column(
              children: [
                Text(_cubit.state.question!.question,
                    style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 8),
                _buildQuestionImage(_cubit.state.question!),
                const SizedBox(height: 8),
                _buildMultipleChoice(_cubit.state.question!),
                _buildAnswerState(context),
                const SizedBox(height: 24),
              ],
            );
          }))),
    );
  }

  Widget _buildMultipleChoice(QuestionModel question) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _buildOption(question.options[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemCount: question.options.length),
    );
  }

  Widget _buildOption(String option) {
    return ElevatedButton(
        onPressed: () => _cubit.checkAnswer(option), child: Text(option));
  }

  Widget _buildQuestionImage(QuestionModel question) {
    return question.hasImageUrl
        ? Image.network(question.imageUrl!)
        : const SizedBox.shrink();
  }

  Widget _buildAnswerState(BuildContext context) {
    if (_cubit.state.result == null) {
      return const SizedBox.shrink();
    }

    bool hasResult = _cubit.state.result!;

    if (_cubit.state.loadState == LoadState.loading) {
      return const LoadingIcon();
    }

    if (hasResult) {
      return Column(
        children: [
          const InfoContainer(text: "Correct!"),
          const SizedBox(height: 8),
          ElevatedButton(
              onPressed: () async {
                String topicId = await _cubit.getTopicIdForNextQuestion();
                context.push("/question/${topicId}");
              },
              child: Text("Next Question"))
        ],
      );
    } else {
      return const InfoContainer(
        text: "You have the wrong answer!",
        color: Colors.red,
      );
    }
  }
}
