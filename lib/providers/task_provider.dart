import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/task_model.dart';

import '../services/task_service.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;
  bool loading = true;

  set tasks(List<TaskModel> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  Future<void> getTasks(String id) async {
    try {
      List<TaskModel> tasks = await TaskService().getTasks(id);
      _tasks = tasks;
      loading = false;
      notifyListeners();
    } catch (e) {
      tasks = [];
      print(e);
    }
  }

  Future<bool> uploadTask(String id, File taskFile) async {
    try {
      bool upload = await TaskService().uploadTask(id, taskFile);
      return upload;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
