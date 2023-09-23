class WebinarModel {
  String? webinarId;
  String? authorId;
  String? tagId;
  String? title;
  String? webinarType;
  String? description;
  String? oldPrice;
  String? newPrice;
  String? thumbnail;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? date;
  String? time;
  bool? owned;

  WebinarModel({
    this.webinarId,
    this.authorId,
    this.tagId,
    this.title,
    this.webinarType,
    this.description,
    this.oldPrice,
    this.newPrice,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.date,
    this.time,
    this.owned,
  });

  factory WebinarModel.fromJson(Map<String, dynamic> json) => WebinarModel(
        webinarId: json["webinar_id"],
        authorId: json["author_id"],
        tagId: json["tag_id"],
        title: json["title"],
        webinarType: json["webinar_type"],
        description: json["description"],
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
        date: json["date"],
        time: json["time"],
        owned: json["owned"],
      );

  Map<String, dynamic> toJson() => {
        "webinar_id": webinarId,
        "author_id": authorId,
        "tag_id": tagId,
        "title": title,
        "webinar_type": webinarType,
        "description": description,
        "old_price": oldPrice,
        "new_price": newPrice,
        "thumbnail": thumbnail,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "date": date,
        "time": time,
        "owned": owned,
      };
}
