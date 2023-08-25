class UserModel {
  String? id;
  String? jobId;
  String? nama;
  String? oauthId;
  String? email;
  String? dateBirth;
  String? address;
  String? phoneNumber;
  String? linkedin;
  String? profilePicture;
  String? role;
  String? company;
  String? activationCode;
  String? activationStatus;

  UserModel({
    this.id,
    this.jobId,
    this.nama,
    this.oauthId,
    this.email,
    this.dateBirth,
    this.address,
    this.phoneNumber,
    this.linkedin,
    this.profilePicture,
    this.role,
    this.company,
    this.activationCode,
    this.activationStatus,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        jobId: json["job_id"],
        nama: json["nama"],
        oauthId: json["oauth_id"],
        email: json["email"],
        dateBirth: json["date_birth"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        linkedin: json["linkedin"],
        profilePicture: json["profile_picture"],
        role: json["role"],
        company: json["company"],
        activationCode: json["activation_code"],
        activationStatus: json["activation_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": jobId,
        "nama": nama,
        "oauth_id": oauthId,
        "email": email,
        "date_birth": dateBirth,
        "address": address,
        "phone_number": phoneNumber,
        "linkedin": linkedin,
        "profile_picture": profilePicture,
        "role": role,
        "company": company,
        "activation_code": activationCode,
        "activation_status": activationStatus,
      };
}
