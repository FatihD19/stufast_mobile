import 'package:stufast_mobile/models/resume_model.dart';

class VideoModel {
  String? videoId;
  String? videoCategoryId;
  String? title;
  String? thumbnail;
  String? video;
  String? order;
  DateTime? createdAt;
  DateTime? updatedAt;
  Resume? resume;
  dynamic tanggalTayang;
  String? isViewed;
  dynamic score;
  String? duration;

  VideoModel({
    this.videoId,
    this.videoCategoryId,
    this.title,
    this.thumbnail,
    this.video,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.resume,
    this.tanggalTayang,
    this.isViewed,
    this.score,
    this.duration,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        videoId: json["video_id"],
        videoCategoryId: json["video_category_id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        video: json["video"],
        order: json["order"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        resume: json["resume"] == null ? null : Resume.fromJson(json["resume"]),
        tanggalTayang: json["tanggal_tayang"] == null
            ? null
            : DateTime.parse(json["tanggal_tayang"]),
        isViewed: json["is_viewed"],
        score: json["score"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "video_id": videoId,
        "video_category_id": videoCategoryId,
        "title": title,
        "thumbnail": thumbnail,
        "video": video,
        "order": order,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "resume": resume?.toJson(),
        "tanggal_tayang":
            "${tanggalTayang!.year.toString().padLeft(4, '0')}-${tanggalTayang!.month.toString().padLeft(2, '0')}-${tanggalTayang!.day.toString().padLeft(2, '0')}",
        "is_viewed": isViewed,
        "score": score,
        "duration": duration,
      };
}
