import 'package:flutter/material.dart';

import '../theme.dart';

class LoadingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  buttonTextColor,
                ),
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'Loading',
              style: buttonTextStyle.copyWith(
                fontSize: 16,
                fontWeight: bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
