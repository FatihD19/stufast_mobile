import 'package:flutter/material.dart';

import '../../theme.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        children: [
          SizedBox(height: 40),
          Text('Invoice #1711670',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18)),
          Text('2023-02-07 11:38:25',
              style: primaryTextStyle.copyWith(fontSize: 14)),
          Chip(
              backgroundColor: primaryColor,
              label: Text('Lunas',
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
              Text('UserName', style: primaryTextStyle.copyWith(fontSize: 12)),
            ],
          ),
          SizedBox(height: 13),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('09.254.294.3-407.000 (NPWP)',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              Text('posmn@gmail.com',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
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
      return Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Course Documentations Report',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
              Text('Rp 450.000',
                  style: primaryTextStyle.copyWith(fontSize: 12)),
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
      );
    }

    Widget content() {
      return Column(
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
          invoiceItems()
        ],
      );
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
            Navigator.pushNamed(context, '/order-page');
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 25),
            child: Icon(
              Icons.download_sharp,
              color: primaryTextColor,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            header(),
            profile(),
            content(),
          ],
        ),
      ),
    );
  }
}
