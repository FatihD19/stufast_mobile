import 'package:stufast_mobile/models/review_model.dart';
import 'package:stufast_mobile/models/tag_model.dart';

import 'package:stufast_mobile/models/video_model.dart';

class CourseModel {
  String? courseId;
  String? title;
  String? service;
  String? description;
  String? keyTakeaways;
  String? suitableFor;
  String? oldPrice;
  String? newPrice;
  String? thumbnail;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? authorFullname;
  String? authorCompany;
  String? type;
  dynamic score;
  String? mengerjakan_video;
  dynamic rating_course;
  bool? owned;
  List<TagModel>? tag;
  List<VideoModel>? video;
  // VideoDurationModel? totalVideoDuration;
  String? total_video_duration;
  // double? ratingCourse;
  // CategoryModel? category;
  String? category;
  List<Review>? review;

  CourseModel({
    this.courseId,
    this.title,
    this.service,
    this.description,
    this.keyTakeaways,
    this.suitableFor,
    this.oldPrice,
    this.newPrice,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.authorFullname,
    this.authorCompany,
    this.type,
    this.score,
    this.mengerjakan_video,
    this.rating_course,
    this.owned,
    this.tag,
    this.video,
    this.total_video_duration,
    // this.ratingCourse,
    this.category,
    this.review,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        courseId: json["course_id"],
        title: json["title"],
        service: json["service"],
        description: json["description"],
        keyTakeaways: json["key_takeaways"],
        suitableFor: json["suitable_for"],
        oldPrice: json["old_price"],
        newPrice: json["new_price"],
        thumbnail: json["thumbnail"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        authorFullname: json["author_fullname"],
        authorCompany: json["author_company"],
        type: json["type"],
        score: json["score"],
        mengerjakan_video: json["mengerjakan_video"],
        owned: json["owned"],
        tag: json["tag"] == null
            ? []
            : List<TagModel>.from(
                json["tag"]!.map((x) => TagModel.fromJson(x))),
        video: json["video"] == null
            ? []
            : List<VideoModel>.from(
                json["video"]!.map((x) => VideoModel.fromJson(x))),
        total_video_duration: json["total_video_duration"],
        rating_course: json["rating_course"],
        // totalVideoDuration: json["total_video_duration"] == null
        //     ? null
        //     : VideoDurationModel.fromJson(json["total_video_duration"]),
        // ratingCourse: json["rating_course"],
        // category: json["category"] == null
        //     ? null
        //     : CategoryModel.fromJson(json["category"]),
        category: json["category"],
        review: json["review"] == null
            ? []
            : List<Review>.from(json["review"]!.map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "title": title,
        "service": service,
        "description": description,
        "key_takeaways": keyTakeaways,
        "suitable_for": suitableFor,
        "old_price": oldPrice,
        "new_price": newPrice,
        "thumbnail": thumbnail,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "author_fullname": authorFullname,
        "author_company": authorCompany,
        "type": type,
        "score": score,
        "mengerjakan_video": mengerjakan_video,
        "owned": owned,
        "tag":
            tag == null ? [] : List<dynamic>.from(tag!.map((x) => x.toJson())),
        "video": video == null
            ? []
            : List<dynamic>.from(video!.map((x) => x.toJson())),
        "total_video_duration": total_video_duration,
        "rating_course": rating_course,
        // "total_video_duration": totalVideoDuration?.toJson(),
        // "rating_course": ratingCourse,
        // "category": category?.toJson(),
        "category": category,
        "review": review == null
            ? []
            : List<dynamic>.from(review!.map((x) => x.toJson())),
      };
}
