import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function? onClick;
  final double borderRadius;
  final Color? color;
  final Color? textColor;
  final double fontSize;
  final bool isEnabled;
  final FontWeight fontFamily;

  const AppButton(
      {required this.text,
      required this.onClick,
      this.borderRadius = 4,
      this.color,
      this.fontFamily = FontWeight.w500,
      this.textColor,
      this.fontSize = 15,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: const BoxConstraints(minHeight: 44, maxHeight: 44),
      onPressed: isEnabled ? () => onClick?.call() : null,
      fillColor: isEnabled ? color : Colors.white54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      child: Text(text, style: TextStyle(color: textColor, fontWeight: fontFamily, fontSize: fontSize)),
    );
  }
}
