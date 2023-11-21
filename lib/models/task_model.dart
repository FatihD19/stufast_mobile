class TaskModel {
  String? videoId;
  String? title;
  String? task;
  dynamic quizScore;
  String? taskFile;
  String? date;
  String? status;

  TaskModel({
    this.videoId,
    this.title,
    this.task,
    this.quizScore,
    this.taskFile,
    this.date,
    this.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        videoId: json["video_id"],
        title: json["title"],
        task: json["task"],
        quizScore: json["quiz_score"],
        taskFile: json["task_file"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "video_id": videoId,
        "title": title,
        "task": task,
        "quiz_score": quizScore,
        "task_file": taskFile,
        "date": date,
        "status": status,
      };
}
