import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary900 = Color.fromARGB(255, 3, 83, 180);
  static const Color primary800 = Color.fromARGB(255, 16, 88, 177);
  static const Color primary700 = Color.fromARGB(255, 28, 96, 180);
  static const Color primary600 = Color.fromARGB(255, 43, 106, 182);
  static const Color primary500 = Color.fromARGB(255, 54, 110, 179);
  static const Color primary400 = Color(0xFF3F72AF);
  static const Color primary300 = Color.fromARGB(255, 79, 123, 177);
  static const Color primary200 = Color.fromARGB(255, 106, 137, 175);
  static const Color primary100 = Color.fromARGB(255, 229, 233, 241);
  static const Color primaryLight = Color.fromARGB(255, 235, 236, 245);

  static const Color secondary700 = Color.fromARGB(255, 56, 56, 56);
  static const Color secondary600 = Color.fromARGB(255, 99, 98, 98);
  static const Color secondary500 = Color.fromARGB(255, 134, 134, 134);
  static const Color secondary400 = Color.fromARGB(255, 151, 151, 150);
  static const Color secondary300 = Color.fromARGB(255, 206, 206, 205);

  static const Color error = Color(0xFFFA6D55);
  static const Color softError = Color(0xFFD9928C);

  static const Color onPrimary = white;
  static const Color onSecondary = white;
  static const Color onSurface = black;
  static const Color onError = white;
  static const Color onBackground = white;

  static const Color background = Color(0xFFF8F8FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFF949494);
  static const Color black = Color(0xFF000000);
  static const Color softBlack = Color(0xFF090327);
  static const Color lightBlack = Color(0xFF48445A);
  // static const Color line = Color(0xFFF6F6F6);
  static const Color line = Color(0xFFEAEAEA);
  static const Color softGray = Color(0xFFEAEAEA);
  static const Color otp = Color(0xFFEAEAEA);
  static const Color indicator = Color(0xFFD1D0D8);
  static const Color caption = Color(0xFFA9A9A9);
  static const Color description = Color(0xFF626365);
  static const Color floatLabel = Color(0xFF666666);
  static const Color snackbar = Color(0xFF333436);
  static Color cameraOverlay = const Color(0xFF323232).withOpacity(0.5);

  static const Color softRed = Color(0xFFD73D64);
  static const Color hardBlue = Color(0xFF5B5DE9);
  static const Color blue = Color(0xFF05AFFF);
  static const Color darkBlue = Color(0xFF0C7DFF);
  static const Color lightBlue = Color(0xFF05C5FB);
  static const Color fadeBlue = Color(0xFFCDEFFF);
  static const Color softGreen = Color.fromARGB(255, 107, 225, 121);
  static const Color green = Color(0xFF35C947);
  static const Color purple = Color(0xFFA033FD);
  static const Color orange = Color(0xFFFA6D55);

  static const Color booking = Color(0xFFF45B7D);
  static const Color renting = Color(0xFF6AA3EE);
  static const Color busing = Color(0xFFF5C401);

  static const Color shimmerBaseColor = Color(0xFFEDEDED);
  static const Color shimmerHighlightColor = Color(0xFFD1D1D1);

  static const Color purpleStart = Color(0xFF8435DA);
  static const Color purpleEnd = Color(0xFF4927EB);

  static const Color navigationGray = Color(0xFF9C9FA6);

  static const Color yellow = Color(0xFFF9D649);
}
