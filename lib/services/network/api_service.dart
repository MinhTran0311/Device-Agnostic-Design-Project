import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @GET('/topics')
  Future<dynamic> getTopics();

  @GET('/topics/{topicId}/questions')
  Future<dynamic> getQuestion(@Path("topicId") int topicId);

  @GET('/topics/{topicId}/questions/{questionId}/answers')
  Future<dynamic> getAnswer(
      @Path("topicId") int topicId, @Path("questionId") int questionId);
}
