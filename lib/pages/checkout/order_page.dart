import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/providers/order_provider.dart';
import 'package:stufast_mobile/widget/orderTile.dart';

import '../../theme.dart';

class OrderPage extends StatefulWidget {
  String? orderType;
  OrderPage({this.orderType, super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String selectedTag = '';
  @override
  void initState() {
    // TODO: implement initState
    selectedTag = widget.orderType ?? 'pending';
    getOrder();
    super.initState();
  }

  getOrder() async {
    await Provider.of<OrderProvider>(context, listen: false)
        .getorderHistory(selectedTag);
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    Widget tagView(String tag) {
      return InkWell(
        onTap: () {
          setState(() {
            selectedTag = tag;
            getOrder();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xffF3F3F3), // Warna garis tepi
            ),
            color: selectedTag == tag
                ? const Color(
                    0xffE9F2EC) // Change color if selectedTag is 'all'
                : const Color(0xffFAFAFA),
          ),
          child: Text(
            tag,
            style: secondaryTextStyle.copyWith(
              color: selectedTag == tag ? Colors.green : null,
            ),
          ),
        ),
      );
    }

    Widget filterTag() {
      return Row(
        children: [
          tagView('pending'),
          tagView('paid'),
          tagView('cancel'),
        ],
      );
    }

    Widget orderList() {
      return orderProvider.loading
          ? Center(child: CircularProgressIndicator())
          : orderProvider.orderHistoryPending.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2),
                      Image.asset('assets/img_empty_order.png'),
                      SizedBox(height: 24),
                      Text(
                        'Tidak ada order',
                        style: primaryTextStyle.copyWith(
                            fontWeight: semiBold, fontSize: 18),
                      ),
                    ],
                  ),
                )
              : ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: orderProvider.orderHistoryPending
                      .map((order) => OrderTile(order))
                      .toList(),
                );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Order',
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
        elevation: 0, // Menghilangkan shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [filterTag(), orderList()],
        ),
      ),
    );
  }
}
