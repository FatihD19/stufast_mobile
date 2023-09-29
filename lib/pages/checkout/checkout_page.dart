import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/checkout_provider.dart';
import '../../theme.dart';
import '../../widget/price_text_widget.dart';

class CheckOutPage extends StatefulWidget {
  List selectedItem;
  CheckOutPage(this.selectedItem);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  bool loading = true;
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
                  style: buttonTextStyle.copyWith(fontWeight: FontWeight.bold),
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
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          backgroundColor: Colors.white,
          centerTitle: false,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListView(
            shrinkWrap: true,
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
                          .toList())
            ],
          ),
        ));
  }
}
