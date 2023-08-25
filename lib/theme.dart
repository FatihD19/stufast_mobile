import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 30.0;

Color primaryColor = Color(0xff248043);
Color secondaryColor = Color(0xff164520);

Color primaryTextColor = Color(0xff1F1F1F);
Color secondaryTextColor = Color(0xff7D7D7D);

Color buttonTextColor = Color(0xffFFFFFF);

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: primaryTextColor,
);
TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: secondaryTextColor,
);
TextStyle thirdTextStyle = GoogleFonts.poppins(
  color: primaryColor,
);
TextStyle buttonTextStyle = GoogleFonts.poppins(
  color: buttonTextColor,
);

FontWeight light = FontWeight.w100;
FontWeight reguler = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
