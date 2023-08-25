import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/category_chip.dart';

class CardCourse extends StatelessWidget {
  final CourseModel course;
  CardCourse(this.course);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 185,
          height: 275,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffF3F3F3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                '${course.thumbnail}',
                width: 185,
                height: 96,
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Text('${course.title}',
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
                      label: '${course.category?.name}',
                    ),
                    SizedBox(height: 4),
                    Text('${course.tag?.name}', style: secondaryTextStyle),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: NumberFormat.simpleCurrency(locale: 'id')
                                .format(int.parse('${course.oldPrice}'))
                                .replaceAll(',00', ''),
                            style: secondaryTextStyle.copyWith(
                              fontSize: 13,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
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
