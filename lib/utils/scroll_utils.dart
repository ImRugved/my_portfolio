import 'package:flutter/material.dart';

// Custom notification to request scrolling to a section
class ScrollToSectionNotification extends Notification {
  final String sectionName;

  ScrollToSectionNotification(this.sectionName);

  // Static method to dispatch the notification from the current context
  static void scrollTo(BuildContext context, String sectionName) {
    ScrollToSectionNotification(sectionName).dispatch(context);
  }
}
