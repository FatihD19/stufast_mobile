import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:stufast_mobile/theme.dart';

class CvPreview extends StatelessWidget {
  const CvPreview({super.key});

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
                'Saya adalah seorang arsitek berbakat dengan pengalaman lebih dari 3 tahun dalam industri arsitektur. Dengan latar belakang pendidikan di Universitas Harvard, saya telah terlibat dalam berbagai proyek yang berkisar dari residensial hingga Read more',
                style: primaryTextStyle,
                maxLines: 5,
                expandText: 'show more',
                collapseText: 'show less',
                linkColor: primaryColor,
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 12),
              // Text('Media Sosial',
              //     style: primaryTextStyle.copyWith(fontWeight: bold)),
              // Divider(
              //   color: Color(0xffFFA500),
              //   thickness: 1,
              //   endIndent: 200,
              // ),
              // SizedBox(height: 12),
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
                    onPressed: () {},
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
              subtitle: Text('Full Time',
                  style: primaryTextStyle.copyWith(fontWeight: bold)),
            ),
            ListTile(
              leading: Image.asset('assets/ic_metod_kerja.png'),
              title: Text('Metode Pekerjaan',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              subtitle: Text('Remote',
                  style: primaryTextStyle.copyWith(fontWeight: bold)),
            ),
            ListTile(
              leading: Image.asset('assets/ic_gaji_kerja.png'),
              title: Text('Range Gaji',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              subtitle: Text('Rp. 5.000.000 - Rp. 10.000.000',
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
