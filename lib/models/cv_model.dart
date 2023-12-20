class CVmodel {
  String? id;
  String? fullname;
  String? email;
  String? address;
  String? phoneNumber;
  DateTime? dateBirth;
  String? profilePicture;
  String? about;
  String? portofolio;
  String? status;
  String? method;
  String? range;
  String? facebook;
  String? instagram;
  String? linkedin;
  List<Education>? education;
  List<Job>? organization;
  List<Job>? job;
  List<Achievement>? achievement;

  CVmodel({
    this.id,
    this.fullname,
    this.email,
    this.address,
    this.phoneNumber,
    this.dateBirth,
    this.profilePicture,
    this.about,
    this.portofolio,
    this.status,
    this.method,
    this.range,
    this.facebook,
    this.instagram,
    this.linkedin,
    this.education,
    this.organization,
    this.job,
    this.achievement,
  });

  factory CVmodel.fromJson(Map<String, dynamic> json) => CVmodel(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        dateBirth: json["date_birth"] == null
            ? null
            : DateTime.parse(json["date_birth"]),
        profilePicture: json["profile_picture"],
        about: json["about"],
        portofolio: json["portofolio"],
        status: json["status"],
        method: json["method"],
        range: json["range"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        linkedin: json["linkedin"],
        education: json["education"] == null
            ? []
            : List<Education>.from(
                json["education"]!.map((x) => Education.fromJson(x))),
        organization: json["organization"] == null
            ? []
            : List<Job>.from(json["organization"]!.map((x) => Job.fromJson(x))),
        job: json["job"] == null
            ? []
            : List<Job>.from(json["job"]!.map((x) => Job.fromJson(x))),
        achievement: json["achievement"] == null
            ? []
            : List<Achievement>.from(
                json["achievement"]!.map((x) => Achievement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "address": address,
        "phone_number": phoneNumber,
        "date_birth":
            "${dateBirth!.year.toString().padLeft(4, '0')}-${dateBirth!.month.toString().padLeft(2, '0')}-${dateBirth!.day.toString().padLeft(2, '0')}",
        "profile_picture": profilePicture,
        "about": about,
        "portofolio": portofolio,
        "status": status,
        "method": method,
        "facebook": facebook,
        "instagram": instagram,
        "linkedin": linkedin,
        "education": education == null
            ? []
            : List<dynamic>.from(education!.map((x) => x.toJson())),
        "organization": organization == null
            ? []
            : List<dynamic>.from(organization!.map((x) => x.toJson())),
        "job":
            job == null ? [] : List<dynamic>.from(job!.map((x) => x.toJson())),
        "achievement": achievement == null
            ? []
            : List<dynamic>.from(achievement!.map((x) => x.toJson())),
      };
}

class Achievement {
  String? userAchievementId;
  String? userId;
  String? eventName;
  String? position;
  String? year;
  DateTime? createdAt;
  DateTime? updatedAt;

  Achievement({
    this.userAchievementId,
    this.userId,
    this.eventName,
    this.position,
    this.year,
    this.createdAt,
    this.updatedAt,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
        userAchievementId: json["user_achievement_id"],
        userId: json["user_id"],
        eventName: json["event_name"],
        position: json["position"],
        year: json["year"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_achievement_id": userAchievementId,
        "user_id": userId,
        "event_name": eventName,
        "position": position,
        "year": year,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Education {
  String? userEducationId;
  String? userId;
  String? status;
  String? educationName;
  String? major;
  String? year;
  DateTime? createdAt;
  DateTime? updatedAt;

  Education({
    this.userEducationId,
    this.userId,
    this.status,
    this.educationName,
    this.major,
    this.year,
    this.createdAt,
    this.updatedAt,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        userEducationId: json["user_education_id"],
        userId: json["user_id"],
        status: json["status"],
        educationName: json["education_name"],
        major: json["major"],
        year: json["year"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_education_id": userEducationId,
        "user_id": userId,
        "status": status,
        "education_name": educationName,
        "major": major,
        "year": year,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Job {
  String? userExperienceId;
  String? userId;
  String? type;
  String? instanceName;
  String? position;
  String? year;
  DateTime? createdAt;
  DateTime? updatedAt;

  Job({
    this.userExperienceId,
    this.userId,
    this.type,
    this.instanceName,
    this.position,
    this.year,
    this.createdAt,
    this.updatedAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        userExperienceId: json["user_experience_id"],
        userId: json["user_id"],
        type: json["type"],
        instanceName: json["instance_name"],
        position: json["position"],
        year: json["year"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_experience_id": userExperienceId,
        "user_id": userId,
        "type": type,
        "instance_name": instanceName,
        "position": position,
        "year": year,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
