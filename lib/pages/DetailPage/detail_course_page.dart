import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/description_widget.dart';
import 'package:stufast_mobile/widget/primary_button.dart';
import 'package:stufast_mobile/widget/video_tile.dart';

import '../../providers/user_course_provider.dart';

class DetailCoursePage extends StatefulWidget {
  String idUserCourse;
  dynamic progressCourse;
  DetailCoursePage({required this.idUserCourse, this.progressCourse});

  @override
  State<DetailCoursePage> createState() => _DetailCoursePageState();
}

class _DetailCoursePageState extends State<DetailCoursePage> {
  bool? loading;
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    setState(() {
      loading = true;
    });
    await Provider.of<UserCourseProvider>(context, listen: false)
        .getDetailUserCourse(widget.idUserCourse);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserCourseProvider userDetailCourseProvider =
        Provider.of<UserCourseProvider>(context);

    CourseModel? detail = userDetailCourseProvider.detailCourse;

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
                        value: widget.progressCourse,
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.progressCourse == 1.0
                              ? primaryColor
                              : Color(0xFFfec202),
                        ),
                        backgroundColor: Colors.grey[300],
                      )),
                  Center(
                    child: Text('${(widget.progressCourse * 100).toInt()}',
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
        height: 233,
      );
    }

    Widget videoTile() {
      return Column(
          children: detail!.video!
              .map((video) => VideoTile(video.title, video.duration))
              .toList());
    }

    Widget content() {
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
                Column(
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
                Row(
                  children: [
                    Image.asset('assets/icon_list.png'),
                    SizedBox(width: 8),
                    Text(
                      '2 Video - 17 menit',
                      style: secondaryTextStyle,
                    ),
                  ],
                ),
              ],
            ),
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
            ExpandableText(text: '${detail?.description}'),
            Text('${detail.video?.length} video',
                style: primaryTextStyle.copyWith(fontWeight: bold)),
            videoTile(),
            SizedBox(height: 24),
            detail.owned == true
                ? SizedBox()
                : Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 54,
                          child: PrimaryButton(
                              text: 'Beli Sekarang', onPressed: () {})),
                      SizedBox(height: 18),
                      Container(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, // Latar belakang putih
                            onPrimary: Color(
                                0xFF248043), // Warna teks saat di atas latar putih
                            side: BorderSide(
                                color: Color(0xFF248043),
                                width:
                                    2), // Border berwarna 248043 dengan lebar 2
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Border radius 10
                            ),
                          ),
                          child: Text(
                            'Masukan ke Keranjang',
                            style: thirdTextStyle.copyWith(fontWeight: bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Course',
          style: primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
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
        actions: [progressBar(0.62)],
      ),
      body: SafeArea(
          child: Center(
        child: loading == false
            ? ListView(
                children: [imageCourse(), content()],
              )
            : CircularProgressIndicator(),
      )),
    );
  }
}
