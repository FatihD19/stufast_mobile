import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/talent_hub_model.dart';
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
  final Uri _url = Uri.parse('https://flutter.dev');
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

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    TalentHubProvider talentHubProvider =
        Provider.of<TalentHubProvider>(context);
    DetailTalentHubModel? detailTalent = talentHubProvider.detailTalent;
    Widget actionButton(VoidCallback onPressed, String img, String title) {
      return Container(
        width: 136,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: title == 'Hire'
                    ? Colors.green
                    : title == 'CV'
                        ? Colors.red
                        : title == 'Portofolio'
                            ? Colors.yellow
                            : Colors.blue),
            onPressed: onPressed,
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
        height: 311,
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
                  top: 4, // Sesuaikan dengan posisi vertikal yang Anda inginkan
                  left: (MediaQuery.of(context).size.width) / 3.1,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://stufast.id/public/dev2/public/public/upload/users/${detailTalent?.user?.profilePicture}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '${detailTalent?.user?.fullname}',
              style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: bold),
            ),
            Text(
              '${detailTalent?.user?.address}',
              style: secondaryTextStyle.copyWith(
                  fontSize: 12, fontWeight: semiBold),
            ),
            SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    Text(
                      'Total Sertifikat',
                      style: secondaryTextStyle.copyWith(fontWeight: bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${detailTalent?.totalCourse}',
                      style: primaryTextStyle.copyWith(fontWeight: bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Total Score',
                      style: secondaryTextStyle.copyWith(fontWeight: bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${detailTalent?.averageScore}',
                      style: primaryTextStyle.copyWith(fontWeight: bold),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                actionButton(() {
                  _launchUrl();
                }, 'assets/ic_hire.png', 'Hire'),
                actionButton(() {}, 'assets/ic_lin.png', 'Linkedin'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                actionButton(() {}, 'assets/ic_cv.png', 'CV'),
                actionButton(() {}, 'assets/ic_portofolio.png', 'Portofolio'),
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
          children: [
            Text(
              'Pencapaian',
              style: primaryTextStyle.copyWith(fontSize: 18, fontWeight: bold),
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
                children: [headProfile(), SizedBox(height: 17), pencapaian()],
              ),
      ),
    );
  }
}
