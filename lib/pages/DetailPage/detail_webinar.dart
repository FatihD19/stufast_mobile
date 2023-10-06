import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/webinar_model.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/price_text_widget.dart';

import '../../providers/chart_provider.dart';
import '../../widget/description_widget.dart';
import '../../widget/primary_button.dart';

class DetailWebinarPage extends StatefulWidget {
  final WebinarModel detailWebinar;
  DetailWebinarPage(this.detailWebinar);

  @override
  State<DetailWebinarPage> createState() => _DetailWebinarPageState();
}

class _DetailWebinarPageState extends State<DetailWebinarPage> {
  bool isExpanded = false;
  handleAddChart() async {
    if (await context
        .read<ChartProvider>()
        .addToChart('webinar', "${widget.detailWebinar.webinarId}")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'berhasil tambah ke chart',
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Gagal!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageCourse() {
      return Image.network(
        '${widget.detailWebinar.thumbnail}',
        width: double.infinity,
        height: 233,
      );
    }

    Widget keterangan() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/ic_date.png'),
                SizedBox(width: 4),
                Text('${widget.detailWebinar.date}',
                    style: secondaryTextStyle.copyWith(fontSize: 13)),
                SizedBox(width: 8),
                Text('${widget.detailWebinar.time}',
                    style: secondaryTextStyle.copyWith(fontSize: 13))
              ],
            ),
            // ExpandableText(text: '${detailWebinar.description}'),

            ExpandableText(
              '${widget.detailWebinar.description}',
              style: secondaryTextStyle,
              maxLines: 7,
              expandText: 'show more',
              collapseText: 'show less',
              linkColor: primaryColor,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );
    }

    Widget joinWebinar() {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gabung Webinar : ',
                      style: primaryTextStyle.copyWith(fontWeight: bold)),
                  Text('link zoom',
                      style: thirdTextStyle.copyWith(fontWeight: bold))
                ],
              ),
            ),
          ));
    }

    Widget pricing() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Card(
                clipBehavior: Clip.antiAlias,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.detailWebinar.title}',
                        style: secondaryTextStyle.copyWith(fontWeight: bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('  • Online Webiner', style: secondaryTextStyle),
                          NewPrice('${widget.detailWebinar.newPrice}')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('  • Recording', style: secondaryTextStyle),
                          Text('  FREE', style: secondaryTextStyle),
                        ],
                      )
                    ],
                  ),
                )),
            SizedBox(height: 16),
            Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 54,
                    child:
                        PrimaryButton(text: 'Beli Sekarang', onPressed: () {})),
                SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: handleAddChart,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Latar belakang putih
                      onPrimary: Color(
                          0xFF248043), // Warna teks saat di atas latar putih
                      side: BorderSide(
                          color: Color(0xFF248043),
                          width: 2), // Border berwarna 248043 dengan lebar 2
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Border radius 10
                      ),
                    ),
                    child: Text(
                      'Masukan ke Keranjang',
                      style: thirdTextStyle.copyWith(fontWeight: bold),
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.detailWebinar.title}',
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
      body: SafeArea(
          child: ListView(
        children: [
          imageCourse(),
          keterangan(),
          SizedBox(height: 16),
          widget.detailWebinar.owned == true ? joinWebinar() : SizedBox(),
          widget.detailWebinar.owned == true ? SizedBox() : pricing()
        ],
      )),
    );
  }
}
