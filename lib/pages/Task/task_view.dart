import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/pages/Task/detail_task_page.dart';
import 'package:stufast_mobile/widget/task_tile.dart';

import '../../providers/task_provider.dart';
import '../../theme.dart';

class TaskView extends StatefulWidget {
  String courseId;
  Function? callback;
  FlickManager? flickManager;
  TaskView(this.courseId, {this.callback, this.flickManager, super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  void initState() {
    // TODO: implement initState
    getInit();
    super.initState();
  }

  getInit() async {
    await Provider.of<TaskProvider>(context, listen: false)
        .getTasks(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    Widget fetchTask() {
      return Consumer<TaskProvider>(
        builder: (context, taskState, _) {
          if (taskState.tasks.isNotEmpty) {
            return ListView.builder(
              itemCount: taskState.tasks.length,
              itemBuilder: (context, index) {
                final isLocked = index > 0 &&
                    int.parse(
                            taskState.tasks[(index) - 1].quizScore.toString()) <
                        60;

                return TaksTile(
                  taskState.tasks[index],
                  courseId: widget.courseId,
                  flickManager: widget.flickManager,
                  isLocked: isLocked,
                );
              },
            );
          } else {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Image.asset('assets/img_null_task.png'),
                  SizedBox(height: 20),
                  Text('Kamu tidak punya tugas',
                      style: primaryTextStyle.copyWith(fontWeight: bold)),
                ],
              ),
            );
          }
        },
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: fetchTask(),
    );
  }
}
