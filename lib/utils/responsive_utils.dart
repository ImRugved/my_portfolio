import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isMobile;

  static bool isTablet(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isTablet;

  static bool isDesktop(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isDesktop;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static EdgeInsets getHorizontalPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 8);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 24);
    } else {
      return const EdgeInsets.symmetric(horizontal: 32);
    }
  }

  static EdgeInsets getVerticalPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(vertical: 24);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(vertical: 32);
    } else {
      return const EdgeInsets.symmetric(vertical: 40);
    }
  }

  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) {
      return getScreenWidth(context);
    } else if (isTablet(context)) {
      return 768;
    } else {
      return 1200;
    }
  }

  static double getFontSize(BuildContext context, double baseSize) {
    if (isMobile(context)) {
      return baseSize * 0.8;
    } else if (isTablet(context)) {
      return baseSize * 0.9;
    } else {
      return baseSize;
    }
  }

  static double getIconSize(BuildContext context, double baseSize) {
    if (isMobile(context)) {
      return baseSize * 0.8;
    } else if (isTablet(context)) {
      return baseSize * 0.9;
    } else {
      return baseSize;
    }
  }

  static double getSpacing(BuildContext context, double baseSpacing) {
    if (isMobile(context)) {
      return baseSpacing * 0.8;
    } else if (isTablet(context)) {
      return baseSpacing * 0.9;
    } else {
      return baseSpacing;
    }
  }

  static int getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) {
      return 1;
    } else if (isTablet(context)) {
      return 2;
    } else {
      return 4;
    }
  }

  static double getGridChildAspectRatio(BuildContext context) {
    if (isMobile(context)) {
      return 1.2;
    } else if (isTablet(context)) {
      return 1.1;
    } else {
      return 1.0;
    }
  }
}
