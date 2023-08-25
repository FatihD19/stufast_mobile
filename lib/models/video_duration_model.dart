class VideoDurationModel {
  String? total;

  VideoDurationModel({
    this.total,
  });

  factory VideoDurationModel.fromJson(Map<String, dynamic> json) =>
      VideoDurationModel(
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
      };
}
