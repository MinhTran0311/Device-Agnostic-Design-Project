import 'package:flutter_application_1/injection_setup.dart';
import 'package:flutter_application_1/models/topic.dart';
import 'package:flutter_application_1/services/network/api_service.dart';

class QuestionService {
  final _apiClient = injector.get<ApiService>();

  Future<List<TopicModel>> getTopics() async {
    try {
      List<TopicModel> topics = [];
      final response = await _apiClient.getTopics();

      final mapOfTopics = List<Map<String, dynamic>>.from(response);

      for (Map<String, dynamic> element in mapOfTopics) {
        topics.add(TopicModel(
            id: element["id"],
            name: element["name"],
            questionPath: element["question_path"]));
      }

      return topics;
    } catch (e) {
      print("Error: Getting topics error");
      rethrow;
    }
  }
}
