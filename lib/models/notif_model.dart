class NotificationModel {
  int? unread;
  List<Notification>? notification;

  NotificationModel({
    this.unread,
    this.notification,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        unread: json["unread"],
        notification: json["notification"] == null
            ? []
            : List<Notification>.from(
                json["notification"]!.map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "unread": unread,
        "notification": notification == null
            ? []
            : List<dynamic>.from(notification!.map((x) => x.toJson())),
      };
}

class Notification {
  String? userNotificationId;
  String? userId;
  String? notificationId;
  String? read;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? message;
  String? public;
  String? notificationCategoryId;
  String? thumbnail;
  String? link;

  Notification({
    this.userNotificationId,
    this.userId,
    this.notificationId,
    this.read,
    this.createdAt,
    this.updatedAt,
    this.message,
    this.public,
    this.notificationCategoryId,
    this.thumbnail,
    this.link,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        userNotificationId: json["user_notification_id"],
        userId: json["user_id"],
        notificationId: json["notification_id"],
        read: json["read"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        message: json["message"],
        public: json["public"],
        notificationCategoryId: json["notification_category_id"],
        thumbnail: json["thumbnail"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "user_notification_id": userNotificationId,
        "user_id": userId,
        "notification_id": notificationId,
        "read": read,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "message": message,
        "public": public,
        "notification_category_id": notificationCategoryId,
        "thumbnail": thumbnail,
        "link": link,
      };
}
