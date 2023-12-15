class HireModel {
  String? hireId;
  String? companyId;
  String? userId;
  String? position;
  String? status;
  String? method;
  String? minSalary;
  String? maxSalary;
  DateTime? minDate;
  DateTime? maxDate;
  String? information;
  String? result;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fullname;
  String? profilePicture;
  String? address;
  String? range;
  String? period;

  HireModel({
    this.hireId,
    this.companyId,
    this.userId,
    this.position,
    this.status,
    this.method,
    this.minSalary,
    this.maxSalary,
    this.minDate,
    this.maxDate,
    this.information,
    this.result,
    this.createdAt,
    this.updatedAt,
    this.fullname,
    this.profilePicture,
    this.address,
    this.range,
    this.period,
  });

  factory HireModel.fromJson(Map<String, dynamic> json) => HireModel(
        hireId: json["hire_id"],
        companyId: json["company_id"],
        userId: json["user_id"],
        position: json["position"],
        status: json["status"],
        method: json["method"],
        minSalary: json["min_salary"],
        maxSalary: json["max_salary"],
        minDate:
            json["min_date"] == null ? null : DateTime.parse(json["min_date"]),
        maxDate:
            json["max_date"] == null ? null : DateTime.parse(json["max_date"]),
        information: json["information"],
        result: json["result"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fullname: json["fullname"],
        profilePicture: json["profile_picture"],
        address: json["address"],
        range: json["range"],
        period: json["period"],
      );

  Map<String, dynamic> toJson() => {
        "hire_id": hireId,
        "company_id": companyId,
        "user_id": userId,
        "position": position,
        "status": status,
        "method": method,
        "min_salary": minSalary,
        "max_salary": maxSalary,
        "min_date":
            "${minDate!.year.toString().padLeft(4, '0')}-${minDate!.month.toString().padLeft(2, '0')}-${minDate!.day.toString().padLeft(2, '0')}",
        "max_date":
            "${maxDate!.year.toString().padLeft(4, '0')}-${maxDate!.month.toString().padLeft(2, '0')}-${maxDate!.day.toString().padLeft(2, '0')}",
        "information": information,
        "result": result,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "fullname": fullname,
        "profile_picture": profilePicture,
        "address": address,
        "range": range,
        "period": period,
      };
}
