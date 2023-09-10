import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_course_page.dart';
import 'package:stufast_mobile/theme.dart';

class CourseTile extends StatelessWidget {
  final CourseModel userCourse;
  final bool showProgress; // Make it optional with a default value of true

  CourseTile(this.userCourse,
      {this.showProgress = true}); // Provide a default value

  @override
  Widget build(BuildContext context) {
    String? progressText =
        '${userCourse.mengerjakan_video}'; // Assuming the format is "0 / 3"
    List<String> parts = progressText.split(' / ');
    int currentProgress = int.tryParse(parts[0]) ?? 0;
    int totalProgress = int.tryParse(parts[1]) ?? 1; // Avoid division by zero

    double progressPercentage = (currentProgress / totalProgress)
        .clamp(0.0, 1.0); // Ensure progress is between 0 and 1

    Color progressBarColor =
        progressPercentage == 1.0 ? primaryColor : Color(0XffFEC202);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailCoursePage(
                    idUserCourse: '${userCourse.courseId}',
                    progressCourse: progressPercentage,
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
          child: ListTile(
            leading: Image.network(
              '${userCourse.thumbnail}',
              width: 95,
              height: 95,
            ),
            title: Text(
              '${userCourse.title}',
              style: primaryTextStyle.copyWith(fontWeight: bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${userCourse.mengerjakan_video}',
                  style: secondaryTextStyle,
                ),
                SizedBox(height: 8),
                if (showProgress) // Use a condition to show/hide the Row
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progressPercentage,
                          backgroundColor: Color(
                              0xffF0DB96), // Background color of the progress bar
                          valueColor:
                              AlwaysStoppedAnimation<Color>(progressBarColor),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${(progressPercentage * 100).toInt()}%', // Convert to integer to remove decimal places
                        style: primaryTextStyle.copyWith(fontWeight: bold),
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
}
