// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/invoice_model.dart';
import 'package:stufast_mobile/pages/checkout/order_page.dart';
import 'package:stufast_mobile/pages/checkout/payment_view.dart';
import 'package:stufast_mobile/providers/order_provider.dart';
import 'package:stufast_mobile/providers/user_course_provider.dart';
import 'package:stufast_mobile/widget/price_text_widget.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

import '../../theme.dart';

class InvoicePage extends StatefulWidget {
  String orderId;
  InvoicePage(this.orderId, {super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  bool? loading;
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
    await Provider.of<OrderProvider>(context, listen: false)
        .getInvoice(widget.orderId);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    InvoiceModel? invoice = orderProvider.invoice;

    String status = '${invoice?.transactionStatus}';

    Widget header() {
      return Column(
        children: [
          Text('Invoice #${invoice?.orderId}',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18)),
          Text('${invoice?.transactionTime}',
              style: primaryTextStyle.copyWith(fontSize: 14)),
          Chip(
              backgroundColor: status == 'paid'
                  ? primaryColor
                  : status == 'pending'
                      ? Color(0xffE57917)
                      : Color(0xffD82222),
              label: Text('${invoice?.transactionStatus}',
                  style:
                      buttonTextStyle.copyWith(fontWeight: bold, fontSize: 14)))
        ],
      );
    }

    Widget profile() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pembayaran Kepada :',
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: bold)),
              Text('Pelanggan :',
                  style: primaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: bold)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('PT .SWEVEL UNIVERSAL MEDIA',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              Container(
                width: 140,
                child: Text('${invoice?.fullname}',
                    textAlign: TextAlign.right,
                    style: primaryTextStyle.copyWith(fontSize: 12)),
              ),
            ],
          ),
          SizedBox(height: 13),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 140,
                child: Text('09.254.294.3-407.000 (NPWP)',
                    style: primaryTextStyle.copyWith(fontSize: 12)),
              ),
              Container(
                width: 140,
                child: Text('${invoice?.email}',
                    textAlign: TextAlign.right,
                    style: primaryTextStyle.copyWith(fontSize: 12)),
              ),
            ],
          ),
          SizedBox(height: 18),
          Text('Invoice Items',
              style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: bold)),
          SizedBox(height: 25),
        ],
      );
    }

    Widget invoiceItems() {
      return orderProvider.loading == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: orderProvider.invoice!.item!
                  .map((item) => Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text('${item.title}',
                                    style: primaryTextStyle.copyWith(
                                        fontSize: 12)),
                              ),
                              InvoicePrice('${item.price}')
                            ],
                          ),
                          SizedBox(height: 5),
                          Divider(
                            height: 20,
                            thickness: 1,
                            indent: 1,
                            endIndent: 1,
                            color: secondaryTextColor,
                          ),
                        ],
                      ))
                  .toList());
    }

    Widget pricingItem(String tittle, String value, {bool line = true}) {
      return Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  width: 60,
                  alignment: Alignment.bottomLeft,
                  child: Text('$tittle',
                      style: primaryTextStyle.copyWith(fontSize: 12))),
              SizedBox(width: 40),
              Container(
                  alignment: Alignment.bottomRight,
                  width: 80,
                  child: InvoicePrice(value)),
            ],
          ),
          SizedBox(height: 5),
          line == true
              ? Divider(
                  height: 20,
                  thickness: 1,
                  indent: 1,
                  endIndent: 1,
                  color: secondaryTextColor,
                )
              : SizedBox(),
        ],
      );
    }

    Widget total() {
      return Container(
        padding: EdgeInsets.only(right: 11),
        color: Color(0xffBEE5EB),
        width: double.infinity,
        height: 51,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 60,
              alignment: Alignment.centerLeft,
              child: Text('total',
                  style: primaryTextStyle.copyWith(
                      fontSize: 12, fontWeight: bold)),
            ),
            SizedBox(width: 40),
            InvoicePrice('${invoice?.grossAmount}'),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        padding: EdgeInsets.only(right: 11),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Deskripsi',
                    style: primaryTextStyle.copyWith(
                        fontSize: 12, fontWeight: bold)),
                Text('Jumlah',
                    style: primaryTextStyle.copyWith(
                        fontSize: 12, fontWeight: bold)),
              ],
            ),
            invoiceItems(),
            pricingItem('Sub Total', '${invoice?.rawPrice}'),
            pricingItem('Diskon ${invoice?.discountPrice}%',
                '${invoice?.discountAmount}'),
            pricingItem('PPN 11%', '${invoice?.tax}', line: false),
          ],
        ),
      );
    }

    Widget actionBtn() {
      return status == 'pending'
          ? Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  child: PrimaryButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaymentView("${invoice?.snapToken}")));
                    },
                    text: 'Bayar Sekarang',
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Exit App'),
                          content: Text('Batalkan Pesanan ?'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              //return false when click on "NO"
                              child: Text('Tidak'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (await context
                                    .read<OrderProvider>()
                                    .cancelOrder('${invoice?.orderId}')) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        'Pesanan dibatalkan',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderPage(orderType: 'cancel')));
                                }
                              },
                              child: Text('Batalkan'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Batalkan Pesanan',
                      style: buttonTextStyle.copyWith(fontWeight: semiBold),
                    ),
                  ),
                ),
              ],
            )
          : SizedBox();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invoice',
          style: primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
        ),
        elevation: 0, // Menghilangkan shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/order-page');
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: () async {
                await Provider.of<UserCourseProvider>(context, listen: false)
                    .downloadSertif(
                      invoice: true,
                      idInvoice: invoice?.orderId,
                    )
                    .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'berhasil unduh sertifikar',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ));
              },
              icon: Icon(Icons.download),
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: loading == true
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  SizedBox(height: 20),
                  header(),
                  profile(),
                  content(),
                  total(),
                  SizedBox(height: 20),
                  actionBtn(),
                  SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}
