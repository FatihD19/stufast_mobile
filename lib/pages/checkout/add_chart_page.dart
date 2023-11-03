import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/chart_model.dart';
import 'package:stufast_mobile/pages/checkout/checkout_page.dart';
import 'package:stufast_mobile/providers/chart_provider.dart';
import 'package:stufast_mobile/providers/checkout_provider.dart';
import 'package:stufast_mobile/providers/user_course_provider.dart';
import 'package:stufast_mobile/widget/chart_tile.dart';
import 'package:stufast_mobile/widget/price_text_widget.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

import '../../theme.dart';

class AddToChartPage extends StatefulWidget {
  const AddToChartPage({super.key});

  @override
  State<AddToChartPage> createState() => _AddToChartPageState();
}

class _AddToChartPageState extends State<AddToChartPage> {
  bool loading = true;
  List selectedIds = [];
  int totalPrice = 0;
  bool selectAll = false;
  void initState() {
    // TODO: implement initState
    getInit();
    super.initState();
  }

  getInit() async {
    setState(() {
      loading = true;
    });
    await Provider.of<ChartProvider>(context, listen: false).getChart();
    // await Provider.of<CheckoutProvider>(context, listen: false)
    //     .checkoutCourse(selectedIds);

    setState(() {
      loading = false;
    });
  }

  int? calculatePriceCart() {
    return context.watch<CheckoutProvider>().checkout!.subTotal;
  }

  Color getColorForItemType(String itemType) {
    switch (itemType) {
      case 'course':
        return Color(0xffA9CAFD);
      case 'bundling':
        return Color(0xFFF5C64C);
      case 'webinar':
        return Color(0xFFF2ACF3);
      default:
        return Colors
            .transparent; // Warna default jika tidak sesuai dengan nilai yang diharapkan.
    }
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    ChartProvider chartProvider = Provider.of<ChartProvider>(context);

    // Widget chartTile() {
    //   return Column(
    //       children: chartProvider.chart!.item!
    //           .map((item) => ChartItemTile(item))
    //           .toList());
    // }
    Widget chartTile() {
      return Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 96),
        height: MediaQuery.of(context).size.height - 190,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: chartProvider.chart?.item?.length,
          itemBuilder: (context, index) {
            ItemChartModel item = chartProvider.chart!.item![index];

            return Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffF3F3F3),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: selectedIds.contains(item.cartId),
                      onChanged: (bool? isChecked) {
                        setState(() {
                          if (isChecked != null && isChecked) {
                            selectedIds.add(item.cartId);
                            totalPrice += int.parse('${item.newPrice}');
                          } else {
                            selectedIds.remove(item.cartId);
                            totalPrice -= int.parse('${item.newPrice}');
                          }
                          // Periksa apakah semua item dipilih atau tidak
                          selectAll = chartProvider.chart!.item!.every(
                              (item) => selectedIds.contains(item.cartId));
                          if (selectAll) {
                            totalPrice = chartProvider.chart!.item!.fold<int>(
                                0,
                                (total, item) =>
                                    total + int.parse('${item.newPrice}'));
                          }
                          //else {
                          //   totalPrice = 0;
                          // }
                        });
                      },
                    ),
                    Image.network(
                      '${item.thumbnail}',
                      fit: BoxFit.cover,
                      width: 63,
                      height: 61,
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.title}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: primaryTextStyle.copyWith(fontWeight: bold),
                          ),
                          Text(
                              item.type == 'webinar'
                                  ? '${item.webinarTag}'
                                  : item.type == 'bundling'
                                      ? '${item.totalItem} course'
                                      : '${item.totalItem} video',
                              style: secondaryTextStyle),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: getColorForItemType('${item.type}'),
                            ),
                            child: Text(
                              '${item.type}',
                              style: buttonTextStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          NewPrice(item.newPrice),
                          OldPrice(item.oldPrice),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 90),
                      child: IconButton(
                        onPressed: () async {
                          if (await context
                              .read<ChartProvider>()
                              .deleteToChart('${item.cartId}')) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'berhasil hapus',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            Navigator.pushNamed(context, '/chart-page');
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
                        },
                        icon: Icon(Icons.cancel_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            );
            // ListTile(
            //   title: Text('${item.title}'),
            //   leading: Checkbox(
            //     value: selectedIds.contains(item.cartId),
            //     onChanged: (bool? isChecked) {
            //       setState(() {
            //         if (isChecked != null && isChecked) {
            //           selectedIds.add(item.cartId);
            //         } else {
            //           selectedIds.remove(item.cartId);
            //         }
            //       });
            //     },
            //   ),
            // );
          },
        ),
      );
    }

    Widget checkOut() {
      return Container(
        color: Color(0xffFAFAFA),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select All',
                    style: secondaryTextStyle.copyWith(fontWeight: bold)),
                Checkbox(
                  value: selectAll,
                  onChanged: (bool? isChecked) {
                    setState(() {
                      selectAll = isChecked ?? false;
                      if (selectAll) {
                        // Jika "Select All" dicheck, tandai semua item dan hitung total harga
                        selectedIds.clear();
                        // Set total harga ke nol
                        totalPrice = 0;
                        // Pilih semua item cart
                        selectedIds.addAll(chartProvider.chart!.item!
                            .map((item) => item.cartId));
                        // Totalkan harga semua item yang dipilih
                        totalPrice = chartProvider.chart!.item!.fold<int>(
                            0,
                            (total, item) =>
                                total + int.parse('${item.newPrice}'));
                        // for (ItemChartModel item
                        //     in chartProvider.chart!.item!) {
                        //   totalPrice += int.parse('${item.newPrice}');
                        // }
                      } else {
                        selectedIds.clear();
                        for (ItemChartModel item
                            in chartProvider.chart!.item!) {
                          totalPrice -= int.parse('${item.newPrice}');
                        }
                        // Jika "Select All" di-uncheck, batalkan pemilihan semua item
                        totalPrice = 0; // Setel total harga ke 0
                      }
                    });
                  },
                ),
              ],
            ),
            Divider(
              color: Colors.grey, // Warna garis putus-putus
              thickness: 1, // Ketebalan garis putus-putus
              height: 20, // Tinggi garis putus-putus
              indent: 2, // Jarak dari kiri
              endIndent: 2, // Jarak dari kanan
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total (len) item',
                    style: secondaryTextStyle.copyWith(fontWeight: bold)),
                // NewPrice('${chartProvider.chart?.subTotal}')
                NewPrice('${totalPrice}')
              ],
            ),
            SizedBox(height: 24),
            Container(
                width: double.infinity,
                height: 54,
                child: PrimaryButton(
                    text: 'Checkout',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckOutPage(
                                  selectedIds,
                                  type: 'cart',
                                )),
                      );
                    })),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Chart',
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
          ),
          elevation: 0, // Menghilangkan shadow
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          backgroundColor: Colors.white,
          centerTitle: false,
        ),
        body: loading == true
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  ListView(
                    children: [
                      Row(children: selectedIds.map((e) => Text(e)).toList()),
                      chartTile(), // Widget chartTile
                    ],
                  ),
                  Positioned(
                    bottom: 0, // Menempatkan checkout di bagian bawah
                    left: 0, // Atur posisi horizontal ke kiri
                    right: 0, // Atur posisi horizontal ke kanan
                    child: checkOut(),
                  ),
                ],
              ),
        // bottomNavigationBar: loading ? SizedBox() : checkOut(),
      ),
    );
  }
}
