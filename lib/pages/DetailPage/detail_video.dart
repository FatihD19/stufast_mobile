// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/video_model.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:video_player/video_player.dart';

import '../../widget/video_tile.dart';

class VideoDetailPage extends StatefulWidget {
  final CourseModel detailCourse;
  final VideoModel video;
  VideoDetailPage(this.detailCourse, this.video);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    Widget videoTile() {
      final videoList = widget.detailCourse.video;
      return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: videoList?.length,
        itemBuilder: (context, index) {
          final video = videoList?[index];
          final opacity =
              widget.detailCourse.owned == true || index == 0 ? 1.0 : 0.5;
          final isLocked = index > 0 && videoList?[(index) - 1].resume == null;
          // return VideoTile(video?.title, video?.duration, detail?.owned,
          //     opacity, detail!, video?.video, video!);
          return VideoTile(
            opacity,
            widget.detailCourse,
            video!,
            isLocked: isLocked,
          );
        },
      );
    }

    Widget keterangan() {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.video.title}',
                style: primaryTextStyle.copyWith(fontWeight: bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.detailCourse.tag!
                        .map(
                          (tag) => Row(
                            children: [
                              Image.asset('assets/icon_tag.png'),
                              SizedBox(width: 8),
                              Text(
                                '${tag.name}',
                                style: secondaryTextStyle,
                              ),
                            ],
                          ),
                        )
                        .toList()),
                Row(
                  children: [
                    Image.asset('assets/icon_list.png'),
                    SizedBox(width: 8),
                    Text(
                      '${widget.video.duration} menit',
                      style: secondaryTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    final FlickManager flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.networkUrl(Uri.parse("${widget.video.video}")),
    );
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: FlickVideoPlayer(flickManager: flickManager),
            ), // Video di atas tab bar
            keterangan(),
            Container(
              color: Colors.white,
              child: TabBar(
                labelColor: Color(0xFF248043), // Warna teks saat aktif
                unselectedLabelColor:
                    Color(0xFF7D7D7D), // Warna teks saat tidak aktif
                indicatorWeight: 4, // Ketebalan garis tepi bawah saat aktif
                indicator: BoxDecoration(
                  color:
                      Color(0xFFE9F2EC), // Warna latar belakang saat tab aktif
                  border: Border(
                    bottom: BorderSide(
                      color: Color(
                          0xFF248043), // Warna garis tepi bawah saat aktif
                      width: 4, // Ketebalan garis tepi bawah saat aktif
                    ),
                  ),
                ), // W
                tabs: [
                  Tab(text: 'Video'), // Tab pertama dengan teks 'Video'
                  Tab(text: 'Project'), // Tab kedua dengan teks 'Project'
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Konten untuk tab 'Video'
                  Container(
                    padding: EdgeInsets.all(16),
                    child: videoTile(),
                  )
                  // Konten untuk tab 'Project' bisa Anda tambahkan di sini
                ],
              ),
            ),
          ],
        ),
        appBar: AppBar(
          title: Text(
            '${widget.video.title}',
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
          ),
          elevation: 0, // Menghilangkan shadow
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              flickManager.dispose();
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          centerTitle: false,
        ),
      ),
    );
  }
}
