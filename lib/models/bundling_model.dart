import 'package:stufast_mobile/models/course_model.dart';

class BundlingModel {
  String? bundlingId;
  String? title;
  String? description;
  String? oldPrice;
  String? newPrice;
  String? thumbnail;
  String? progress;
  double? score;
  List<CourseModel>? courseBundling;

  BundlingModel({
    this.bundlingId,
    this.title,
    this.description,
    this.oldPrice,
    this.newPrice,
    this.thumbnail,
    this.progress,
    this.score,
    this.courseBundling,
  });

  factory BundlingModel.fromJson(Map<String, dynamic> json) => BundlingModel(
        bundlingId: json["bundling_id"],
        title: json["title"],
        description: json["description"],
        oldPrice: json["old_price"],
        newPrice: json["new_price"],
        thumbnail: json["thumbnail"],
        progress: json['progress'],
        score: json["score"]?.toDouble(),
        courseBundling: json["course_bundling"] == null
            ? []
            : List<CourseModel>.from(
                json["course_bundling"]!.map((x) => CourseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bundling_id": bundlingId,
        "title": title,
        "description": description,
        "old_price": oldPrice,
        "new_price": newPrice,
        "thumbnail": thumbnail,
        "progress": progress,
        "score": score,
        "course_bundling": courseBundling == null
            ? []
            : List<dynamic>.from(courseBundling!.map((x) => x.toJson())),
      };
}
