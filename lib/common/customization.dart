import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSize {
  static double height(BuildContext context, double value) {
    return MediaQuery.of(context).size.height * value;
  }

  static double width(BuildContext context, double value) {
    return MediaQuery.of(context).size.width * value;
  }
}

class CustomFont {
  static TextStyle poppins(Color colors, double size, FontWeight weight) {
    return GoogleFonts.poppins(
        color: colors, fontSize: size, fontWeight: weight);
  }
}

class IconAssets {
  static SvgPicture facebookIcon =
      SvgPicture.asset("assets/svg/facebook-icon.svg");
  static SvgPicture googleIcon =
      SvgPicture.asset("assets/svg/google-icon.svg");
}

class ImageAssets {
  static Image USA = Image.asset("assets/image/usa.png");
  static Image IND = Image.asset("assets/image/ind.png");
  static Image AFC = Image.asset("assets/image/afc.png");
  static Image JAP = Image.asset("assets/image/jap.png");
}
