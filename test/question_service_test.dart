import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_application_1/models/question.dart';
import 'package:flutter_application_1/services/network/api_service.dart';
import 'package:flutter_application_1/services/question_service.dart';
import 'question_service_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  group('QuestionService', () {
    late MockApiService mockApiService;
    late QuestionService questionService;

    setUp(() {
      mockApiService = MockApiService();
      GetIt.instance.reset();
      GetIt.instance.registerSingleton<ApiService>(mockApiService);
      questionService = QuestionService();
    });

    test('getQuestion fetches and processes a question correctly', () async {
      // Setup the mock response
      when(mockApiService.getQuestion(any)).thenAnswer((_) async => {
            "id": 1,
            "question": "What is Flutter?",
            "options": ["A bird", "A web framework", "A mobile SDK"],
            "answer_post_path": "/answers",
            "image_url": "http://example.com/image.png"
          });

      final question = await questionService.getQuestion(1);

      // Verify the response is processed correctly
      expect(question, isA<QuestionModel>());
      expect(question.id, 1);
      expect(question.question, "What is Flutter?");
      expect(question.options.length, 3);
      expect(question.answerPostPath, "/answers");
      expect(question.imageUrl, "http://example.com/image.png");
    });

    test('checkAnswer submits an answer and processes the response correctly',
        () async {
      // Setup the mock response for answer checking
      when(mockApiService.checkAnswer(any, any, any))
          .thenAnswer((_) async => {"correct": true});

      final isCorrect = await questionService.checkAnswer(1, 1, "A mobile SDK");

      // Verify the answer checking logic
      expect(isCorrect, true);
    });
  });
}
