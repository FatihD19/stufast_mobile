import 'package:stufast_mobile/models/bundling_model.dart';
import 'package:stufast_mobile/models/course_model.dart';

class UserCourseModel {
  String? id;
  String? profilePicture;
  String? fullname;
  String? email;
  DateTime? dateBirth;
  String? jobName;
  String? address;
  String? phoneNumber;
  String? linkedin;
  DateTime? createdAt;
  String? cv;
  int? learningProgress;
  List<CourseModel> course;
  List<BundlingModel> bundling;

  UserCourseModel({
    this.id,
    this.profilePicture,
    this.fullname,
    this.email,
    this.dateBirth,
    this.jobName,
    this.address,
    this.phoneNumber,
    this.linkedin,
    this.createdAt,
    this.cv,
    this.learningProgress,
    required this.course,
    required this.bundling,
  });

  factory UserCourseModel.fromJson(Map<String, dynamic> json) =>
      UserCourseModel(
        id: json["id"],
        profilePicture: json["profile_picture"],
        fullname: json["fullname"],
        email: json["email"],
        dateBirth: json["date_birth"] == null
            ? null
            : DateTime.parse(json["date_birth"]),
        jobName: json["job_name"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        linkedin: json["linkedin"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        cv: json["cv"],
        learningProgress: json["learning_progress"],
        course: json["course"] == null
            ? []
            : List<CourseModel>.from(
                json["course"]!.map((x) => CourseModel.fromJson(x))),
        bundling: json["bundling"] == null
            ? []
            : List<BundlingModel>.from(
                json["bundling"]!.map((x) => BundlingModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile_picture": profilePicture,
        "fullname": fullname,
        "email": email,
        "date_birth":
            "${dateBirth!.year.toString().padLeft(4, '0')}-${dateBirth!.month.toString().padLeft(2, '0')}-${dateBirth!.day.toString().padLeft(2, '0')}",
        "job_name": jobName,
        "address": address,
        "phone_number": phoneNumber,
        "linkedin": linkedin,
        "created_at": createdAt?.toIso8601String(),
        "cv": cv,
        "learning_progress": learningProgress,
        "course": course == null
            ? []
            : List<dynamic>.from(course!.map((x) => x.toJson())),
        "bundling": bundling == null
            ? []
            : List<dynamic>.from(bundling!.map((x) => x.toJson())),
      };
}
