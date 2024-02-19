class QuestionModel {
  QuestionModel(
      {required this.id,
      required this.question,
      required this.options,
      required this.answerPostPath});

  final int id;
  final String question;
  final List<String> options;
  final String answerPostPath;
}
