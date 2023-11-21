import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stufast_mobile/models/bundling_model.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_bundle_user.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_course_page.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/category_chip.dart';

class CardCourse extends StatefulWidget {
  CourseModel? course;
  bool isBundle;
  BundlingModel? bundle;
  CardCourse({this.course, this.isBundle = false, this.bundle});

  @override
  State<CardCourse> createState() => _CardCourseState();
}

class _CardCourseState extends State<CardCourse> {
  @override
  Widget build(BuildContext context) {
    String? progressText = widget.isBundle
        ? '${widget.bundle?.progress}'
        : '${widget.course?.mengerjakan_video ?? '1 / 2'}'; // Assuming the format is "0 / 3"
    List<String> parts = progressText.split(' / ');
    int currentProgress = int.tryParse(parts[0]) ?? 0;
    int totalProgress = int.tryParse(parts[1]) ?? 1;
    int courseLeft = totalProgress - currentProgress; // Avoid division by zero

    double progressPercentage = (currentProgress / totalProgress)
        .clamp(0.0, 1.0); // Ensure progress is between 0 and 1
    int persen = (progressPercentage * 100).toInt();
    Color progressBarColor =
        progressPercentage == 1.0 ? primaryColor : Color(0XffFEC202);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => widget.isBundle
                  ? DetailBundle(
                      idBundle: '${widget.bundle?.bundlingId}',
                      progressCourse: progressPercentage,
                      persen: persen,
                    )
                  : DetailCoursePage(
                      idUserCourse: '${widget.course?.courseId}',
                      totalDuration: widget.course?.total_video_duration,
                      progressCourse: progressPercentage,
                      persen: persen,
                    )),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 185,
          height: 255,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffF3F3F3),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInImage(
                    placeholder: AssetImage(
                        'assets/img_loading.gif'), // Gambar placeholder
                    image: NetworkImage(widget.isBundle
                        ? '${widget.bundle?.thumbnail}'
                        : '${widget.course?.thumbnail}'),
                    width: 185,
                    height: 96,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Container(
                          height: 40,
                          child: Text(
                              widget.isBundle
                                  ? '${widget.bundle?.title}'
                                  : '${widget.course?.title}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style:
                                  primaryTextStyle.copyWith(fontWeight: bold)),
                        ),
                        SizedBox(height: 4),

                        widget.isBundle == true
                            ? CustomChip(
                                label: widget.isBundle
                                    ? '${widget.bundle?.category_name}'
                                    : '${widget.course?.category}',
                              )
                            : SizedBox(),
                        widget.isBundle
                            ? Text('${widget.bundle?.authorCompany}',
                                style:
                                    secondaryTextStyle.copyWith(fontSize: 12))
                            : Text('${widget.course?.authorFullname}',
                                style:
                                    secondaryTextStyle.copyWith(fontSize: 12)),
                        SizedBox(height: 4),
                        widget.isBundle
                            ? SizedBox()
                            : RatingBarIndicator(
                                unratedColor: Color(0xffF0DB96),
                                rating: double.parse(
                                    '${widget.course!.rating_course}'),
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Color(0xffFFCB42),
                                ),
                                itemCount: 5,
                                itemSize: 25.0,
                                direction: Axis.horizontal,
                              ),

                        SizedBox(height: 7),
                        // widget.isBundle
                        //     ? SizedBox()
                        //     : Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: widget.course!.tag!
                        //             .map((tag) => Text(
                        //                   '- ${tag.name}',
                        //                   style: secondaryTextStyle.copyWith(
                        //                       fontSize: 12),
                        //                 ))
                        //             .toList(),
                        //       ),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: NumberFormat.simpleCurrency(locale: 'id')
                                    .format(int.parse(widget.isBundle
                                        ? '${widget.bundle?.oldPrice}'
                                        : '${widget.course?.oldPrice}'))
                                    .replaceAll(',00', ''),
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 11,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                            SizedBox(width: 3),
                            Text(
                              NumberFormat.simpleCurrency(locale: 'id')
                                  .format(int.parse(widget.isBundle
                                      ? '${widget.bundle?.newPrice}'
                                      : '${widget.course?.newPrice}'))
                                  .replaceAll(',00', ''),
                              style: thirdTextStyle.copyWith(
                                  fontSize: 12.45, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                      ],
                    ),
                  ),
                ],
              ),
              widget.isBundle
                  ? Positioned(
                      top: 0, // Sesuaikan posisi vertikal sesuai kebutuhan
                      left: 3, // Sesuaikan posisi horizontal sesuai kebutuhan
                      child: Transform(
                        transform: new Matrix4.identity()..scale(0.8),
                        child: Chip(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Text('Bundling',
                              style: thirdTextStyle.copyWith(fontSize: 12)),
                          backgroundColor: Colors
                              .white, // Sesuaikan warna background sesuai kebutuhan
                        ),
                      ),
                    )
                  : Positioned(
                      top: 0, // Sesuaikan posisi vertikal sesuai kebutuhan
                      left: 3,
                      child: Transform(
                        transform: new Matrix4.identity()..scale(0.8),
                        child: CustomChip(
                          label: widget.isBundle
                              ? '${widget.bundle?.category_name}'
                              : '${widget.course?.category}',
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardCourseShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 185,
          height: 255,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffF3F3F3),
          ),
        ),
      ),
    );
  }
}
