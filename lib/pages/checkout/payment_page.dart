import 'package:flutter/material.dart';
import 'package:stufast_mobile/theme.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pembayaran',
                      style: primaryTextStyle.copyWith(fontWeight: semiBold)),
                  SizedBox(height: 29),
                  Text(
                    "Segera lakukan pemayaran hingga:",
                    style: secondaryTextStyle,
                  ),
                  Text(
                    "Minggu, 4 Des 2022 9:41 WIB",
                    style: primaryTextStyle.copyWith(
                        fontSize: 18, fontWeight: bold),
                  ),
                  SizedBox(height: 24)
                ],
              ))),
    );
  }
}
