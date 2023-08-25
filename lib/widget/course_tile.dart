import 'package:flutter/material.dart';
import 'package:stufast_mobile/theme.dart';

class CourseTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progressPercentage;

  CourseTile({
    required this.title,
    required this.subtitle,
    required this.progressPercentage,
  });

  @override
  Widget build(BuildContext context) {
    Color progressColor =
        progressPercentage < 100 ? Color(0xffFEC202) : Colors.green;

    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFAFAFA), // Warna background FAFAFA
          border: Border.all(color: Color(0xF3F3F3)), // Warna garis tepi F3F3F3
          borderRadius: BorderRadius.circular(8), // Sudut border radius
        ),
        child: ListTile(
          leading: Image.asset(
            'assets/image_tile_course.png',
            width: 95,
            height: 95,
          ),
          title: Text(
            title,
            style: primaryTextStyle.copyWith(fontWeight: bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style: secondaryTextStyle,
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progressPercentage / 100,
                      backgroundColor: Color(0xffF0DB96),
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${progressPercentage.toStringAsFixed(0)}%',
                    style: primaryTextStyle.copyWith(fontWeight: bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
