import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/orderHistoryModel.dart';
import 'package:stufast_mobile/models/order_model.dart';
import 'package:stufast_mobile/pages/checkout/invoice_page.dart';
import 'package:stufast_mobile/pages/course_page.dart';
import 'package:stufast_mobile/pages/home/my_course_page.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/price_text_widget.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

import '../pages/checkout/payment_view.dart';

class OrderTile extends StatelessWidget {
  OrderHistoryModel? order;
  OrderTile(this.order);

  @override
  Widget build(BuildContext context) {
    String status = '${order?.transactionStatus}';
    Color getColorForItemType(String itemType) {
      switch (itemType) {
        case 'Course':
          return Color(0xffA9CAFD);
        case 'Bundling':
          return Color(0xFFF5C64C);
        case 'Webinar':
          return Color(0xFFF2ACF3);
        default:
          return Colors
              .transparent; // Warna default jika tidak sesuai dengan nilai yang diharapkan.
      }
    }

    Widget statusPay(String status) {
      return status == 'pending'
          ? Row(
              children: [
                Icon(Icons.replay_outlined, size: 18, color: Color(0xffE57917)),
                Text('Menunggu Pembayaran',
                    style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: semiBold,
                        color: Color(0xffE57917))),
              ],
            )
          : status == 'paid'
              ? Row(
                  children: [
                    Icon(Icons.check, size: 18, color: primaryColor),
                    Text('Pembayaran Berhasil',
                        style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: semiBold,
                            color: primaryColor)),
                  ],
                )
              : Row(
                  children: [
                    Icon(Icons.close, size: 18, color: Color(0xffD82222)),
                    Text('Pesanan dibatalkan',
                        style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: semiBold,
                            color: Color(0xffD82222))),
                  ],
                );
    }

    Widget listItem(bool preview) {
      return Column(
        children: order!.item!
            .take(preview == true ? 1 : order!.item!.length)
            .map(
              (item) => Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Image.network(
                        '${item.thumbnail}',
                        width: 97,
                        height: 78,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${item.title}',
                              style: primaryTextStyle.copyWith(
                                  fontWeight: semiBold, fontSize: 13)),
                          Container(
                            padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: getColorForItemType('${item.type}'),
                            ),
                            child: Text(
                              '${item.type}',
                              style: buttonTextStyle.copyWith(
                                  fontWeight: semiBold, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      );
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Text('Daftar Item',
                                      style: primaryTextStyle.copyWith(
                                          fontWeight: semiBold)),
                                  listItem(false),
                                ],
                              )),
                        );
                      });
                },
                child: listItem(true)),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text('${order?.transactionStatus}',
                //     style: thirdTextStyle.copyWith(
                //         fontWeight: semiBold, fontSize: 13)),
                Text('total : ${order?.item?.length} item',
                    style: secondaryTextStyle.copyWith(
                        fontSize: 13, fontWeight: semiBold)),
                NewPrice('${order?.grossAmount}')
              ],
            ),
            SizedBox(height: 5),
            statusPay('${order?.transactionStatus}'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                status == 'cancel'
                    ? SizedBox()
                    : Container(
                        width: 130,
                        height: 35,
                        child: PrimaryButton(
                            text: 'Lihat Invoice',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InvoicePage('${order?.orderId}')));
                            })),
                Container(
                  width: 130,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      if (status == 'pending') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaymentView(order?.snapToken)),
                        );
                      } else if (status == 'paid') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyCoursePage()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CoursePage()),
                        );
                      }
                    },
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
                      status == 'pending'
                          ? 'Bayar'
                          : status == 'paid'
                              ? 'Lihat Course'
                              : 'Beli lagi',
                      style: thirdTextStyle.copyWith(fontWeight: bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
