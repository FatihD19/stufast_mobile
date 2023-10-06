// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/chart_model.dart';
import 'package:stufast_mobile/pages/checkout/payment_page.dart';
import 'package:stufast_mobile/pages/checkout/payment_view.dart';

import '../../providers/checkout_provider.dart';
import '../../theme.dart';
import '../../widget/price_text_widget.dart';
import '../../widget/primary_button.dart';

class CheckOutPage extends StatefulWidget {
  List selectedItem;
  CheckOutPage(this.selectedItem);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  bool loading = true;
  String? selectPayment;
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
    await Provider.of<CheckoutProvider>(context, listen: false)
        .checkoutCourse(widget.selectedItem);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkOutProvider = Provider.of<CheckoutProvider>(context);

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

    Widget checkoutTile(String thumbnail, title, type, newPrice, oldPrice) {
      return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ListTile(
            leading: Image.network(
              '${thumbnail}',
              fit: BoxFit.cover,
              width: 63,
              height: 61,
            ),
            title: Text(
              '${title}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: primaryTextStyle.copyWith(fontWeight: bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: getColorForItemType('${type}'),
                  ),
                  child: Text(
                    '${type}',
                    style:
                        buttonTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    NewPrice(newPrice),
                    SizedBox(width: 8),
                    OldPrice(oldPrice),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget checkoutList() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pesanan anda',
              style: primaryTextStyle.copyWith(fontWeight: bold)),
          loading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: checkOutProvider.checkout!.item!
                      .map((checkout) => checkoutTile(
                          '${checkout.thumbnail}',
                          '${checkout.title}',
                          '${checkout.type}',
                          '${checkout.newPrice}',
                          '${checkout.oldPrice}'))
                      .toList()),
        ],
      );
    }

    Widget paymentTile(String img, title, id) {
      return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('$img', width: 50, height: 16),
                Text("$title",
                    style: primaryTextStyle.copyWith(
                        fontSize: 18, fontWeight: bold)),
                Radio(
                  value: '$id', // Mengganti value menjadi 'INVENTORI_TP_1'
                  groupValue: selectPayment,
                  onChanged: (value) {
                    setState(() {
                      selectPayment = value.toString();
                    });
                  },
                ),
              ],
            ),
            Divider(
              height: 20,
              thickness: 0.5,
              indent: 10,
              endIndent: 10,
              color: secondaryTextColor,
            ),
          ],
        ),
      );
    }

    Widget paymentList() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Text("Metode Pembayaran",
              style: primaryTextStyle.copyWith(fontWeight: bold)),
          Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffF3F3F3),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    children: [
                      paymentTile("assets/ic_bankMandiri.png",
                          "BNI Virtual Account", "982"),
                      paymentTile("assets/ic_bankBri.png",
                          "BRI Virtual Account", "932"),
                    ],
                  ),
                ),
              )),
        ],
      );
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
                child: Text(
                    'Total item (${checkOutProvider.checkout?.item?.length})',
                    style: secondaryTextStyle.copyWith(fontWeight: bold)),
              ),
              loading
                  ? CircularProgressIndicator()
                  : Column(
                      children: checkOutProvider.checkout!.item!
                          .map(
                            (item) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '• ${item.title!.length > 20 ? item.title!.substring(0, 20) + '...' : item.title}',
                                  style: secondaryTextStyle,
                                ),
                                NewPrice("${item.newPrice}")
                              ],
                            ),
                          )
                          .toList(),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('  • Flash Sale', style: secondaryTextStyle),
                  // Text(flashSale, style: secondaryTextStyle),
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
                          .format(
                              int.parse('${checkOutProvider.checkout?.total}'))
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

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Checkout',
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
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: loading
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  shrinkWrap: true,
                  children: [
                    checkoutList(),
                    paymentList(),
                    pricing(),
                    SizedBox(height: 14),
                    Container(
                        width: double.infinity,
                        height: 54,
                        child: PrimaryButton(
                            text: 'Bayar',
                            onPressed: () async {
                              await Provider.of<CheckoutProvider>(context,
                                      listen: false)
                                  .orderItem(widget.selectedItem);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentView(
                                        "${checkOutProvider.order?.token}")),
                              );
                            })),
                  ],
                ),
        ));
  }
}
