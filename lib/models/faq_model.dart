class FaqModel {
  String? faqId;
  String? question;
  String? answer;
  DateTime? createdAt;
  DateTime? updatedAt;

  FaqModel({
    this.faqId,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        faqId: json["faq_id"],
        question: json["question"],
        answer: json["answer"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "faq_id": faqId,
        "question": question,
        "answer": answer,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
