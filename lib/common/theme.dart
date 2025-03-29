import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:examen_flutter/common/constants_colors.dart';

import 'constants_colors.dart';


ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light(useMaterial3: true).copyWith(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kWhiteColor,
      appBarTheme: appBarTheme,
      textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme
          .apply(bodyColor: kDarkColor, displayColor: kDarkColor))
  );

}

//Pour gerer notre theme dark
ThemeData darktheme(BuildContext context) {
  return ThemeData.dark(useMaterial3: true).copyWith(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: kDarkColor,
      appBarTheme: appBarTheme.copyWith(
          titleTextStyle: const TextStyle(
              color: kWhiteColor,
              fontSize: 24,
              fontWeight: FontWeight.bold
          )

      ),
      textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme
          .apply(bodyColor: kWhiteColor, displayColor: kWhiteColor))
  );
}

const appBarTheme = AppBarTheme(
    centerTitle: false,
    backgroundColor: kPrimaryColor,
    iconTheme: IconThemeData(
        color: kPrimaryColor
    ),
    titleTextStyle: TextStyle(
        color: kDarkColor,
        fontSize: 24,
        fontWeight: FontWeight.bold
    )
);