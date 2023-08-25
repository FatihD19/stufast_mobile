import 'package:stufast_mobile/models/category_model.dart';
import 'package:stufast_mobile/models/tag_model.dart';
import 'package:stufast_mobile/models/video_duration_model.dart';
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
  TagModel? tag;
  List<VideoModel>? video;
  VideoDurationModel? totalVideoDuration;
  int? ratingCourse;
  CategoryModel? category;

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
    this.tag,
    this.video,
    this.totalVideoDuration,
    this.ratingCourse,
    this.category,
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
        tag: TagModel.fromJson(json['tag'][0]),
        video: json["video"] == null
            ? []
            : json['video'][0]
                .map<VideoModel>((video) => VideoModel.fromJson(video))
                .toList(),
        totalVideoDuration: json["total_video_duration"] == null
            ? null
            : VideoDurationModel.fromJson(json['total_video_duration']),
        ratingCourse: json["rating_course"],
        category: CategoryModel.fromJson(json['category']),
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
        "tag": tag?.toJson(),
        "video":
            video == null ? [] : video?.map((video) => video.toJson()).toList(),
        "total_video_duration": totalVideoDuration?.toJson(),
        "rating_course": ratingCourse,
        "category": category?.toJson(),
      };
}
