class QuestionModel {
  final String question;
  final List<String> options;
  final int answer;
  final String category;

  QuestionModel({
    required this.question,
    required this.options,
    required this.answer,
    required this.category,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        question: json['q'] as String,
        options: (json['op'] as List).cast<String>(),
        answer: json['ans'] as int,
        category:json['category'] as String
      );
}
