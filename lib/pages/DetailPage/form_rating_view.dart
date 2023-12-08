import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/providers/bundle_provider.dart';
import 'package:stufast_mobile/providers/user_course_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

class RatingFormDialog extends StatefulWidget {
  final String courseId;
  bool? isBundle;
  RatingFormDialog(this.courseId, {this.isBundle, Key? key}) : super(key: key);
  @override
  _RatingFormDialogState createState() => _RatingFormDialogState();
}

class _RatingFormDialogState extends State<RatingFormDialog> {
  double _rating = 0.0;
  TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.isBundle == true
                      ? 'Berikan Rating Bundling untuk mendapatkan sertifikat'
                      : 'Berikan Rating Kursus untuk mendapatkan sertifikat',
                  style: primaryTextStyle.copyWith(
                      fontWeight: semiBold, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 40,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Berikan Ulasan dari kursus yang telah kamu pelajari',
                  style:
                      primaryTextStyle.copyWith(fontWeight: bold, fontSize: 15),
                ),
                SizedBox(height: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 380,
                    maxHeight: 200,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFAFAFA), // Warna latar belakang FAFAFA
                      border: Border.all(
                        color: Color(0xFFD2D2D2),
                        width: 1, // Border dengan stroke D2D2D2
                      ),
                      borderRadius: BorderRadius.circular(8), // Border radius 8
                    ),
                    child: TextField(
                      maxLines: 6,
                      controller: _feedbackController,
                      decoration: InputDecoration(
                        // hintText: hintText,
                        hintStyle: secondaryTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        contentPadding: EdgeInsets.all(12),
                        border: InputBorder
                            .none, // Tidak menampilkan border bawaan TextField
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(' * Minimal 100 karakter', style: secondaryTextStyle),
                    Text('${_feedbackController.text.length}/100',
                        style: secondaryTextStyle)
                  ],
                ),
                PrimaryButton(
                    text: 'Kirim Penilaian',
                    onPressed: () async {
                      if (_feedbackController.text.length >= 100) {
                        if (await context
                            .read<UserCourseProvider>()
                            .createCourseReview(widget.courseId,
                                _feedbackController.text, _rating.toInt(),
                                isBundle: widget.isBundle ?? false)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Berhasil memberikan penilaian'),
                            ),
                          );
                          widget.isBundle == true
                              ? await Provider.of<BundleProvider>(context,
                                      listen: false)
                                  .getDetailBundle(widget.courseId)
                              : await Provider.of<UserCourseProvider>(context,
                                      listen: false)
                                  .getDetailUserCourse(widget.courseId);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Gagal memberikan penilaian'),
                            ),
                          );
                        }
                        print('Rating: $_rating');
                        print('Feedback: ${_feedbackController.text}');
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Minimal 100 karakter'),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
