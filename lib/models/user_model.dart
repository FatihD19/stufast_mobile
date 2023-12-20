class UserModel {
  String? id;
  String? jobId;
  String? nama;
  String? fullname;
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
  String? token;
  String? message;
  String? job_name;

  UserModel(
      {this.id,
      this.jobId,
      this.nama,
      this.fullname,
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
      this.token,
      this.message,
      this.job_name});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      jobId: json["job_id"],
      nama: json["nama"],
      fullname: json["fullname"],
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
      token: json["token"],
      message: json['message'],
      job_name: json['job_name']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "job_id": jobId,
        "nama": nama,
        "fullname": fullname,
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
        "token": token,
        "message": message,
        "job_name": job_name
      };
}

class DropdownJobModel {
  String? jobId;
  String? jobName;

  DropdownJobModel({
    this.jobId,
    this.jobName,
  });

  factory DropdownJobModel.fromJson(Map<String, dynamic> json) =>
      DropdownJobModel(
        jobId: json["job_id"],
        jobName: json["job_name"],
      );

  Map<String, dynamic> toJson() => {
        "job_id": jobId,
        "job_name": jobName,
      };
}
