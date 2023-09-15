import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/chart_model.dart';
import 'package:stufast_mobile/theme.dart';

class ChartItemTile extends StatefulWidget {
  ChartModel chart;
  ChartItemTile(this.chart);
  @override
  State<ChartItemTile> createState() => _ChartItemTileState();
}

class _ChartItemTileState extends State<ChartItemTile> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

    return Container(
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Card(
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
            child: ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    checkColor: primaryColor,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Image.network(
                    '${widget.chart.course?.thumbnail}',
                  ),
                ],
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.chart.course?.title}',
                    style: primaryTextStyle.copyWith(fontWeight: bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.cancel_outlined),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('2 video', style: secondaryTextStyle),
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Color(0xffA9CAFD),
                    ),
                    child: Text(
                      'Course',
                      style: buttonTextStyle.copyWith(fontWeight: bold),
                    ),
                  ),
                  Text(
                    '${widget.chart.course?.newPrice}',
                    style:
                        thirdTextStyle.copyWith(fontWeight: bold, fontSize: 16),
                  ),
                  Text('${widget.chart.course?.oldPrice}',
                      style: secondaryTextStyle),
                ],
              ),
            ),
          ),
        ));
  }
}
