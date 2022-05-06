import 'package:demo_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

OutlineInputBorder kBorderDecoration() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(2.0.w),
    borderSide: const BorderSide(color: Kolors.primaryText, width: 0.5),
  );
} // Border decoration for text field

TextStyle bttnTextStyle() {
  return const TextStyle(
      color: Kolors.primaryText, fontWeight: FontWeight.w700);
} // TextStyle For Normal Buttons

SizedBox kSizedBox() {
  return SizedBox(
    height: 3.0.h,
  );
}       // SizedBox to give vertical white spaces between widgets
