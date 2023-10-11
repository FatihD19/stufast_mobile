import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/talent_hub_model.dart';
import 'package:stufast_mobile/pages/talent-hub/detail_talentHub.dart';

import '../theme.dart';

class TalentCard extends StatelessWidget {
  final TalentHubModel talent;
  TalentCard(this.talent);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffF3F3F3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      "https://dev.stufast.id/public/upload/users/${talent.profilePicture}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: 40,
              child: Text(
                '${talent.fullname}',
                style: primaryTextStyle.copyWith(fontWeight: bold),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    Text(
                      'Total\n Sertifikat',
                      style: secondaryTextStyle.copyWith(fontWeight: bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${talent.totalCourse}',
                      style: primaryTextStyle.copyWith(fontWeight: bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Total\n Score',
                      style: secondaryTextStyle.copyWith(fontWeight: bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${talent.averageScore}',
                      style: primaryTextStyle.copyWith(fontWeight: bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 11),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailTalentHubPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_red_eye, size: 12),
                  SizedBox(width: 3),
                  Text(
                    'Lihat Profil',
                    style: buttonTextStyle.copyWith(
                        fontWeight: bold, fontSize: 12),
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
