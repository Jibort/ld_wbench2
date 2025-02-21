import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle txsAppBarTitleStyle({Color? pFgColor}) {
  return TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 18.0.h,
    fontStyle: FontStyle.normal,
    color: pFgColor ?? Colors.orange.shade600,
    fontFamily: 'Roboto',
  );
}

TextStyle txsAppBarSubtitleStyle({Color? pFgColor}) {
  return TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12.0.h,
    fontStyle: FontStyle.normal,
    color: pFgColor ?? Colors.orange.shade100,
    fontFamily: 'Roboto',
  );
}
