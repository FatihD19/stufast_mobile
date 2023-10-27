class VoucherModel {
  String? voucherId;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? dueDate;
  String? isActive;
  String? quota;
  String? code;
  String? discountPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? status;

  VoucherModel({
    this.voucherId,
    this.title,
    this.description,
    this.startDate,
    this.dueDate,
    this.isActive,
    this.quota,
    this.code,
    this.discountPrice,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) => VoucherModel(
        voucherId: json["voucher_id"],
        title: json["title"],
        description: json["description"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        isActive: json["is_active"],
        quota: json["quota"],
        code: json["code"],
        discountPrice: json["discount_price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "voucher_id": voucherId,
        "title": title,
        "description": description,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "is_active": isActive,
        "quota": quota,
        "code": code,
        "discount_price": discountPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
