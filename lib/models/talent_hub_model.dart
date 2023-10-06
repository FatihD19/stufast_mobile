import 'package:stufast_mobile/models/course_model.dart';

class TalentHubModel {
  String? fullname;
  String? id;
  String? profilePicture;
  dynamic averageScore;
  int? totalCourse;
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
