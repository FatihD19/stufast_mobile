import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stufast_mobile/theme.dart';

class OldPrice extends StatelessWidget {
  String? oldPrice;
  OldPrice(this.oldPrice);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: NumberFormat.simpleCurrency(locale: 'id')
            .format(int.parse('${oldPrice}'))
            .replaceAll(',00', ''),
        style: secondaryTextStyle.copyWith(
          fontSize: 15,
          decoration: TextDecoration.lineThrough,
        ),
      ),
    );
  }
}

class NewPrice extends StatelessWidget {
  String? newPrice;
  NewPrice(this.newPrice);

  @override
  Widget build(BuildContext context) {
    return Text(
      NumberFormat.simpleCurrency(locale: 'id')
          .format(int.parse('${newPrice}'))
          .replaceAll(',00', ''),
      style: thirdTextStyle.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    );
  }
}
