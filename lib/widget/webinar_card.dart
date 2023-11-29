// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/webinar_model.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_webinar.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/price_text_widget.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

class WebinarCard extends StatelessWidget {
  final WebinarModel webinar;
  bool? isUser;
  WebinarCard(this.webinar, this.isUser);
  @override
  Widget build(BuildContext context) {
    return isUser == true
        ? InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailWebinarPage(webinar)),
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
                  height: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF3F3F3),
                  ),
                  child: Column(
                    children: [
                      FadeInImage(
                        placeholder: AssetImage(
                            'assets/image_course.png'), // Gambar placeholder
                        image: NetworkImage('${webinar.thumbnail}'),
                        width: double.infinity,
                        height: 207,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text('${webinar.title}',
                                overflow: TextOverflow.ellipsis,
                                style: primaryTextStyle.copyWith(
                                    fontWeight: bold, fontSize: 16)),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Image.asset('assets/ic_date.png'),
                                SizedBox(width: 4),
                                Text('${webinar.date}',
                                    style: secondaryTextStyle.copyWith(
                                        fontSize: 13)),
                                SizedBox(width: 8),
                                Text('${webinar.time}',
                                    style: secondaryTextStyle.copyWith(
                                        fontSize: 13))
                              ],
                            ),
                            SizedBox(height: 16),
                            Container(
                                width: double.infinity,
                                height: 54,
                                child: PrimaryButton(
                                    text: 'Gabung Webinar', onPressed: () {})),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          )
        : Container(
            margin: EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailWebinarPage(webinar)),
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
                    height: 205,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF3F3F3),
                    ),
                    child: Column(
                      children: [
                        FadeInImage(
                          placeholder: AssetImage(
                              'assets/image_course.png'), // Gambar placeholder
                          image: NetworkImage('${webinar.thumbnail}'),
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
                              Text('${webinar.title}',
                                  overflow: TextOverflow.ellipsis,
                                  style: primaryTextStyle.copyWith(
                                      fontWeight: bold, fontSize: 16)),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Image.asset('assets/ic_date.png'),
                                  SizedBox(width: 4),
                                  Text('${webinar.date}',
                                      style: secondaryTextStyle.copyWith(
                                          fontSize: 13))
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  OldPrice('${webinar.oldPrice}'),
                                  NewPrice('${webinar.newPrice}')
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          );
  }
}
