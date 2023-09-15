import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/video_model.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatelessWidget {
  final CourseModel detailCourse;
  final VideoModel video;
  VideoDetailPage(this.detailCourse, this.video);

  @override
  Widget build(BuildContext context) {
    final FlickManager flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network("${video.video}"),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '${video.title}',
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
        elevation: 0, // Menghilangkan shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: AspectRatio(
        aspectRatio: 16 / 9,
        child: FlickVideoPlayer(flickManager: flickManager),
      ),
    );
  }
}
