import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/api/api_url.dart';
import 'package:stufast_mobile/models/talent_hub_model.dart';
import 'package:stufast_mobile/pages/talent-hub/cv_preview.dart';
import 'package:stufast_mobile/providers/talentHub_provider.dart';
import 'package:stufast_mobile/widget/achievment_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme.dart';

class DetailTalentHubPage extends StatefulWidget {
  String? id;
  DetailTalentHubPage(this.id);

  @override
  State<DetailTalentHubPage> createState() => _DetailTalentHubPageState();
}

class _DetailTalentHubPageState extends State<DetailTalentHubPage> {
  bool? loading;
  // final Uri _url = Uri.parse('https://flutter.dev');
  @override
  void initState() {
    // TODO: implement initState
    getInit();
    super.initState();
  }

  getInit() async {
    setState(() {
      loading = true;
    });
    await Provider.of<TalentHubProvider>(context, listen: false)
        .getDetailTalentHub("${widget.id}");
    setState(() {
      loading = false;
    });
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch ');
    }
  }

  @override
  Widget build(BuildContext context) {
    TalentHubProvider talentHubProvider =
        Provider.of<TalentHubProvider>(context);
    DetailTalentHubModel? detailTalent = talentHubProvider.detailTalent;
    Widget actionButton(VoidCallback onPressed, String img, String title,
        {bool? nullPortofolio}) {
      return Container(
        width: 136,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: title == 'Hire'
                    ? Colors.green
                    : title == 'CV'
                        ? Colors.red
                        : title == 'Portofolio'
                            ? Color(0xffFFCB42)
                            : Colors.blue),
            onPressed: nullPortofolio == true ? null : onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('$img'),
                SizedBox(width: 4),
                Text('$title',
                    style: buttonTextStyle.copyWith(
                        fontSize: 16, fontWeight: bold))
              ],
            )),
      );
    }

    Widget headProfile() {
      return Container(
        width: 378,
        height: 310,
        color: Color(0xffF2F4F6),
        child: Column(
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Image.asset('assets/bg_detail_talent.png'),
                ),
                Positioned(
                  top: 6, // Sesuaikan dengan posisi vertikal yang Anda inginkan
                  left: (MediaQuery.of(context).size.width) / 3.1,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "${ApiUrl.url}/upload/users/${detailTalent?.user?.profilePicture}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              '${detailTalent?.user?.fullname}',
              style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '${detailTalent?.user?.address}',
                style: secondaryTextStyle.copyWith(
                    fontSize: 12, fontWeight: semiBold),
              ),
            ),
            SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 120,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: primaryColor)),
                  child: Row(
                    children: [
                      Image.asset('assets/ic_sum_sertif.png'),
                      SizedBox(width: 4),
                      Text('${detailTalent?.totalCourse} Sertifikat',
                          style: thirdTextStyle.copyWith(
                              fontSize: 14, fontWeight: semiBold))
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: primaryColor)),
                  child: Row(
                    children: [
                      Image.asset('assets/ic_sum_skor.png'),
                      SizedBox(width: 4),
                      Text('${detailTalent?.totalCourse} Skor',
                          style: thirdTextStyle.copyWith(
                              fontSize: 14, fontWeight: semiBold))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     actionButton(() {
            //       _launchUrl();
            //     }, 'assets/ic_hire.png', 'Hire'),
            //     actionButton(() {}, 'assets/ic_lin.png', 'Linkedin'),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                actionButton(() {
                  _launchUrl(
                      '${ApiUrl.url}/talent/detail/${detailTalent?.user?.id}');
                }, 'assets/ic_hire.png', 'Hire'),
                actionButton(() {
                  _launchUrl(detailTalent?.user?.portofolio ?? '');
                }, 'assets/ic_portofolio.png', 'Portofolio',
                    nullPortofolio:
                        detailTalent?.user?.portofolio == '-' ? true : false),
              ],
            )
          ],
        ),
      );
    }

    Widget pencapaian() {
      return Container(
        color: Color(0xffF2F4F6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pencapaian',
                        style: primaryTextStyle.copyWith(
                            fontSize: 18, fontWeight: bold)),
                    Divider(
                      color: Color(0xffFFA500),
                      thickness: 1,
                      endIndent: 220,
                    ),
                  ]),
            ),
            Column(
              children: talentHubProvider.detailTalent!.ach!
                  .map((ach) => AchievementTile(ach))
                  .toList(),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Talent Hub',
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
        elevation: 0, // Menghilangkan shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: loading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                shrinkWrap: true,
                children: [
                  headProfile(),
                  SizedBox(height: 17),
                  CvPreview(cv: detailTalent!.user!),
                  pencapaian(),
                  SizedBox(height: 24),
                ],
              ),
      ),
    );
  }
}
