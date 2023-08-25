class CategoryModel {
  String? courseCategoryId;
  String? courseId;
  String? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;

  CategoryModel({
    this.courseCategoryId,
    this.courseId,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        courseCategoryId: json["course_category_id"],
        courseId: json["course_id"],
        categoryId: json["category_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "course_category_id": courseCategoryId,
        "course_id": courseId,
        "category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "name": name,
      };
}
