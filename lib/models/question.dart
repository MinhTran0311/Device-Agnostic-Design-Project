class QuestionModel {
  QuestionModel(
      {required this.id,
      required this.question,
      required this.options,
      required this.answerPostPath,
      this.imageUrl});

  final int id;
  final String question;
  final List<String> options;
  final String answerPostPath;
  final String? imageUrl;

  bool get hasImageUrl {
    if (imageUrl == null || imageUrl!.trim() == "") {
      return false;
    }
    return true;
  }
}
