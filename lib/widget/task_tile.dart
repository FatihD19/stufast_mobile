import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/task_model.dart';
import 'package:stufast_mobile/pages/Task/detail_task_page.dart';
import 'package:stufast_mobile/theme.dart';

class TaksTile extends StatefulWidget {
  TaskModel task;

  FlickManager? flickManager;
  String? courseId;
  bool? isLocked;
  TaksTile(this.task,
      {this.courseId, this.flickManager, this.isLocked, super.key});

  @override
  State<TaksTile> createState() => _TaksTileState();
}

class _TaksTileState extends State<TaksTile> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.isLocked == true ? 0.5 : 1,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: ExpansionTile(
          title: ListTile(
            leading: widget.isLocked == true
                ? Icon(Icons.lock, color: Colors.black)
                : Icon(Icons.bookmark_border_outlined, color: primaryColor),
            title: Text(
              '${widget.task.title}',
              textAlign: TextAlign.justify,
              style: primaryTextStyle.copyWith(fontWeight: bold),
            ),
            subtitle: Row(
              children: [
                Text('Status : ',
                    style: secondaryTextStyle.copyWith(fontWeight: medium)),
                Text(
                  '${widget.task.status}',
                  style: secondaryTextStyle.copyWith(fontWeight: semiBold),
                ),
              ],
            ),
          ),
          trailing: SizedBox(),
          children: [
            widget.isLocked == true
                ? SizedBox()
                : Column(
                    children: [
                      Container(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tugas 1: ${widget.task.title}',
                                style: primaryTextStyle.copyWith(fontSize: 16)),
                            SizedBox(height: 5),
                            Text('${widget.task.task}',
                                style: primaryTextStyle.copyWith(
                                    fontWeight: bold)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(12),
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailTaskPage(
                                      widget.task, '${widget.courseId}')),
                            );
                            setState(() {
                              widget.flickManager?.flickControlManager?.pause();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, // Latar belakang putih
                            onPrimary: Color(
                                0xFF164520), // Warna teks saat di atas latar putih
                            side: BorderSide(
                                color: Color(0xFF164520),
                                width:
                                    2), // Border berwarna 248043 dengan lebar 2
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Border radius 10
                            ),
                          ),
                          child: Text(
                            "Detail Tugas",
                            style: thirdTextStyle.copyWith(fontWeight: bold),
                          ),
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
