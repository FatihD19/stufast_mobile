// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/video_model.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_course_page.dart';
import 'package:stufast_mobile/pages/DetailPage/quiz_page.dart';
import 'package:stufast_mobile/pages/DetailPage/resume_page.dart';
import 'package:stufast_mobile/pages/Task/task_view.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/providers/quiz_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/primary_button.dart';
import 'package:video_player/video_player.dart';

import '../../models/quiz_model.dart';
import '../../widget/video_tile.dart';

class VideoDetailPage extends StatefulWidget {
  CourseModel detailCourse;
  VideoModel video;

  dynamic progressCourse;
  String? totalDuration;
  int? persen;
  int? viewedVideoIndex;
  String? idCourse;

  VideoDetailPage(this.detailCourse, this.video,
      {this.idCourse,
      this.progressCourse,
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
  List<QuizModel>? quiz;

  // ScrollController _scrollController = ScrollController();
  // void scrollToSelected() {
  //   int selectedIndex = yourItemList.indexWhere((item) => item.selected);
  //   if (selectedIndex != -1) {
  //     _scrollController.animateTo(
  //       selectedIndex *
  //           yourItemHeight, // Gantilah yourItemHeight dengan tinggi setiap item
  //       duration: Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();

    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
            Uri.parse("${widget.video.video}")), // Video awal
        onVideoEnd: widget.detailCourse.owned == false
            ? null
            : () async {
                setState(() {
                  widget.viewedVideoIndex = widget.viewedVideoIndex! + 1;
                });
                int.parse(widget.video.score!) > 60
                    ? _changeVideo(
                        '${widget.detailCourse.video?[widget.viewedVideoIndex!].video}',
                        widget.detailCourse.video![widget.viewedVideoIndex!])
                    : await Provider.of<QuizProvider>(context, listen: false)
                        .getQuiz("${widget.video.videoId}")
                        .then((value) {
                        quiz = Provider.of<QuizProvider>(context, listen: false)
                            .quizList;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizPage(
                                    widget.video.videoId,
                                    detailQuiz: quiz,
                                    title: widget.video.title,
                                    idCourse: '${widget.idCourse}',
                                  )),
                        );
                      });
              });
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
        opacity: video.video == null || isLocked == true ? 0.5 : 1,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                  color: video.videoId == widget.video.videoId
                      ? primaryColor
                      : Colors.transparent)),
          child: Container(
            padding: EdgeInsets.all(12),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: video.video == null || isLocked == true
                    ? Icon(
                        Icons.lock,
                        color: Colors.black,
                      )
                    : Image.asset('assets/icon_video.png'),
                title: Text(
                  '${video.title}',
                  // ${widget.viewedVideoIndex}
                  style: primaryTextStyle.copyWith(fontWeight: bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing:
                    Text('${video.duration} menit', style: secondaryTextStyle),
                children: [
                  video.video == null || isLocked == true
                      ? SizedBox()
                      : Column(
                          children: [
                            widget.detailCourse.owned == false
                                ? SizedBox()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          // flickManager.dispose();
                                          // _changeVideo("${video.video}", video);
                                          setState(() {
                                            widget.viewedVideoIndex = index;
                                          });
                                          await Provider.of<QuizProvider>(
                                                  context,
                                                  listen: false)
                                              .getQuiz("${video.videoId}");
                                          quiz = Provider.of<QuizProvider>(
                                                  context,
                                                  listen: false)
                                              .quizList;

                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => QuizPage(
                                                      video.videoId,
                                                      detailQuiz: quiz,
                                                      title: video.title,
                                                      idCourse:
                                                          '${widget.idCourse}',
                                                    )),
                                          );
                                        },
                                        child: Container(
                                          height: 60,
                                          width: 135,
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 6, horizontal: 10),
                                              child: Row(
                                                children: [
                                                  video.isViewed == "true"
                                                      ? Image.asset(
                                                          'assets/ic_quiz.png',
                                                          width: 40,
                                                          height: 40,
                                                        )
                                                      : Icon(Icons.lock),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "Quiz",
                                                    style: secondaryTextStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                semiBold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: video.resume == null
                                            ? null
                                            : () {
                                                // flickManager.dispose();

                                                flickManager
                                                    .flickControlManager!
                                                    .pause();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ResumePage(
                                                            '${video.videoId}',
                                                            isDetail: true,
                                                            idResume: video
                                                                .resume
                                                                ?.resumeId,
                                                            detail:
                                                                video.resume,
                                                            courseId:
                                                                widget.idCourse,
                                                          )),
                                                );
                                              },
                                        child: Container(
                                          height: 60,
                                          width: 135,
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 6, horizontal: 10),
                                              child: Row(
                                                children: [
                                                  video.resume == null
                                                      ? Icon(Icons.lock)
                                                      : Image.asset(
                                                          'assets/ic_quiz.png',
                                                          width: 40,
                                                          height: 40,
                                                        ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Resume',
                                                    style: secondaryTextStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                semiBold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                            Container(
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
                                  style:
                                      thirdTextStyle.copyWith(fontWeight: bold),
                                ),
                              ),
                            ),
                          ],
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
          // controller: _scrollController,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: videoList?.length,
          itemBuilder: (context, index) {
            final video = videoList?[index];
            final opacity =
                widget.detailCourse.owned == true || index == 0 ? 1.0 : 0.5;
            // final isLocked =
            //     index > 0 && videoList?[(index) - 1].resume == null;
            final isLocked =
                index > 0 && int.parse(videoList![(index) - 1].score) < 60;
            // bool currentVideo = isVideoViewed[index];
            String subtitleText =
                widget.viewedVideoIndex == index ? "view" : "unview";
            return videoPlayTile(video!, isLocked, subtitleText, index);
          },
        ),
      );
    }

    Widget keterangan() {
      bool resumeUndone = widget.video.resume?.resume == "" ||
          widget.video.resume?.resume == null;
      int passScore = int.parse(widget.video.score ?? '0');
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  children: [
                    SizedBox(height: 8),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Nilai Quiz: ',
                          style: secondaryTextStyle.copyWith(
                              fontWeight: semiBold)),
                      TextSpan(
                          text: passScore < 60
                              ? 'Belum lulus'
                              : '${widget.video.score}',
                          style: secondaryTextStyle.copyWith(
                              fontWeight: semiBold,
                              color:
                                  passScore < 60 ? Colors.red : primaryColor))
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Resume: ',
                          style: secondaryTextStyle.copyWith(
                              fontWeight: semiBold)),
                      TextSpan(
                          text: resumeUndone == true
                              ? 'Belum dikerjakan'
                              : 'Sudah dikerjakan',
                          style: secondaryTextStyle.copyWith(
                              fontWeight: semiBold,
                              color: resumeUndone == true
                                  ? Colors.red
                                  : primaryColor))
                    ]))
                  ],
                ),
                // Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: widget.detailCourse.tag!
                //         .map(
                //           (tag) => Row(
                //             children: [
                //               Image.asset('assets/icon_tag.png'),
                //               SizedBox(width: 8),
                //               Text(
                //                 '${tag.name}',
                //                 style: secondaryTextStyle,
                //               ),
                //             ],
                //           ),
                //         )
                //         .toList()),
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

    return widget.detailCourse.owned == false ||
            context.read<AuthProvider>().user?.fullname == null
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                '${widget.video.title} ',
                style: primaryTextStyle.copyWith(fontWeight: semiBold),
              ),
              elevation: 0, // Menghilangkan shadow
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailCoursePage(
                              idUserCourse: "${widget.detailCourse.courseId}",
                            )),
                  );
                },
              ),
              backgroundColor: Colors.white,
              centerTitle: false,
            ),
            body: Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: FlickVideoPlayer(flickManager: flickManager),
                ), // Video d
                SizedBox(height: 24),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: PrimaryButton(
                      text: 'Beli Kursus untuk Akses video berikutnya',
                      onPressed: () {
                        context.read<AuthProvider>().user?.fullname == null
                            ? Navigator.pushNamed(context, '/login')
                            : Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailCoursePage(
                                          idUserCourse:
                                              "${widget.detailCourse.courseId}",
                                        )),
                              );
                      }),
                )
              ],
            ))
        : DefaultTabController(
            length: 2, // Jumlah tab
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  '${widget.video.title} ',
                  style: primaryTextStyle.copyWith(fontWeight: semiBold),
                ),
                elevation: 0, // Menghilangkan shadow
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailCoursePage(
                                idUserCourse: "${widget.detailCourse.courseId}",
                              )),
                    );
                  },
                ),
                backgroundColor: Colors.white,
                centerTitle: false,
              ),
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: FlickVideoPlayer(
                      flickManager: flickManager,
                      flickVideoWithControls: FlickVideoWithControls(
                        playerLoadingFallback:
                            Stack(alignment: Alignment.center, children: [
                          Image.network(widget.video.thumbnail!),
                          CircularProgressIndicator(
                            color: secondaryTextColor,
                          ),
                        ]),
                        textStyle: secondaryTextStyle.copyWith(
                            fontSize: 18, fontWeight: bold),
                        controls: IconTheme(
                            data: IconThemeData(color: primaryColor),
                            child: FlickPortraitControls(
                              progressBarSettings: FlickProgressBarSettings(
                                bufferedColor: primaryColor.withOpacity(0.2),
                                playedColor: primaryColor,
                                handleColor: primaryColor,
                                backgroundColor: secondaryTextColor,
                              ),
                            )),
                      ),
                    ),
                  ), // Video di atas tab bar
                  keterangan(),
                  Container(
                    color: Colors.white,
                    child: TabBar(
                      labelColor: Color(0xFF248043), // Warna teks saat aktif
                      unselectedLabelColor:
                          Color(0xFF7D7D7D), // Warna teks saat tidak aktif
                      indicatorWeight:
                          4, // Ketebalan garis tepi bawah saat aktif
                      indicator: BoxDecoration(
                        color: Color(
                            0xFFE9F2EC), // Warna latar belakang saat tab aktif
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
                        Tab(text: 'Tugas'),
                        // Tab(text: 'Diskusi'), // Tab kedua dengan teks 'Project'
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Konten untuk tab 'Video'
                        videoTile(),
                        TaskView('${widget.idCourse}',
                            flickManager: flickManager),
                        Center(child: Text('diskusi')),
                        // Konten untuk tab 'Project' bisa Anda tambahkan di sini
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
