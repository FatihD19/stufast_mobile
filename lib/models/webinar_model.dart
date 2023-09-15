class WebinarModel {
  String? title;
  String? oldPrice;
  String? newPrice;
  String? thumbnail;
  String? tagId;
  String? tag;

  WebinarModel({
    this.title,
    this.oldPrice,
    this.newPrice,
    this.thumbnail,
    this.tagId,
    this.tag,
  });

  factory WebinarModel.fromJson(Map<String, dynamic> json) => WebinarModel(
        title: json["title"],
        oldPrice: json["old_price"],
        newPrice: json["new_price"],
        thumbnail: json["thumbnail"],
        tagId: json["tag_id"],
        tag: json["tag"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "old_price": oldPrice,
        "new_price": newPrice,
        "thumbnail": thumbnail,
        "tag_id": tagId,
        "tag": tag,
      };
}
