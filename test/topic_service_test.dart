import 'dart:convert';

import 'package:flutter_application_1/injection_setup.dart';
import 'package:flutter_application_1/models/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_application_1/models/topic.dart';
import 'package:flutter_application_1/services/topic_service.dart';
import 'package:flutter_application_1/services/network/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'question_service_test.mocks.dart';

@GenerateMocks([ApiService, Dio])
void main() {
  final topics = [
    TopicModel(id: 1, name: 'Test 1', questionPath: '123'),
    TopicModel(id: 2, name: 'Test 2', questionPath: '123'),
    TopicModel(id: 3, name: 'Test 3', questionPath: '123'),
  ];
  final score = [10, 5, 3];

  group('TopicService', () {
    late MockApiService mockApiService;
    late TopicService topicService;

    setUp(() {
      mockApiService = MockApiService();
      GetIt.instance.reset();
      GetIt.instance.registerSingleton<ApiService>(mockApiService);
      topicService = TopicService();
    });

    test('getTopics returns a list of TopicModel', () async {
      when(mockApiService.getTopics()).thenAnswer((_) async => [
            {"id": 1, "name": "Topic 1", "question_path": "path/to/questions"},
            // Add more mock topic data as needed
          ]);

      final topics = await topicService.getTopics();

      expect(topics, isA<List<TopicModel>>());
      expect(topics.length, 1); // Adjust based on your mock data
      expect(topics.first.name, "Topic 1");
    });

    test("6. The generic practice will choose the fewest correct answer topic",
        () async {
      SharedPreferences.setMockInitialValues({
        resultKey: json.encode({
          topics[0].id.toString(): score[0],
          topics[1].id.toString(): score[1],
          topics[2].id.toString(): score[2]
        }),
      });

      final topicId = await topicService.getTheFewestCorrectTopic();

      expect(topicId, topics[2].id.toString());
    });
  });
}
