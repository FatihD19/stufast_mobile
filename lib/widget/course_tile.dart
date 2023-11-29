import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_course_page.dart';
import 'package:stufast_mobile/theme.dart';

class CourseTile extends StatefulWidget {
  final CourseModel userCourse;
  final bool showProgress; // Make it optional with a default value of true

  CourseTile(this.userCourse, {this.showProgress = true});
  @override
  State<CourseTile> createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  // Provide a default value
  @override
  Widget build(BuildContext context) {
    String? progressText =
        '${widget.userCourse.mengerjakan_video ?? '2 / 3'}'; // Assuming the format is "0 / 3"
    List<String> parts = progressText.split(' / ');
    int currentProgress = int.tryParse(parts[0]) ?? 0;
    int totalProgress = int.tryParse(parts[1]) ?? 1; // Avoid division by zero

    double progressPercentage = (currentProgress / totalProgress)
        .clamp(0.0, 1.0); // Ensure progress is between 0 and 1
    int videoLeft = totalProgress - currentProgress;

    double scoreCourse = (widget.userCourse.score ?? 0.0) / 100;
    int persen = (progressPercentage * 100).toInt();

    Color progressBarColor =
        progressPercentage == 1.0 ? primaryColor : Color(0XffFEC202);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailCoursePage(
                    idUserCourse: '${widget.userCourse.courseId}',
                    // finishCourse: progressPercentage == 1.0 ? true : false,
                    totalDuration: widget.userCourse.total_video_duration,
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
            decoration: BoxDecoration(
              color: Color(0xFAFAFA), // Warna background FAFAFA
              border:
                  Border.all(color: Color(0xF3F3F3)), // Warna garis tepi F3F3F3
              borderRadius: BorderRadius.circular(8), // Sudut border radius
            ),
            child: Container(
              height: 134,
              padding: EdgeInsets.symmetric(vertical: 23, horizontal: 13),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '${widget.userCourse.thumbnail}',
                        width: 85,
                        height: 85,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 5),
                    Column(
                      children: [
                        Container(
                          width: 139,
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 40,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${widget.userCourse.title}',
                                  style: primaryTextStyle.copyWith(
                                      fontWeight: bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                videoLeft == 0
                                    ? 'Selesai'
                                    : '${videoLeft.toString()} Video Tersisa',
                                style: videoLeft == 0
                                    ? thirdTextStyle.copyWith(fontWeight: bold)
                                    : secondaryTextStyle.copyWith(
                                        fontWeight: bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Column(
                                children: [
                                  if (widget
                                      .showProgress) // Use a condition to show/hide the Row
                                    Row(
                                      children: [
                                        Expanded(
                                          child: LinearProgressIndicator(
                                            value: progressPercentage,
                                            backgroundColor: Color(
                                                0xffF0DB96), // Background color of the progress bar
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    progressBarColor),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '${(progressPercentage * 100).toInt()}%', // Convert to integer to remove decimal places
                                          style: primaryTextStyle.copyWith(
                                              fontWeight: bold),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: [
                          Text('Nilai', style: primaryTextStyle),
                          Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                    width: 34,
                                    height: 34,
                                    child: CircularProgressIndicator(
                                      value: scoreCourse,
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        scoreCourse == 1.0
                                            ? primaryColor
                                            : Color(0xFFfec202),
                                      ),
                                      backgroundColor: Colors.grey[300],
                                    )),
                                Center(
                                  child: Text('${widget.userCourse.score ?? 0}',
                                      style: primaryTextStyle.copyWith(
                                          fontWeight: bold)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            )),
      ),
    );
  }
}
// ListTile(
//   leading: ClipRRect(
//     borderRadius: BorderRadius.circular(8),
//     child: Image.network(
//       '${widget.userCourse.thumbnail}',
//       width: 85,
//       height: 85,
//       fit: BoxFit.cover,
//     ),
//   ),
//   title: Row(
//     children: [
//       Expanded(
//         child: Text(
//           '${widget.userCourse.title}',
//           style: primaryTextStyle.copyWith(fontWeight: bold),
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//       Container(
//         margin: EdgeInsets.only(top: 10),
//         alignment: Alignment.centerRight,
//         child: Column(
//           children: [
//             Text('Nilai', style: primaryTextStyle),
//             Container(
//               margin: EdgeInsets.all(10),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   SizedBox(
//                       width: 34,
//                       height: 34,
//                       child: CircularProgressIndicator(
//                         value: scoreCourse,
//                         strokeWidth: 3,
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                           scoreCourse == 1.0
//                               ? primaryColor
//                               : Color(0xFFfec202),
//                         ),
//                         backgroundColor: Colors.grey[300],
//                       )),
//                   Center(
//                     child: Text('${widget.userCourse.score ?? 0}',
//                         style: primaryTextStyle.copyWith(
//                             fontWeight: bold)),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       )
//     ],
//   ),
//   subtitle: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       if (widget.showProgress) // Use a condition to show/hide the Row
//         Row(
//           children: [
//             Expanded(
//               child: LinearProgressIndicator(
//                 value: progressPercentage,
//                 backgroundColor: Color(
//                     0xffF0DB96), // Background color of the progress bar
//                 valueColor:
//                     AlwaysStoppedAnimation<Color>(progressBarColor),
//               ),
//             ),
//             SizedBox(width: 8),
//             Text(
//               '${(progressPercentage * 100).toInt()}%', // Convert to integer to remove decimal places
//               style: primaryTextStyle.copyWith(fontWeight: bold),
//             ),
//           ],
//         ),
//     ],
//   ),
// ),

class CourseTileShimer extends StatelessWidget {
  const CourseTileShimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: [
              Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
