import 'package:flutter/material.dart';
import 'package:stufast_mobile/theme.dart';

class VideoTile extends StatefulWidget {
  String? title;
  String? duration;
  VideoTile(this.title, this.duration);

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          // child: ListTile(
          //   leading: Image.asset('assets/icon_video.png'),
          //   title: Text(
          //     '${title}',
          //     style: primaryTextStyle.copyWith(fontWeight: bold),
          //     maxLines: 2,
          //     overflow: TextOverflow.ellipsis,
          //   ),
          //   trailing: Text('${duration} menit', style: secondaryTextStyle),
          // ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              leading: Image.asset('assets/icon_video.png'),
              title: Text(
                '${widget.title}',
                style: primaryTextStyle.copyWith(fontWeight: bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing:
                  Text('${widget.duration} menit', style: secondaryTextStyle),
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Latar belakang putih
                      onPrimary: Color(
                          0xFF164520), // Warna teks saat di atas latar putih
                      side: BorderSide(
                          color: Color(0xFF164520),
                          width: 2), // Border berwarna 248043 dengan lebar 2
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Border radius 10
                      ),
                    ),
                    child: Text(
                      'Lanjutkan',
                      style: thirdTextStyle.copyWith(fontWeight: bold),
                    ),
                  ),
                ),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _customTileExpanded = expanded;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
