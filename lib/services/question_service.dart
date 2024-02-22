import 'dart:convert';

import 'package:flutter_application_1/injection_setup.dart';
import 'package:flutter_application_1/models/question.dart';
import 'package:flutter_application_1/services/network/api_service.dart';

class QuestionService {
  final _apiClient = injector.get<ApiService>();

  Future<QuestionModel> getQuestion(int id) async {
    try {
      final response = await _apiClient.getQuestion(id);

      final question = Map<String, dynamic>.from(response);

      return QuestionModel(
          id: question["id"],
          question: question["question"],
          options: List<String>.from(question["options"]),
          answerPostPath: question["answer_post_path"],
          imageUrl: question["image_url"]);
    } catch (e) {
      print("Error: Getting question error");
      rethrow;
    }
  }

  Future<bool> checkAnswer(int topicId, int questionId, String answer) async {
    try {
      final response =
          await _apiClient.checkAnswer(topicId, questionId, {'answer': answer});

      return Map<String, dynamic>.from(response)['correct'];
    } catch (e) {
      print("Error: Getting answer error");
      rethrow;
    }
  }
}
