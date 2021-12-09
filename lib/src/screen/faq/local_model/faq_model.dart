class FaqModel {
  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  int id;
  String question;
  String answer;

  factory FaqModel.fromMap(Map<String, dynamic> json) => FaqModel(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
      );
}
