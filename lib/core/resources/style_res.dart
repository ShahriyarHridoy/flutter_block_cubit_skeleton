import 'package:flutter/material.dart';

class StyleRes {
  StyleRes._init();

  static const kBottomSheetRadius = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10.0),
    topRight: Radius.circular(10.0),
  ));
  static const kFontFamily = 'Poppins';
  static const kFontFamilyBangla = 'Noto Sans Bengali';
  static const kFontSize18 = 18.0;
  static const kFontSize14 = 14.0;
  static const kFontWeightSemiBold = FontWeight.w600;
  static const kFontWeightRegular = FontWeight.w400;
}
