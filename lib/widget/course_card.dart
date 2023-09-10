import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_course_page.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/category_chip.dart';

class CardCourse extends StatelessWidget {
  final CourseModel course;
  CardCourse(this.course);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailCoursePage(
                    idUserCourse: '${course.courseId}',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage(
                placeholder:
                    AssetImage('assets/image_course.png'), // Gambar placeholder
                image: NetworkImage('${course.thumbnail}'),
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
                    Text('${course.title}',
                        overflow: TextOverflow.ellipsis,
                        style: primaryTextStyle.copyWith(fontWeight: bold)),
                    SizedBox(height: 4),
                    // Chip(
                    //   backgroundColor: Colors.white,
                    //   shape: RoundedRectangleBorder(
                    //     side: BorderSide(color: Colors.blue),
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   label: Text('Basic'),
                    // ),
                    CustomChip(
                      label: '${course.category}',
                    ),
                    SizedBox(height: 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: course.tag!
                          .map((tag) => Text(
                                '- ${tag.name}',
                                style:
                                    secondaryTextStyle.copyWith(fontSize: 12),
                              ))
                          .toList(),
                      // children: [
                      //   Text('${course.tag}', style: secondaryTextStyle),
                      // ],
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: NumberFormat.simpleCurrency(locale: 'id')
                                .format(int.parse('${course.oldPrice}'))
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
                              .format(int.parse('${course.newPrice}'))
                              .replaceAll(',00', ''),
                          style: thirdTextStyle.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
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
