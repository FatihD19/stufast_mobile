import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/notif_model.dart';
import 'package:stufast_mobile/services/Auth/notif_service.dart';

class NotificationProvider with ChangeNotifier {
  NotificationModel? _notification;
  NotificationModel? get notification => _notification;

  Future<void> getNotification() async {
    try {
      NotificationModel notificationModel =
          await NotificationService().getNotification();
      _notification = notificationModel;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
