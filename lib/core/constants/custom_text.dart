import 'package:flutter/material.dart';

import '../utils/app_mediaquery.dart';

/// Fonts used in Little Hearts app
enum FontFamily {
  nunito, // Default app font
  mogra, // Dashboard title & subtitle
}

/// Font weight types
enum FontWeightType { regular, medium, semiBold, bold, extraBold }

/// Extension for font weights
extension FontWeightTypeExtension on FontWeightType {
  FontWeight get value {
    switch (this) {
      case FontWeightType.regular:
        return FontWeight.w400;
      case FontWeightType.medium:
        return FontWeight.w500;
      case FontWeightType.semiBold:
        return FontWeight.w600;
      case FontWeightType.bold:
        return FontWeight.w700;
      case FontWeightType.extraBold:
        return FontWeight.w800;
    }
  }
}

/// Reusable Custom Text Widget
class CustomText extends StatelessWidget {
  final String text;
  final FontFamily fontFamily;
  final FontWeightType fontWeight;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final TextDecoration decoration;

  const CustomText({
    super.key,
    required this.text,
    this.fontFamily = FontFamily.nunito,
    this.fontWeight = FontWeightType.regular,
    this.fontSize = 14,
    this.color = const Color(0xFF000000),
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.decoration = TextDecoration.none,
  });

  String get _fontFamilyName {
    switch (fontFamily) {
      case FontFamily.mogra:
        return 'Mogra';
      case FontFamily.nunito:
        return 'Nunito';
      default:
        return 'Nunito';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontFamily: _fontFamilyName,
        fontSize: getProportionateScreenHeight(fontSize),
        fontWeight: fontWeight.value,
        color: color,
        decoration: decoration,
      ),
    );
  }
}
