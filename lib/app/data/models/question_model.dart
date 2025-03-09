class QuestionModel {
  final int id;
  final String question;
  late List<String> options;
  late int correctAnswerIndex;
  final String explanation;
  final String correctAnswerText;

  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    required this.correctAnswerText,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correctAnswerIndex'],
      explanation: json['explanation'],
      correctAnswerText: json['correctAnswerText'],
    );
  }
}
