import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/hire_model.dart';
import 'package:stufast_mobile/providers/hire_provider.dart';
import 'package:stufast_mobile/theme.dart';

class HireDetailPage extends StatefulWidget {
  HireModel? detail;
  HireDetailPage(this.detail, {super.key});

  @override
  State<HireDetailPage> createState() => _HireDetailPageState();
}

class _HireDetailPageState extends State<HireDetailPage> {
  String? confrim;
  bool loading = false;
  bool? acceptHire;

  confirmAccept() async {
    setState(() {
      loading = true;
    });
    if (await context
            .read<HireProvider>()
            .confirmHire('${widget.detail?.hireId}', '$confrim') &&
        confrim == 'accept') {
      setState(() {
        loading = false;

        widget.detail?.result = 'accept';
      });
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Selamat Anda telah menerima Tawaran',
          desc: 'Silahkan menunggu konfirmasi dari perusahaan',
          btnOkOnPress: () {},
        ).show();
      });
      context.read<HireProvider>().sendNitifconfirmHire();
    }
  }

  confirmReject() async {
    setState(() {
      loading = true;
    });
    if (await context
            .read<HireProvider>()
            .confirmHire('${widget.detail?.hireId}', '$confrim') &&
        confrim == 'deny') {
      setState(() {
        loading = false;

        widget.detail?.result = 'deny';
      });
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Anda Menolak Tawaran ini',
          desc: 'Silahkan mencari tawaran yang lain',
          btnOkOnPress: () {},
        ).show();
      });
      context.read<HireProvider>().sendNitifconfirmHire();
    }
  }

  handleConfirmHire(bool accept) async {
    showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text(accept == true ? 'Terima Tawaran' : 'Tolak Tawaran',
            style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18)),
        content: Text(
          accept == true
              ? 'Apakah anda yakin menerima tawaran ini ?'
              : 'Apakah anda yakin menolak tawaran ini ?',
          style: primaryTextStyle.copyWith(fontSize: 15),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              accept == true ? confirmAccept() : confirmReject();
              Navigator.of(context).pop(false);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget succsessView() {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/img_hired.png', width: 150, height: 150),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Selamat anda Terpilih !',
                      style: primaryTextStyle.copyWith(
                          fontWeight: bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
              Text(
                'Kami menyampaikan tawaran ini dengan harapan bahwa Anda akan mempertimbangkan untuk bergabung sebagai posisi Drafter di PT SM Entertaiment',
                textAlign: TextAlign.justify,
                style: primaryTextStyle.copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
      );
    }

    Widget confirmView(bool accept) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  accept
                      ? Image.asset('assets/img_hire_acc.png')
                      : Image.asset('assets/img_hire_reject.png'),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      accept ? 'Anda Menerima Tawaran' : 'Anda Menolak Tawaran',
                      style: primaryTextStyle.copyWith(
                          fontWeight: bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
              Text(
                accept
                    ? 'Terima Kasih atas responya, Silahkan menunggu konfirmasi dari perusahaan'
                    : 'Terima Kasih atas responya, Silahkan Terima Lowongan Yang lain',
                textAlign: TextAlign.justify,
                style: primaryTextStyle.copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
      );
    }

    Widget infoWork() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffF2F4F6),
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detail Tawaran',
                style:
                    primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18)),
            Divider(
              color: Color(0xffFFA500),
              thickness: 1,
              endIndent: 200,
            ),
            ListTile(
              leading: Image.asset('assets/ic_jenis_kerja.png'),
              title: Text('Jenis Pekerjaan',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              subtitle: Text('${widget.detail?.status}',
                  style: primaryTextStyle.copyWith(fontWeight: bold)),
            ),
            ListTile(
              leading: Image.asset('assets/ic_metod_kerja.png'),
              title: Text('Metode Pekerjaan',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              subtitle: Text('${widget.detail?.method}',
                  style: primaryTextStyle.copyWith(fontWeight: bold)),
            ),
            ListTile(
              leading: Image.asset('assets/ic_range_kerja.png'),
              title: Text('Durasi Pekerjaan',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              subtitle: Text('${widget.detail?.period}',
                  style: primaryTextStyle.copyWith(
                      fontWeight: bold, fontSize: 14)),
            ),
            ListTile(
              leading: Image.asset('assets/ic_gaji_kerja.png'),
              title: Text('Range Gaji',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              subtitle: Text('${widget.detail?.range}',
                  style: primaryTextStyle.copyWith(fontWeight: bold)),
            ),
            SizedBox(height: 12),
            Text('Keterangan',
                style:
                    primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18)),
            Divider(
              color: Color(0xffFFA500),
              thickness: 1,
              endIndent: 200,
            ),
            ExpandableText(
              '${widget.detail?.information}',
              style: primaryTextStyle.copyWith(fontSize: 15),
              maxLines: 5,
              expandText: 'show more',
              collapseText: 'show less',
              linkColor: primaryColor,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );
    }

    Widget actionButton() {
      return widget.detail?.result == 'pending'
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          confrim = 'accept';
                        });
                        handleConfirmHire(true);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Terima',
                        style: buttonTextStyle.copyWith(
                            fontWeight: bold, fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          confrim = 'deny';
                        });
                        handleConfirmHire(false);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Tolak',
                        style: buttonTextStyle.copyWith(
                            fontWeight: bold, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox();
    }

    Widget companyInfo() {
      return Row(
        children: [
          Image.network(
            '${widget.detail?.profilePicture}',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20),
          Container(
            alignment: Alignment.topLeft,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.detail?.position}',
                  style:
                      primaryTextStyle.copyWith(fontWeight: bold, fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  '${widget.detail?.status}',
                  style: secondaryTextStyle.copyWith(fontSize: 15),
                ),
                SizedBox(height: 5),
                Text(
                  '${widget.detail?.fullname}',
                  style: primaryTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Hire',
          style: primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
        ),
        elevation: 0, // Menghilangkan shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, '/hire-page');
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
          padding: EdgeInsets.all(24),
          child: ListView(
            children: [
              widget.detail?.result == 'deny'
                  ? confirmView(false)
                  : widget.detail?.result == 'accept'
                      ? confirmView(true)
                      : SizedBox(),
              widget.detail?.result == 'pending' ? succsessView() : SizedBox(),
              SizedBox(height: 16),
              companyInfo(),
              SizedBox(height: 20),
              infoWork(),
              SizedBox(height: 20),
              loading == false
                  ? actionButton()
                  : Center(child: CircularProgressIndicator()),
              SizedBox(height: 16),
            ],
          )),
    );
  }
}
