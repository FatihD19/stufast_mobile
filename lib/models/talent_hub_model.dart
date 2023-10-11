import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/user_model.dart';

class TalentHubModel {
  String? fullname;
  String? id;
  String? profilePicture;
  dynamic averageScore;
  dynamic totalCourse;
  List<CourseModel>? courses;

  TalentHubModel({
    this.fullname,
    this.id,
    this.profilePicture,
    this.averageScore,
    this.totalCourse,
    this.courses,
  });

  factory TalentHubModel.fromJson(Map<String, dynamic> json) => TalentHubModel(
        fullname: json["fullname"],
        id: json["id"],
        profilePicture: json["profile_picture"],
        averageScore: json["average_score"],
        totalCourse: json["total_course"],
        courses: json["courses"] == null
            ? []
            : List<CourseModel>.from(
                json["courses"]!.map((x) => CourseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "id": id,
        "profile_picture": profilePicture,
        "average_score": averageScore,
        "total_course": totalCourse,
        "courses": courses == null
            ? []
            : List<dynamic>.from(courses!.map((x) => x.toJson())),
      };
}

class DetailTalentHubModel {
  UserModel? user;
  dynamic totalCourse;
  dynamic averageScore;
  List<Ach>? ach;

  DetailTalentHubModel({
    this.user,
    this.totalCourse,
    this.averageScore,
    this.ach,
  });

  factory DetailTalentHubModel.fromJson(Map<String, dynamic> json) =>
      DetailTalentHubModel(
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        totalCourse: json["total_course"],
        averageScore: json["average_score"],
        ach: json["ach"] == null
            ? []
            : List<Ach>.from(json["ach"]!.map((x) => Ach.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "total_course": totalCourse,
        "average_score": averageScore,
        "ach":
            ach == null ? [] : List<dynamic>.from(ach!.map((x) => x.toJson())),
      };
}

class Ach {
  String? courseTitle;
  String? finalScore;
  List<Score>? score;

  Ach({
    this.courseTitle,
    this.finalScore,
    this.score,
  });

  factory Ach.fromJson(Map<String, dynamic> json) => Ach(
        courseTitle: json["course_title"],
        finalScore: json["final_score"],
        score: json["score"] == null
            ? []
            : List<Score>.from(json["score"]!.map((x) => Score.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "course_title": courseTitle,
        "final_score": finalScore,
        "score": score == null
            ? []
            : List<dynamic>.from(score!.map((x) => x.toJson())),
      };
}

class Score {
  String? title;
  String? score;

  Score({
    this.title,
    this.score,
  });

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        title: json["title"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "score": score,
      };
}
