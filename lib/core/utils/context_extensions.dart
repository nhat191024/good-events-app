import 'package:forui/forui.dart';
import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  FThemeData get fTheme => FTheme.of(this);
  ThemeData get theme => Theme.of(this);

  Size get mediaQuerySize => MediaQuery.sizeOf(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  // Truy cập nhanh Typography: context.typography
  FTypography get typography => fTheme.typography;

  //Get theme colors
  Color get primary => theme.colorScheme.primary;

  //Get screen dimensions
  double get screenWidth => mediaQuerySize.width;
  double get screenHeight => mediaQuerySize.height;

  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;
}
