class QuizModel {
  String? quizId;
  String? videoId;
  String question;
  String? answerA;
  String? answerB;
  String? answerC;
  String? answerD;
  String? validAnswer;
  String? type;
  DateTime? createdAt;
  DateTime? updateAt;

  QuizModel({
    this.quizId,
    this.videoId,
    required this.question,
    this.answerA,
    this.answerB,
    this.answerC,
    this.answerD,
    this.validAnswer,
    this.type,
    this.createdAt,
    this.updateAt,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        quizId: json["quiz_id"],
        videoId: json["video_id"],
        question: json["question"],
        answerA: json["answer_a"],
        answerB: json["answer_b"],
        answerC: json["answer_c"],
        answerD: json["answer_d"],
        validAnswer: json["valid_answer"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updateAt: json["update_at"] == null
            ? null
            : DateTime.parse(json["update_at"]),
      );

  Map<String, dynamic> toJson() => {
        "quiz_id": quizId,
        "video_id": videoId,
        "question": question,
        "answer_a": answerA,
        "answer_b": answerB,
        "answer_c": answerC,
        "answer_d": answerD,
        "valid_answer": validAnswer,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "update_at": updateAt?.toIso8601String(),
      };
}
