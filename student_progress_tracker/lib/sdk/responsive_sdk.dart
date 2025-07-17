import 'package:flutter/material.dart';

class ResponsiveSdk {
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  static double paddingSmall(BuildContext context) => screenWidth(context) * (8 / 375);
  static double paddingMedium(BuildContext context) => screenWidth(context) * (16 / 375);
  static double paddingLarge(BuildContext context) => screenWidth(context) * (24 / 375);
  
  static double fontSizeExtraSmall(BuildContext context) => screenWidth(context) * (12 / 375);
  static double fontSizeSmall(BuildContext context) => screenWidth(context) * (16 / 375);
  static double fontSizeMedium(BuildContext context) => screenWidth(context) * (20 / 375);
  static double fontSizeLarge(BuildContext context) => screenWidth(context) * (24 / 375);
  
  static double buttonHeight(BuildContext context) => screenWidth(context) * (48 / 375);
  static double textFieldHeight(BuildContext context) => screenWidth(context) * (56 / 375);
  static double borderRadius(BuildContext context) => screenWidth(context) * (8 / 375);
  static double chartHeight(BuildContext context) => screenHeight(context) * 0.3;
}