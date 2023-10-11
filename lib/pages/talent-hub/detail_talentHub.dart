import 'package:flutter/material.dart';

import '../../theme.dart';

class DetailTalentHubPage extends StatelessWidget {
  const DetailTalentHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Talent Hub',
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
        elevation: 0, // Menghilangkan shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
    );
  }
}
