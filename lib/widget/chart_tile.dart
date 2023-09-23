import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/chart_model.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/price_text_widget.dart';

class ChartItemTile extends StatefulWidget {
  ItemChartModel item;
  ChartItemTile(this.item);
  @override
  State<ChartItemTile> createState() => _ChartItemTileState();
}

class _ChartItemTileState extends State<ChartItemTile> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

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

    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffF3F3F3),
          ),
          child: Row(
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
                '${widget.item.thumbnail}',
                fit: BoxFit.cover,
                width: 63,
                height: 61,
              ),
              SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.item.title}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: primaryTextStyle.copyWith(fontWeight: bold),
                    ),
                    Text(
                        widget.item.type == 'webinar'
                            ? '${widget.item.webinarTag}'
                            : widget.item.type == 'bundling'
                                ? '${widget.item.totalItem} course'
                                : '${widget.item.totalItem} video',
                        style: secondaryTextStyle),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: getColorForItemType('${widget.item.type}'),
                      ),
                      child: Text(
                        '${widget.item.type}',
                        style: buttonTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    NewPrice(widget.item.newPrice),
                    OldPrice(widget.item.oldPrice),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 90),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.cancel_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

          // child: ListTile(
          //   leading: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Checkbox(
          //         checkColor: primaryColor,
          //         value: isChecked,
          //         onChanged: (bool? value) {
          //           setState(() {
          //             isChecked = value!;
          //           });
          //         },
          //       ),
          //       Image.network(
          //         '${widget.item.thumbnail}',
          //         fit: BoxFit.cover,
          //         width: 63,
          //         height: 61,
          //       ),
          //     ],
          //   ),
          //   title: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(
          //         child: Text(
          //           '${widget.item.title}',
          //           overflow: TextOverflow.ellipsis,
          //           maxLines: 2,
          //           style: primaryTextStyle.copyWith(fontWeight: bold),
          //         ),
          //       ),
          //       IconButton(
          //         onPressed: () {},
          //         icon: Icon(Icons.cancel_outlined),
          //       ),
          //     ],
          //   ),
          //   subtitle: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text('2 video', style: secondaryTextStyle),
          //       Container(
          //         padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(3),
          //           color: Color(0xffA9CAFD),
          //         ),
          //         child: Text(
          //           'Course',
          //           style: buttonTextStyle.copyWith(fontWeight: bold),
          //         ),
          //       ),
          //       Text(
          //         '${widget.item.newPrice}',
          //         style:
          //             thirdTextStyle.copyWith(fontWeight: bold, fontSize: 16),
          //       ),
          //       Text('${widget.item.oldPrice}', style: secondaryTextStyle),
          //     ],
          //   ),
          // ),