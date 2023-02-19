import 'package:flutter/material.dart';

class AppConstant {

  static List<String> typeUsers = <String>['User', 'Shopper'];




  TextStyle h1Style({double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: size ?? 48,
      color: color,
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }

  TextStyle h2Style({double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: size ?? 20,
      color: color,
      fontWeight: fontWeight ?? FontWeight.w700,
    );
  }

  TextStyle h3Style({double? size, Color? color, FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: size ?? 14,
      color: color,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}
