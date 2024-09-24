class Question {
  final int id;
  final String question;
  late List<String> options;
  late int correctAnswerIndex;
  final String explanation;
  final String correctAnswerText;

  Question(
      {required this.id,
      required this.question,
      required this.options,
      required this.correctAnswerIndex,
      required this.explanation,
      required this.correctAnswerText});
}
