import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/talent_hub_model.dart';

import '../theme.dart';

class AchievementTile extends StatelessWidget {
  Ach? achievement;
  AchievementTile(this.achievement);

  @override
  Widget build(BuildContext context) {
    double progressValue = double.parse(achievement?.finalScore) ?? 0 / 100;

    return Container(
        color: Color(0xffF2F4F6),
        child: Column(children: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                collapsedBackgroundColor: Colors.transparent,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${achievement?.courseTitle}',
                      style: primaryTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value:
                                progressValue, // Set the value based on the achievement score
                            backgroundColor: Color(
                                0xffF0DB96), // Background color of the progress bar
                            valueColor: AlwaysStoppedAnimation<Color>(
                              progressValue == 100.0
                                  ? primaryColor // Warna hijau jika progress 100%
                                  : Color(
                                      0xffFFCB42), // Warna kuning jika progress kurang dari 100%
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${achievement?.finalScore} / 100 ',
                          style: primaryTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color:
                              Color(0xFFFFFFFF), // Warna latar belakang putih
                          border: Border.all(
                            color: Color(0xffD9D9D9F), // Warna garis tepi putih
                            width: 0.5, // Lebar garis tepi
                          ),
                        ),
                        child: Column(
                            children: achievement!.score!
                                .map((score) => Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${score.title}',
                                            style: primaryTextStyle.copyWith(
                                                fontSize: 14),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: LinearProgressIndicator(
                                                  value: double.parse(
                                                          score.score) /
                                                      100,
                                                  backgroundColor: Color(
                                                      0xffF0DB96), // Background color of the progress bar
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>((double.parse(
                                                                      score
                                                                          .score) /
                                                                  100) ==
                                                              1.0
                                                          ? primaryColor
                                                          : Color(0xffFFCB42)),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                '${score.score} / 100', // Convert to integer to remove decimal places
                                                style:
                                                    primaryTextStyle.copyWith(
                                                        fontWeight: bold,
                                                        fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList()),
                      )),
                  Divider(
                    height: 20,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                    color: secondaryTextColor,
                  ),
                ]),
          ),
        ]));
  }
}
