import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/bundling_model.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_bundle_user.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/course_tile.dart';

class BundlingTile extends StatefulWidget {
  final BundlingModel userBundle;

  BundlingTile(this.userBundle);

  @override
  State<BundlingTile> createState() => _BundlingTileState();
}

class _BundlingTileState extends State<BundlingTile> {
  bool isExpanded = false;

  CourseModel? userCourse;

  @override
  Widget build(BuildContext context) {
    String? progressText =
        '${widget.userBundle.progress}'; // Assuming the format is "0 / 3"
    List<String> parts = progressText.split(' / ');
    int currentProgress = int.tryParse(parts[0]) ?? 0;
    int totalProgress = int.tryParse(parts[1]) ?? 1;
    int courseLeft = totalProgress - currentProgress; // Avoid division by zero

    double progressPercentage = (currentProgress / totalProgress)
        .clamp(0.0, 1.0); // Ensure progress is between 0 and 1
    int persen = (progressPercentage * 100).toInt();
    Color progressBarColor =
        progressPercentage == 1.0 ? primaryColor : Color(0XffFEC202);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded; // Toggle the expanded state
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailBundle(
                              idBundle: '${widget.userBundle.bundlingId}',
                              progressCourse: progressPercentage,
                              persen: persen,
                            )),
                  );
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    ClipRRect(
                        // Add ClipRRect to apply border radius
                        borderRadius: BorderRadius.circular(8.0),
                        child: FadeInImage(
                            width: 86,
                            height: 86,
                            fit: BoxFit.cover,
                            placeholder: AssetImage('assets/img_loading.gif'),
                            image: NetworkImage(
                                '${widget.userBundle.thumbnail}'))),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            '${widget.userBundle.title}',
                            style: primaryTextStyle.copyWith(
                                fontWeight: FontWeight.bold),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          courseLeft == 0
                              ? 'Selesai'
                              : courseLeft.toString() + ' Course Tersisa',
                          style: secondaryTextStyle,
                        ),
                        Row(
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width * 0.5) -
                                  31,
                              child: LinearProgressIndicator(
                                value: progressPercentage,
                                backgroundColor: Color(
                                    0xffF0DB96), // Background color of the progress bar
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    progressBarColor),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                                '${(progressPercentage * 100).toInt()}%', // Convert to integer to remove decimal places
                                style: primaryTextStyle.copyWith(
                                    fontWeight: bold)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // ListTile(
            //   onTap: () {
            //     setState(() {
            //       isExpanded = !isExpanded; // Toggle the expanded state
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => DetailBundle(
            //                   idBundle: '${widget.userBundle.bundlingId}',
            //                   progressCourse: progressPercentage,
            //                   persen: persen,
            //                 )),
            //       );
            //     });
            //   },
            //   leading: ClipRRect(
            //       // Add ClipRRect to apply border radius
            //       borderRadius: BorderRadius.circular(8.0),
            //       child: FadeInImage(
            //           width: 96,
            //           height: 96,
            //           fit: BoxFit.cover,
            //           placeholder: AssetImage('assets/img_loading.gif'),
            //           image: NetworkImage('${widget.userBundle.thumbnail}'))),
            //   title: Text(
            //     '${widget.userBundle.title}',
            //     style: primaryTextStyle.copyWith(fontWeight: FontWeight.bold),
            //     maxLines: 2,
            //     overflow: TextOverflow.ellipsis,
            //   ),
            //   subtitle: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         courseLeft.toString() + ' Course Tersisa',
            //         style: secondaryTextStyle,
            //       ),
            //       SizedBox(height: 8),
            //       Row(
            //         children: [
            //           Expanded(
            //             child: LinearProgressIndicator(
            //               value: progressPercentage,
            //               backgroundColor: Color(
            //                   0xffF0DB96), // Background color of the progress bar
            //               valueColor:
            //                   AlwaysStoppedAnimation<Color>(progressBarColor),
            //             ),
            //           ),
            //           SizedBox(width: 8),
            //           Text(
            //               '${(progressPercentage * 100).toInt()}%', // Convert to integer to remove decimal places
            //               style: primaryTextStyle.copyWith(fontWeight: bold)),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: isExpanded, // Set the initial state

                onExpansionChanged: (value) {
                  setState(() {
                    isExpanded = value; // Update expanded state
                  });
                },
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Daftar Course',
                    style: primaryTextStyle.copyWith(fontWeight: bold),
                  ),
                ),
                children: [
                  Divider(
                    height: 20,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                    color: secondaryTextColor,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: widget.userBundle.courseBundling!
                          .map((userCourse) =>
                              CourseTile(userCourse, showProgress: false))
                          .toList(),
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                    color: secondaryTextColor,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isExpanded =
                            false; // Close the expansion when button is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailBundle(
                                    idBundle: '${widget.userBundle.bundlingId}',
                                    progressCourse: progressPercentage,
                                    persen: persen,
                                  )),
                        );
                      });
                      // Add your action here
                    },
                    child: Text(
                      'Lanjutkan',
                      style: thirdTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
