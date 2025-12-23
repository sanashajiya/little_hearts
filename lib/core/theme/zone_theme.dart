import 'package:flutter/material.dart';

import 'app_colors.dart';

enum ZoneMode {
  friend,
  date,
}

class ZoneTheme {
  final Color primary;
  final Color dark;
  final Color light;

  const ZoneTheme({
    required this.primary,
    required this.dark,
    required this.light,
  });

  factory ZoneTheme.fromMode(ZoneMode mode) {
    switch (mode) {
      case ZoneMode.date:
        return const ZoneTheme(
          primary: AppColors.dateMode,
          dark: AppColors.dateModeDark,
          light: AppColors.dateModeLight,
        );
      case ZoneMode.friend:
        return const ZoneTheme(
          primary: AppColors.friendMode,
          dark: AppColors.friendModeDark,
          light: AppColors.friendModeLight,
        );
    }
  }
}


