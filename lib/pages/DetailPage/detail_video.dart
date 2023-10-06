// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/video_model.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_course_page.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:video_player/video_player.dart';

import '../../widget/video_tile.dart';

class VideoDetailPage extends StatefulWidget {
  CourseModel detailCourse;
  VideoModel video;

  dynamic progressCourse;
  String? totalDuration;
  int? persen;
  int? viewedVideoIndex;

  VideoDetailPage(this.detailCourse, this.video,
      {this.progressCourse,
      this.totalDuration,
      this.persen,
      this.viewedVideoIndex});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late FlickManager flickManager;

  VideoModel? selectedVideo;
  List<bool> isVideoViewed = [];

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse("${widget.video.video}")), // Video awal
    );
    isVideoViewed =
        List.generate(widget.detailCourse.video?.length ?? 0, (index) => false);
  }

  void _changeVideo(String newVideoUrl, VideoModel currentVideo) {
    setState(() {
      flickManager.handleChangeVideo(
          VideoPlayerController.networkUrl(Uri.parse(newVideoUrl)));
      // videoUrl = newVideoUrl;
      widget.video = currentVideo;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget videoPlayTile(
        VideoModel video, bool isLocked, String subtitleText, int index) {
      return Opacity(
        opacity: video.video == null ? 0.5 : 1,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: subtitleText == "view"
                      ? primaryColor
                      : Colors.transparent)),
          child: Container(
            padding: EdgeInsets.all(12),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: Image.asset('assets/icon_video.png'),
                title: Text(
                  '${video.title}',
                  style: primaryTextStyle.copyWith(fontWeight: bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing:
                    Text('${video.duration} menit', style: secondaryTextStyle),
                children: [
                  video.video == null || isLocked == true
                      ? SizedBox()
                      : Container(
                          margin: EdgeInsets.all(16),
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              _changeVideo("${video.video}", video);
                              setState(() {
                                widget.viewedVideoIndex = index;
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
                                borderRadius: BorderRadius.circular(
                                    10), // Border radius 10
                              ),
                            ),
                            child: Text(
                              "Lanjutkan",
                              style: thirdTextStyle.copyWith(fontWeight: bold),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget videoTile() {
      final videoList = widget.detailCourse.video;
      return Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: videoList?.length,
          itemBuilder: (context, index) {
            final video = videoList?[index];
            final opacity =
                widget.detailCourse.owned == true || index == 0 ? 1.0 : 0.5;
            final isLocked =
                index > 0 && videoList?[(index) - 1].resume == null;
            // bool currentVideo = isVideoViewed[index];
            String subtitleText =
                widget.viewedVideoIndex == index ? "view" : "unview";
            return videoPlayTile(video!, isLocked, subtitleText, index);
          },
        ),
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

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       '${widget.video.title}',
    //       style: primaryTextStyle.copyWith(fontWeight: semiBold),
    //     ),
    //     elevation: 0, // Menghilangkan shadow
    //     leading: IconButton(
    //       icon: Icon(Icons.arrow_back),
    //       color: Colors.black,
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //     ),
    //     backgroundColor: Colors.white,
    //     centerTitle: false,
    //   ),
    //   body: ListView(shrinkWrap: true, children: [
    //     AspectRatio(
    //       aspectRatio: 16 / 9,
    //       child: FlickVideoPlayer(flickManager: flickManager),
    //     ), // Video di atas tab bar
    //     keterangan(),
    //     videoTile(),
    //   ]),
    // );

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
                  videoTile(),
                  Center(child: Text('tugas'))
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => DetailCoursePage(
              //             idUserCourse: "${widget.detailCourse.courseId}",
              //             progressCourse: widget.progressCourse,
              //             persen: widget.persen,
              //             totalDuration: widget.totalDuration,
              //           )),
              // );
            },
          ),
          backgroundColor: Colors.white,
          centerTitle: false,
        ),
      ),
    );
  }
}
