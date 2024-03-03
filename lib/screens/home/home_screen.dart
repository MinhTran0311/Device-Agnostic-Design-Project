import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/topic.dart';
import 'package:flutter_application_1/screens/home/cubit/home_cubit.dart';
import 'package:flutter_application_1/widgets/app_bar.dart';
import 'package:flutter_application_1/widgets/loading_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.cubit});
  final HomeCubit cubit;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _cubit;

  @override
  void initState() {
    _cubit = widget.cubit;
    _cubit.getTopics();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundAndAppBar(
        isHomePage: true,
        body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          if (state.loadState.isLoading) {
            return const LoadingIcon();
          }
          return SafeArea(
            child: Column(
              children: [
                const Text(
                  "Topics",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 24),
                _buildGenericPractice(context),
                const SizedBox(height: 24),
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
                _buildAppInfo(),
              ],
            ),
          );
        }));
  }

  Widget _buildGenericPractice(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36),
      child: ElevatedButton(
          onPressed: () async {
            String topicId = await _cubit.getTheFewestCorrectTopic();
            context.push("/question/$topicId");
          },
          child: Text('Generic Pratice!')),
    );
  }

  Widget _buildTopicInfo(BuildContext context, TopicModel topic) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36),
      child: ElevatedButton(
          onPressed: () {
            _cubit.setGenericMode(false);
            context.push("/question/${topic.id}");
          },
          child: Text('${topic.name}')),
    );
  }

  Widget _buildAppInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: const Column(
        children: [
          Text(
            "This app is used for checking your knowledge on some topics. When clicking one of the topic, you will have to answer the questions of that topic. Click the 'Next Question' button to move to the next question",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 4,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
              "You can choose the Generic Pratice to practice the weakness topic of your knowledge.",
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
