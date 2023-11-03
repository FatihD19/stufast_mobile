class Review {
  String? userReviewId;
  String? userId;
  String? feedback;
  String? score;
  String? fullname;
  String? email;
  dynamic jobId;
  String? profilePicture;

  Review({
    this.userReviewId,
    this.userId,
    this.feedback,
    this.score,
    this.fullname,
    this.email,
    this.jobId,
    this.profilePicture,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        userReviewId: json["user_review_id"],
        userId: json["user_id"],
        feedback: json["feedback"],
        score: json["score"],
        fullname: json["fullname"],
        email: json["email"],
        jobId: json["job_id"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "user_review_id": userReviewId,
        "user_id": userId,
        "feedback": feedback,
        "score": score,
        "fullname": fullname,
        "email": email,
        "job_id": jobId,
        "profile_picture": profilePicture,
      };
}
