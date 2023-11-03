class Resume {
  String? resumeId;
  String? videoId;
  String? userId;
  String? resume;
  dynamic task;
  DateTime? createdAt;
  DateTime? updatedAt;

  Resume({
    this.resumeId,
    this.videoId,
    this.userId,
    this.resume,
    this.task,
    this.createdAt,
    this.updatedAt,
  });

  factory Resume.fromJson(Map<String, dynamic> json) => Resume(
        resumeId: json["resume_id"],
        videoId: json["video_id"],
        userId: json["user_id"],
        resume: json["resume"],
        task: json["task"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "resume_id": resumeId,
        "video_id": videoId,
        "user_id": userId,
        "resume": resume,
        "task": task,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
