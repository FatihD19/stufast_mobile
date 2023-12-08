import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/widget/course_tile.dart';

class BundlingModel {
  String? bundlingId;
  String? title;
  String? description;
  String? oldPrice;
  String? newPrice;
  String? thumbnail;
  String? authorFullname;
  String? authorCompany;
  String? progress;
  double? score;
  String? category_name;
  bool? owned;
  bool? is_review;
  List<CourseModel>? courseBundling;

  BundlingModel({
    this.bundlingId,
    this.title,
    this.description,
    this.oldPrice,
    this.newPrice,
    this.thumbnail,
    this.authorFullname,
    this.authorCompany,
    this.progress,
    this.score,
    this.category_name,
    this.owned,
    this.is_review,
    this.courseBundling,
  });

  factory BundlingModel.fromJson(Map<String, dynamic> json) => BundlingModel(
        bundlingId: json["bundling_id"],
        title: json["title"],
        description: json["description"],
        oldPrice: json["old_price"],
        newPrice: json["new_price"],
        thumbnail: json["thumbnail"],
        authorFullname: json["author_fullname"],
        authorCompany: json["author_company"],
        progress: json['progress'],
        score: json["score"]?.toDouble(),
        category_name: json["category_name"],
        owned: json["owned"],
        is_review: json["is_review"],
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
        "author_fullname": authorFullname,
        "author_company": authorCompany,
        "progress": progress,
        "score": score,
        "category_name": category_name,
        "owned": owned,
        "is_review": is_review,
        "course_bundling": courseBundling == null
            ? []
            : List<dynamic>.from(courseBundling!.map((x) => x.toJson())),
      };
}
