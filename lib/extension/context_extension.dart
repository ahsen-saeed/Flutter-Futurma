import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';


extension ContextExtension on BuildContext {

  Size get screenSize => MediaQuery.of(this).size;
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;


  bool get isHaveBottomNotch => window.viewPadding.bottom > 0 && Platform.isIOS;

  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;

  double get bottomNotchHeight => MediaQuery.of(this).viewPadding.bottom;
  void unfocus() => FocusScope.of(this).unfocus();

}

extension EmptyPadding on num{
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());

}

