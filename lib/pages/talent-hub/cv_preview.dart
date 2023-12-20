import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/cv_model.dart';
import 'package:stufast_mobile/providers/user_course_provider.dart';
import 'package:stufast_mobile/theme.dart';

class CvPreview extends StatelessWidget {
  final CVmodel cv;
  CvPreview({required this.cv, super.key});

  @override
  Widget build(BuildContext context) {
    Widget cvPreview() {
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xffF2F4F6),
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tentang Saya',
                  style: primaryTextStyle.copyWith(fontWeight: bold)),
              Divider(
                color: Color(0xffFFA500),
                thickness: 1,
                endIndent: 200,
              ),
              ExpandableText(
                '${cv.about}',
                style: primaryTextStyle,
                maxLines: 5,
                expandText: 'show more',
                collapseText: 'show less',
                linkColor: primaryColor,
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 12),
              Text('Media Sosial',
                  style: primaryTextStyle.copyWith(fontWeight: bold)),
              Divider(
                color: Color(0xffFFA500),
                thickness: 1,
                endIndent: 200,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/ic_fb.png'),
                      SizedBox(width: 4),
                      Text('${cv.facebook}', style: primaryTextStyle)
                    ],
                  ),
                  SizedBox(width: 14),
                  Row(
                    children: [
                      Image.asset('assets/ic_ig.png'),
                      SizedBox(width: 4),
                      Text('${cv.instagram}', style: primaryTextStyle)
                    ],
                  ),
                  SizedBox(width: 14),
                  Row(
                    children: [
                      Image.asset('assets/ic_ln.png'),
                      SizedBox(width: 4),
                      Text('${cv.instagram}', style: primaryTextStyle)
                    ],
                  )
                ],
              ),
              SizedBox(height: 12),
              Text('CV', style: primaryTextStyle.copyWith(fontWeight: bold)),
              Divider(
                color: Color(0xffFFA500),
                thickness: 1,
                endIndent: 200,
              ),
              Container(
                width: 122,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () async {
                      await Provider.of<UserCourseProvider>(context,
                              listen: false)
                          .downloadSertif(isCv: true, idUser: cv.id)
                          .then((value) =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    'berhasil unduh sertifikar',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 8),
                        Text('Lihat CV',
                            style:
                                buttonTextStyle.copyWith(fontWeight: semiBold))
                      ],
                    )),
              )
            ],
          ));
    }

    Widget infoWork() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffF2F4F6),
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Siap Untuk Kerja',
                style: primaryTextStyle.copyWith(fontWeight: bold)),
            Divider(
              color: Color(0xffFFA500),
              thickness: 1,
              endIndent: 200,
            ),
            ListTile(
              leading: Image.asset('assets/ic_jenis_kerja.png'),
              title: Text('Jenis Pekerjaan',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              subtitle: Text('${cv.status}',
                  style: primaryTextStyle.copyWith(fontWeight: bold)),
            ),
            ListTile(
              leading: Image.asset('assets/ic_metod_kerja.png'),
              title: Text('Metode Pekerjaan',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              subtitle: Text('${cv.method}',
                  style: primaryTextStyle.copyWith(fontWeight: bold)),
            ),
            ListTile(
              leading: Image.asset('assets/ic_gaji_kerja.png'),
              title: Text('Range Gaji',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              subtitle: Text('${cv.range}',
                  style: primaryTextStyle.copyWith(fontWeight: bold)),
            ),
          ],
        ),
      );
    }

    return Column(children: [
      cvPreview(),
      SizedBox(height: 24),
      infoWork(),
      SizedBox(height: 24),
    ]);
  }
}
