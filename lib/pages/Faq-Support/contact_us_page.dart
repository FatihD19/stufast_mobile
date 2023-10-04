import 'package:flutter/material.dart';

import '../../theme.dart';

import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQ',
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
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kepuasan kamu selama belajar menjadi prioritas kami",
              style: primaryTextStyle.copyWith(fontWeight: bold),
            ),
            SizedBox(height: 12),
            Text(
              "Kamu memiliki pertanyaan lain? Jangan ragu untuk menghubungi kami dengan formulir di bawah ini. Kami akan memberikan tanggapan sesegera mungkin.",
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            SizedBox(height: 24),
            Text("Tuliskan pesan kamu",
                style: primaryTextStyle.copyWith(fontWeight: bold)),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 380,
                maxHeight: 188,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA), // Warna latar belakang FAFAFA
                  border: Border.all(
                    color: Color(0xFFD2D2D2),
                    width: 1, // Border dengan stroke D2D2D2
                  ),
                  borderRadius: BorderRadius.circular(8), // Border radius 8
                ),
                child: TextField(
                  maxLines: 5,
                  // controller: controller,
                  decoration: InputDecoration(
                    // hintText: hintText,
                    hintStyle: secondaryTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    contentPadding: EdgeInsets.all(12),
                    border: InputBorder
                        .none, // Tidak menampilkan border bawaan TextField
                  ),
                ),
              ),
            ),
            VideoPlayerScreen()
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late FlickManager flickManager;
  String videoUrl =
      'https://dev.stufast.id/upload/course-video/19d2f84802cbd7374273d729783db3a6.mp4';

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.network(videoUrl), // Video awal
    );
  }

  void _changeVideo(String newVideoUrl) {
    setState(() {
      flickManager
          .handleChangeVideo(VideoPlayerController.network(newVideoUrl));
      videoUrl = newVideoUrl;
    });
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlickVideoPlayer(flickManager: flickManager),
        ElevatedButton(
          onPressed: () {
            _changeVideo(
                'https://dev.stufast.id/upload/course-video/19d2f84802cbd7374273d729783db3a6.mp4');
          },
          child: Text('Link 1'),
        ),
        ElevatedButton(
          onPressed: () {
            _changeVideo(
                'https://dev.stufast.id/upload/course-video/video.mp4');
          },
          child: Text('Link 2'),
        ),
      ],
    );
  }
}
