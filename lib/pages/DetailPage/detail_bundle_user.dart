import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/bundling_model.dart';
import 'package:stufast_mobile/pages/checkout/checkout_page.dart';
import 'package:stufast_mobile/providers/bundle_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/course_tile.dart';
import 'package:stufast_mobile/widget/description_widget.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

import '../../providers/auth_provider.dart';
import '../../providers/chart_provider.dart';
import '../../providers/user_course_provider.dart';

class DetailBundle extends StatefulWidget {
  String idBundle;
  dynamic progressCourse;
  String? totalDuration;
  int? persen;

  DetailBundle(
      {required this.idBundle,
      this.progressCourse,
      this.persen,
      this.totalDuration});

  @override
  State<DetailBundle> createState() => _DetailBundleState();
}

class _DetailBundleState extends State<DetailBundle> {
  List selectedIds = [];
  bool? loading;
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    setState(() {
      loading = true;
    });
    await Provider.of<BundleProvider>(context, listen: false)
        .getDetailBundle(widget.idBundle);

    setState(() {
      loading = false;
    });
  }

  handleAddChart() async {
    if (await context
        .read<ChartProvider>()
        .addToChart('bundling', widget.idBundle)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'berhasil tambah ke cart',
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
    BundleProvider detailBundleProvider = Provider.of<BundleProvider>(context);
    BundlingModel? detail = detailBundleProvider.detailBundling;
    // Menghitung total harga
    // double totalHarga =
    //     detail!.courseBundling!.fold(0.0, (previous, courseBundling) {
    //   // Mengakumulasikan harga setiap courseBundling ke total sebelumnya
    //   return previous +
    //       double.parse('${courseBundling.oldPrice}') -
    //       double.parse('${courseBundling.newPrice}');
    // });
    double flashSaleBundle = (double.tryParse('${detail?.oldPrice}') ?? 0.0) -
        (double.tryParse('${detail?.newPrice}') ?? 0.0);

// Format total harga ke dalam mata uang Indonesia
    // String formattedTotalHarga = NumberFormat.simpleCurrency(locale: 'id')
    //     .format(totalHarga)
    //     .replaceAll(',00', '');
    String flashSale = NumberFormat.simpleCurrency(locale: 'id')
        .format(flashSaleBundle)
        .replaceAll(',00', '');

    Widget imageCourse() {
      return Image.network(
        '${detail?.thumbnail}',
        width: double.infinity,
        height: 233,
      );
    }

    Widget progressBar(double progress) {
      return detail?.owned == true
          ? Container(
              margin: EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                      width: 34,
                      height: 34,
                      child: CircularProgressIndicator(
                        value: widget.progressCourse,
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.progressCourse == 1.0
                              ? primaryColor
                              : Color(0xFFfec202),
                        ),
                        backgroundColor: Colors.grey[300],
                      )),
                  Center(
                    child: Text('${widget.persen}',
                        style: primaryTextStyle.copyWith(fontWeight: bold)),
                  ),
                ],
              ),
            )
          : SizedBox();
    }

    Widget pricing() {
      return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffF3F3F3),
          ),
          padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('${detail?.title}',
                    style: secondaryTextStyle.copyWith(fontWeight: bold)),
              ),
              Column(
                children: detail!.courseBundling!
                    .map(
                      (courseBundling) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '• ${courseBundling.title!.length > 20 ? courseBundling.title!.substring(0, 20) + '...' : courseBundling.title}',
                            style: secondaryTextStyle,
                          ),
                          Text(
                            NumberFormat.simpleCurrency(locale: 'id')
                                .format(int.parse('${courseBundling.newPrice}'))
                                .replaceAll(',00', ''),
                            style: thirdTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('  • Flash Sale', style: secondaryTextStyle),
                  Text(flashSale, style: secondaryTextStyle),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style: primaryTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16)),
                  Text(
                      NumberFormat.simpleCurrency(locale: 'id')
                          .format(int.parse('${detail.newPrice}'))
                          .replaceAll(',00', ''),
                      style: primaryTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16)),
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${detail?.title}',
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 17),
                  ),
                ),
                detail?.owned == true
                    ? SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: NumberFormat.simpleCurrency(locale: 'id')
                                  .format(int.parse('${detail?.oldPrice}'))
                                  .replaceAll(',00', ''),
                              style: secondaryTextStyle.copyWith(
                                fontSize: 15,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          SizedBox(width: 3),
                          Text(
                            NumberFormat.simpleCurrency(locale: 'id')
                                .format(int.parse('${detail?.newPrice}'))
                                .replaceAll(',00', ''),
                            style: thirdTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
              ],
            ),
            Row(
              children: [
                Image.asset('assets/icon_tag.png'),
                SizedBox(width: 8),
                Text(
                  '${detail?.category_name}',
                  style: secondaryTextStyle,
                ),
              ],
            ),
            SizedBox(height: 18),
            Text(
              'Deskripsi',
              style: primaryTextStyle.copyWith(fontWeight: bold),
            ),
            ExpandableText(
              '${detail?.description}',
              style: secondaryTextStyle,
              maxLines: 7,
              expandText: 'show more',
              collapseText: 'show less',
              linkColor: primaryColor,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8),
            Text('Course List',
                style: primaryTextStyle.copyWith(fontWeight: bold)),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: detail!.courseBundling!
                    .map((course) => CourseTile(course,
                        showProgress: detail.owned == true ? true : false))
                    .toList()),
            SizedBox(height: 24),
            detail.owned == false ? pricing() : SizedBox(),
            SizedBox(height: 14),
            detail.owned == true
                ? SizedBox()
                : context.read<AuthProvider>().user?.fullname == null
                    ? Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      primaryColor, // Warna teks saat di atas latar hijau
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Border radius 10
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/landing-page');
                                },
                                child: Text(
                                  'Login untuk membeli Bundling',
                                  style: buttonTextStyle.copyWith(
                                      fontSize: 14, fontWeight: bold),
                                )),
                          ),
                          SizedBox(height: 12)
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                              width: double.infinity,
                              height: 54,
                              child: PrimaryButton(
                                  text: 'Beli Sekarang',
                                  onPressed: () {
                                    selectedIds.add(detail.bundlingId);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CheckOutPage(
                                                selectedIds,
                                                type: 'bundling',
                                              )),
                                    );
                                  })),
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
                                    width:
                                        2), // Border berwarna 248043 dengan lebar 2
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Border radius 10
                                ),
                              ),
                              child: Text(
                                'Masukan ke Keranjang',
                                style:
                                    thirdTextStyle.copyWith(fontWeight: bold),
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
          'Detail Bundle',
          style: primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
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
        actions: [loading == false ? progressBar(0.62) : SizedBox()],
      ),
      body: SafeArea(
          child: Center(
        child: loading == false
            ? ListView(
                children: [imageCourse(), content()],
              )
            : CircularProgressIndicator(),
      )),
    );
  }
}
