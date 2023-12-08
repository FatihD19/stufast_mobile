// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_video.dart';
import 'package:stufast_mobile/pages/DetailPage/form_rating_view.dart';
import 'package:stufast_mobile/pages/checkout/checkout_page.dart';
import 'package:stufast_mobile/pages/home/my_course_page.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/providers/chart_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/description_widget.dart';
import 'package:stufast_mobile/widget/primary_button.dart';
import 'package:stufast_mobile/widget/review_widget.dart';
import 'package:stufast_mobile/widget/video_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../providers/user_course_provider.dart';

class DetailCoursePage extends StatefulWidget {
  String idUserCourse;
  dynamic progressCourse;
  String? totalDuration;
  int? persen;
  bool? fromResumeOrQuiz;
  bool? finishCourse = false;
  DetailCoursePage(
      {required this.idUserCourse,
      this.progressCourse,
      this.persen,
      this.totalDuration,
      this.fromResumeOrQuiz,
      this.finishCourse});

  @override
  State<DetailCoursePage> createState() => _DetailCoursePageState();
}

class _DetailCoursePageState extends State<DetailCoursePage> {
  bool? loading;
  List selectedIds = [];
  ReceivePort _port = ReceivePort();

  PermissionStatus _status = PermissionStatus.denied;

  Future<void> _checkPermissionStatus() async {
    await Permission.storage.request();
  }

  @override
  void initState() {
    // _checkPermissionStatus();
    super.initState();
    getInit();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // String id = data[0];
      DownloadTaskStatus status = data[1];
      // int progress = data[2];
      if (status == DownloadTaskStatus.complete) {
        print('BERHASIL UNDUH');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Sertifikat berhasil diunduh',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  checkFinishcourse() {
    String? progressText =
        Provider.of<UserCourseProvider>(context, listen: false)
                .detailCourse!
                .mengerjakan_video ??
            '1 / 2';
    // Assuming the format is "0 / 3"
    List<String> parts = progressText!.split(' / ');
    int currentProgress = int.tryParse(parts[0]) ?? 0;
    int totalProgress = int.tryParse(parts[1]) ?? 1;

    double progressPercentage =
        (currentProgress / totalProgress).clamp(0.0, 1.0);
    if (progressPercentage == 1.0) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Selamat Anda telah menyelesaikan Kursus',
          desc: 'Silahkan unduh sertifikat anda',
          btnOkOnPress: () {},
        ).show();
      });
    } else {
      print('not finish');
    }
  }

  getInit() async {
    setState(() {
      loading = true;
    });

    await Provider.of<UserCourseProvider>(context, listen: false)
        .getDetailUserCourse(widget.idUserCourse);
    checkFinishcourse();
    setState(() {
      loading = false;
    });
  }

  handleAddChart() async {
    if (await context
        .read<ChartProvider>()
        .addToChart('course', widget.idUserCourse)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'berhasil tambah ke chart',
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: 500),
          backgroundColor: Colors.red,
          content: Text(
            'Item sudah ada di keranjang',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserCourseProvider userDetailCourseProvider =
        Provider.of<UserCourseProvider>(context);

    CourseModel? detail = userDetailCourseProvider.detailCourse;

    String? progressText =
        '${detail?.mengerjakan_video ?? '1 / 2'}'; // Assuming the format is "0 / 3"
    List<String> parts = progressText.split(' / ');
    int currentProgress = int.tryParse(parts[0]) ?? 0;
    int totalProgress = int.tryParse(parts[1]) ?? 1;
    int courseLeft = totalProgress - currentProgress; // Avoid division by zero

    double progressPercentage = (currentProgress / totalProgress)
        .clamp(0.0, 1.0); // Ensure progress is between 0 and 1
    int persen = (progressPercentage * 100).toInt();
    Widget progressBar(double progress) {
      return detail?.owned == true
          ? Container(
              margin: EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                      width: 34,
                      height: 34,
                      child: CircularProgressIndicator(
                        value: progressPercentage,
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progressPercentage == 1.0
                              ? primaryColor
                              : Color(0xFFfec202),
                        ),
                        backgroundColor: Colors.grey[300],
                      )),
                  Center(
                    child: Text('${persen}',
                        style: primaryTextStyle.copyWith(fontWeight: bold)),
                  ),
                ],
              ),
            )
          : SizedBox();
    }

    Widget imageCourse() {
      return Image.network(
        '${detail?.thumbnail}',
        width: double.infinity,
        height: 183,
        fit: BoxFit.cover,
      );
    }

    Widget videoTile() {
      final videoList = detail?.video;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text('${detail?.video?.length} video',
                style:
                    primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: videoList?.length,
                itemBuilder: (context, index) {
                  final video = videoList?[index];
                  // final isLocked = index > 0 && videoList?[(index) - 1].resume == null;

                  final isLocked = index > 0 &&
                      int.parse(videoList![(index) - 1].score ?? '0') < 60;

                  // Tambahkan isLocked ke VideoTile
                  return VideoTile(
                    detail?.owned == true || index == 0 ? 1.0 : 0.5,
                    detail!,
                    video!,
                    isLocked: isLocked,
                    progressCourse: widget.progressCourse,
                    persen: widget.persen,
                    totalDuration: widget.totalDuration,
                    index: index,
                    idCourse: widget.idUserCourse,
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget infoHeader() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${detail?.title}',
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 17),
                  ),
                ),
                detail?.owned == true
                    ? SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: NumberFormat.simpleCurrency(locale: 'id')
                                  .format(int.parse('${detail?.oldPrice}'))
                                  .replaceAll(',00', ''),
                              style: secondaryTextStyle.copyWith(
                                fontSize: 15,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          SizedBox(width: 3),
                          Text(
                            NumberFormat.simpleCurrency(locale: 'id')
                                .format(int.parse('${detail?.newPrice}'))
                                .replaceAll(',00', ''),
                            style: thirdTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Author : ',
                        style: buttonTextStyle.copyWith(fontSize: 12)),
                    TextSpan(
                        text: '${detail?.authorFullname}',
                        style: buttonTextStyle.copyWith(
                            fontSize: 12, fontWeight: bold)),
                  ])),
                  backgroundColor: Colors.orange,
                ),
                progressPercentage < 1.0
                    ? SizedBox()
                    : InkWell(
                        onTap: () {
                          detail?.is_review == true
                              ? userDetailCourseProvider
                                  .downloadSertif(
                                    idCourse: widget.idUserCourse,
                                  )
                                  .then((value) => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                            'berhasil unduh sertifikar',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ))
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return RatingFormDialog(
                                      widget.idUserCourse,
                                    );
                                  },
                                );
                        },
                        child: Chip(
                          label: Row(
                            children: [
                              Icon(Icons.download_for_offline_outlined,
                                  color: buttonTextColor),
                              SizedBox(width: 4),
                              Text('Unduh Sertifikat',
                                  style:
                                      buttonTextStyle.copyWith(fontSize: 12)),
                            ],
                          ),
                          backgroundColor: primaryColor,
                        ),
                      ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: detail!.tag!
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Durasi Video :',
                        style:
                            secondaryTextStyle.copyWith(fontWeight: semiBold)),
                    Row(
                      children: [
                        Image.asset('assets/icon_list.png'),
                        SizedBox(width: 8),
                        Text(
                          '${detail.total_video_duration}',
                          style: secondaryTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }

    Widget actionBtn() {
      return context.read<AuthProvider>().user?.fullname == null
          ? Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            primaryColor, // Warna teks saat di atas latar hijau
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Border radius 10
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/landing-page');
                      },
                      child: Text(
                        'Login untuk membeli Course',
                        style: buttonTextStyle.copyWith(
                            fontSize: 14, fontWeight: bold),
                      )),
                ),
                SizedBox(height: 12)
              ],
            )
          : Column(
              children: [
                SizedBox(height: 24),
                detail?.owned == true
                    ? SizedBox()
                    : Column(
                        children: [
                          Container(
                              width: double.infinity,
                              height: 54,
                              child: PrimaryButton(
                                  text: 'Beli Sekarang',
                                  onPressed: () {
                                    selectedIds.add(detail?.courseId);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CheckOutPage(
                                                selectedIds,
                                                type: 'course',
                                              )),
                                    );
                                  })),
                          SizedBox(height: 18),
                          Container(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              onPressed: handleAddChart,
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Latar belakang putih
                                onPrimary: Color(
                                    0xFF248043), // Warna teks saat di atas latar putih
                                side: BorderSide(
                                    color: Color(0xFF248043),
                                    width:
                                        2), // Border berwarna 248043 dengan lebar 2
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Border radius 10
                                ),
                              ),
                              child: Text(
                                'Masukan ke Keranjang',
                                style:
                                    thirdTextStyle.copyWith(fontWeight: bold),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
              ],
            );
    }

    Widget infoDesc() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            SizedBox(height: 18),
            Text(
              'Deskripsi',
              style: primaryTextStyle.copyWith(fontWeight: bold),
            ),
            // TruncatedText(
            //   text: '${detail?.description}',
            //   maxLines: 3,
            // ),
            // DescriptionList(description: '${detail?.description}'),
            // DescriptionText(text: '${detail?.description}'),
            ExpandableText(
              '${detail?.description?.replaceAll('\r\n                        ', '\n')}',
              style: secondaryTextStyle,
              maxLines: 7,
              expandText: 'show more',
              collapseText: 'show less',
              linkColor: primaryColor,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 18),
            Text(
              'Key Takeway',
              style: primaryTextStyle.copyWith(fontWeight: bold),
            ),

            ExpandableText(
              '${detail?.keyTakeaways?.replaceAll('\r\n                        ', '\n')}',
              style: secondaryTextStyle,
              maxLines: 7,
              expandText: 'show more',
              collapseText: 'show less',
              linkColor: primaryColor,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            actionBtn(),
          ],
        ),
      );
    }

    Widget infoReview() {
      return detail!.review!.isEmpty
          ? Column(
              children: [
                SizedBox(height: 50),
                Image.asset('assets/img_empty_review.png'),
                SizedBox(height: 24),
                Text(
                  'Belum ada review',
                  style:
                      primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18),
                ),
              ],
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                  children: detail!.review!
                      .map((review) => ReviewTile(review))
                      .toList()));
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoHeader(),
            infoDesc(),
            Text('${detail?.video?.length} video',
                style: primaryTextStyle.copyWith(fontWeight: bold)),
            videoTile(),
            actionBtn(),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () {
        widget.fromResumeOrQuiz == true
            ? Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyCoursePage()))
            : Navigator.pop(context);
        return Future.value(false);
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Detail Course',
              style:
                  primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
            ),
            elevation: 0, // Menghilangkan shadow
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                widget.fromResumeOrQuiz == true
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyCoursePage()))
                    : Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
            centerTitle: false,
            actions: [loading == false ? progressBar(0.62) : SizedBox()],
          ),
          body: Center(
            child: loading == false
                ? Column(
                    children: [
                      imageCourse(),
                      infoHeader(),
                      Container(
                        color: Colors.white,
                        // ignore: prefer_const_constructors
                        child: TabBar(
                          labelColor:
                              Color(0xFF248043), // Warna teks saat aktif
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
                                width:
                                    4, // Ketebalan garis tepi bawah saat aktif
                              ),
                            ),
                          ), // W
                          tabs: [
                            Tab(
                                text:
                                    'Deskripsi'), // Tab pertama dengan teks 'Video'
                            Tab(text: 'Kurikulum'),
                            Tab(
                                text:
                                    'Review'), // Tab kedua dengan teks 'Project'
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Konten untuk tab 'Video'
                            infoDesc(),
                            videoTile(),
                            infoReview(),
                            // Konten untuk tab 'Project' bisa Anda tambahkan di sini
                          ],
                        ),
                      ),
                    ],
                  )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
