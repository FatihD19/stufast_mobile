import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/cv_model.dart';
import 'package:stufast_mobile/models/user_model.dart';

class TalentHubModel {
  int? currentPage;
  int? totalPage;
  int? totalItem;
  List<Talent>? talent;

  TalentHubModel({
    this.currentPage,
    this.totalPage,
    this.totalItem,
    this.talent,
  });

  factory TalentHubModel.fromJson(Map<String, dynamic> json) => TalentHubModel(
        currentPage: json["current_page"],
        totalPage: json["total_page"],
        totalItem: json["total_item"],
        talent: json["talent"] == null
            ? []
            : List<Talent>.from(json["talent"]!.map((x) => Talent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "total_page": totalPage,
        "total_item": totalItem,
        "talent": talent == null
            ? []
            : List<dynamic>.from(talent!.map((x) => x.toJson())),
      };
}

class Talent {
  String? fullname;
  String? id;
  String? profilePicture;
  String? totalCourse;
  String? averageScore;
  String? profilePicture2;
  String? status;
  String? method;
  int? minSalary;
  int? maxSalary;

  Talent({
    this.fullname,
    this.id,
    this.profilePicture,
    this.totalCourse,
    this.averageScore,
    this.profilePicture2,
    this.status,
    this.method,
    this.minSalary,
    this.maxSalary,
  });

  factory Talent.fromJson(Map<String, dynamic> json) => Talent(
        fullname: json["fullname"],
        id: json["id"],
        profilePicture: json["profile_picture"],
        totalCourse: json["total_course"],
        averageScore: json["average_score"],
        profilePicture2: json["profile_picture_2"],
        status: json["status"],
        method: json["method"],
        minSalary: json["min_salary"],
        maxSalary: json["max_salary"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "id": id,
        "profile_picture": profilePicture,
        "total_course": totalCourse,
        "average_score": averageScore,
        "profile_picture_2": profilePicture2,
        "status": status,
        "method": method,
        "min_salary": minSalary,
        "max_salary": maxSalary,
      };
}

class DetailTalentHubModel {
  CVmodel? user;
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
        user: json["user"] == null ? null : CVmodel.fromJson(json["user"]),
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
  dynamic finalScore;
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
  dynamic score;

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
