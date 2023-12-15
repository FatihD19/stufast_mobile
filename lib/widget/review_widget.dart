import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stufast_mobile/models/review_model.dart';
import 'package:stufast_mobile/theme.dart';

class ReviewTile extends StatelessWidget {
  Review review;
  ReviewTile(this.review, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffF2F4F6),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'http://dev.stufast.id/upload/users/${review.profilePicture}',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text('${review.fullname}',
                    style: thirdTextStyle.copyWith(fontWeight: bold)),
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    unratedColor: Color(0xffF0DB96),
                    rating: double.parse('${review.score}'),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Color(0xffFFCB42),
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(width: 4),
                  Text('${review.score}', style: primaryTextStyle)
                ],
              ),
            ],
          ),
          subtitle: Text('“${review.feedback}”',
              textAlign: TextAlign.justify, style: primaryTextStyle),
        ),
      ),
    );
  }
}
