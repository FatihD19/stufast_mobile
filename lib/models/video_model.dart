class VideoModel {
  String? duration;

  VideoModel({
    this.duration,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
      };
}
