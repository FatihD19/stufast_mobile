import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/quiz_model.dart';
import 'package:stufast_mobile/models/video_model.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_video.dart';
import 'package:stufast_mobile/pages/DetailPage/quiz_page.dart';
import 'package:stufast_mobile/providers/quiz_provider.dart';
import 'package:stufast_mobile/theme.dart';

class VideoTile extends StatefulWidget {
  double opacity; // Opacity for this tile
  final CourseModel detailVideo;
  VideoModel video;
  bool? isLocked;

  dynamic progressCourse;
  String? totalDuration;
  int? persen;
  int? index;
  String? idCourse;

  VideoTile(this.opacity, this.detailVideo, this.video,
      {this.idCourse,
      this.isLocked,
      this.progressCourse,
      this.persen,
      this.totalDuration,
      this.index});

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  bool _customTileExpanded = false;
  List<QuizModel>? quiz;

  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);
    return Opacity(
      opacity: widget.video.video == null || widget.isLocked == true ? 0.5 : 1,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              leading: Image.asset('assets/icon_video.png'),
              title: Text(
                '${widget.video.title}',
                style: primaryTextStyle.copyWith(fontWeight: bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text('${widget.video.duration} menit',
                  style: secondaryTextStyle),
              children: [
                widget.video.video == null || widget.isLocked == true
                    ? SizedBox()
                    : Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(16, 6, 16, 0),
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoDetailPage(
                                              widget.detailVideo,
                                              widget.video,
                                              idCourse: widget.idCourse,
                                              progressCourse:
                                                  widget.progressCourse,
                                              persen: widget.persen,
                                              totalDuration:
                                                  widget.totalDuration,
                                              viewedVideoIndex: widget.index,
                                            )));
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
                                  borderRadius: BorderRadius.circular(
                                      10), // Border radius 10
                                ),
                              ),
                              child: Text(
                                'Lanjutkan Video',
                                style:
                                    thirdTextStyle.copyWith(fontWeight: bold),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
              // onExpansionChanged: (bool expanded) {
              //   setState(() {
              //     _customTileExpanded = expanded;
              //   });
              // },
            ),
          ),
        ),
      ),
    );
  }
}
