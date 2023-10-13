import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/talent_hub_model.dart';

import '../theme.dart';

class AchievementTile extends StatelessWidget {
  Ach? achievement;
  AchievementTile(this.achievement);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffF2F4F6),
        child: Column(children: [
          ExpansionTile(
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
                          value: 80,
                          backgroundColor: Color(
                              0xffF0DB96), // Background color of the progress bar
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${achievement?.finalScore} / 100', // Convert to integer to remove decimal places
                        style: primaryTextStyle.copyWith(
                            fontWeight: bold, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF), // Warna latar belakang putih
                        border: Border.all(
                          color: Color(0xffD9D9D9F), // Warna garis tepi putih
                          width: 0.5, // Lebar garis tepi
                        ),
                      ),
                      child: Column(
                          children: achievement!.score!
                              .map((score) => Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${score.title}',
                                          style: primaryTextStyle.copyWith(
                                              fontWeight: semiBold,
                                              fontSize: 16),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: LinearProgressIndicator(
                                                value: 80,
                                                backgroundColor: Color(
                                                    0xffF0DB96), // Background color of the progress bar
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.yellow),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              '${score.score} / 100', // Convert to integer to remove decimal places
                                              style: primaryTextStyle.copyWith(
                                                  fontWeight: bold,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList()),
                    ))
              ]),
        ]));
  }
}
