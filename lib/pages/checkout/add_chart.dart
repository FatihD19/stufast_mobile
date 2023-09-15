import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/chart_model.dart';
import 'package:stufast_mobile/providers/chart_provider.dart';
import 'package:stufast_mobile/providers/user_course_provider.dart';
import 'package:stufast_mobile/widget/chart_tile.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

import '../../theme.dart';

class AddToChartPage extends StatefulWidget {
  const AddToChartPage({super.key});

  @override
  State<AddToChartPage> createState() => _AddToChartPageState();
}

class _AddToChartPageState extends State<AddToChartPage> {
  void initState() {
    // TODO: implement initState
    Provider.of<ChartProvider>(context, listen: false).getChart();
    super.initState();
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    ChartProvider chartProvider = Provider.of<ChartProvider>(context);

    Widget chartTile() {
      return Column(
          children: chartProvider.chart
              .map((chart) => ChartItemTile(chart))
              .toList());
    }

    Widget checkOut() {
      return Container(
        height: 178,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select All',
                    style: secondaryTextStyle.copyWith(fontWeight: bold)),
                Checkbox(
                  checkColor: primaryColor,
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
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
                Text('Total (2) item',
                    style: secondaryTextStyle.copyWith(fontWeight: bold)),
                Text('Rp. 2.000.000',
                    style: thirdTextStyle.copyWith(fontWeight: bold))
              ],
            ),
            SizedBox(height: 24),
            Container(
                width: double.infinity,
                height: 54,
                child: PrimaryButton(text: 'Masuk', onPressed: () {})),
          ],
        ),
      );
    }

    return Scaffold(
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
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [chartTile()],
        ),
      ),
      bottomNavigationBar: checkOut(),
    );
  }
}
