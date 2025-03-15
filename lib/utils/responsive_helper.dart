import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 650;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > 650 && MediaQuery.of(context).size.width <= 1100;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 1100;
  }

  static Widget responsiveWidget({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    }
    if (isTablet(context)) {
      return tablet ?? mobile;
    }
    return mobile;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static EdgeInsets getScreenPadding(BuildContext context) {
    final width = getScreenWidth(context);
    if (width <= 650) {
      return const EdgeInsets.symmetric(horizontal: 20);
    } else if (width <= 1100) {
      return const EdgeInsets.symmetric(horizontal: 40);
    } else {
      return EdgeInsets.symmetric(horizontal: width * 0.1);
    }
  }

  static double getFontSize(BuildContext context, double size) {
    if (isMobile(context)) {
      return size * 0.8;
    } else if (isTablet(context)) {
      return size * 0.9;
    } else {
      return size;
    }
  }
}
