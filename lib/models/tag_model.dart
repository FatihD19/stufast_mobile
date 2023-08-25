class TagModel {
  String? courseTagId;
  String? tagId;
  String? name;

  TagModel({
    this.courseTagId,
    this.tagId,
    this.name,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
        courseTagId: json["course_tag_id"],
        tagId: json["tag_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "course_tag_id": courseTagId,
        "tag_id": tagId,
        "name": name,
      };
}
