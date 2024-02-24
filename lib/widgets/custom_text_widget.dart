import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CustomTextWidget extends StatelessWidget {
  
  final String text;
  final double textFontSize;
  final Color textColor;
  final FontWeight textFontWeight;
  final TextOverflow textOverflow;
  final int? maxLines;
  
  const CustomTextWidget({
    super.key,
    required this.text,
    this.textFontSize = 12,
    this.textColor = ApplicationColorConstants.blackColor,
    this.textFontWeight =  FontWeight.normal,
    this.textOverflow = TextOverflow.visible,
    this.maxLines = null
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textFontSize,
        color: textColor,
        fontWeight: textFontWeight,
      ),
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }
}
