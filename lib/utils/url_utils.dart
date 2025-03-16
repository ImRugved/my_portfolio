// import 'dart:developer';
// import 'dart:io';
// import 'dart:io';

// import 'dart:math' as math;
// import 'package:flutter/foundation.dart' show kIsWeb;
// //import 'dart:html' as html;
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/material.dart';
// import 'scroll_utils.dart'; // Import for ScrollToSectionNotification

// class UrlUtils {
//   static Future<void> openUrl(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     }
//   }

//   static Future<void> sendEmail(String email,
//       {String? subject, String? body}) async {
//     final Uri emailUri = Uri(
//       scheme: 'mailto',
//       path: email,
//       query: encodeQueryParameters({
//         if (subject != null) 'subject': subject,
//         if (body != null) 'body': body,
//       }),
//     );
//     if (await canLaunchUrl(emailUri)) {
//       await launchUrl(emailUri);
//     }
//   }

//   static String encodeQueryParameters(Map<String, String> params) {
//     return params.entries
//         .map((e) =>
//             '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
//         .join('&');
//   }

//   static Future<void> makePhoneCall(String phoneNumber) async {
//     final uri = Uri(
//       scheme: 'tel',
//       path: phoneNumber,
//     );
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     }
//   }

//   static Future<void> openMap(String address) async {
//     final encodedAddress = Uri.encodeComponent(address);
//     final uri = Uri.parse(
//         'https://www.google.com/maps/search/?api=1&query=$encodedAddress');
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     }
//   }

//   // static Future<void> openPdf(String url) async {
//   //   log('clicked on open pdf');
//   //   final uri = Uri.parse(url);
//   //   if (await canLaunchUrl(uri)) {
//   //     await launchUrl(
//   //       uri,
//   //       mode: LaunchMode.externalApplication,
//   //     );
//   //   }
//   // }

// //below is working on windowss
//   static Future<void> openPdf(String assetPath) async {
//     try {
//       log('Preparing to open PDF: $assetPath');

//       // Check if it's a remote URL
//       if (assetPath.startsWith('http://') || assetPath.startsWith('https://')) {
//         // Handle as a remote URL
//         final uri = Uri.parse(assetPath);
//         if (await canLaunchUrl(uri)) {
//           await launchUrl(
//             uri,
//             mode: LaunchMode.externalApplication,
//           );
//           log('Launched remote PDF URL: $assetPath');
//         } else {
//           log('Cannot launch URL: $assetPath');
//           throw 'Could not launch $assetPath';
//         }
//       } else {
//         // Handle as a local asset file

//         // 1. Get the application documents directory
//         final directory = await getApplicationDocumentsDirectory();

//         // 2. Generate a unique filename to avoid conflicts
//         final random = math.Random().nextInt(10000);
//         final timestamp = DateTime.now().millisecondsSinceEpoch;
//         final tempFilePath =
//             '${directory.path}/resume_${timestamp}_$random.pdf';

//         // 3. Load the asset file as bytes
//         log('Loading asset as bytes: $assetPath');
//         final ByteData data = await rootBundle.load(assetPath);
//         final List<int> bytes = data.buffer.asUint8List();

//         // 4. Write the asset bytes to a temporary file
//         log('Writing asset to temporary file: $tempFilePath');
//         final File tempFile = File(tempFilePath);

//         // 5. Check if file exists and try to delete it first
//         if (await tempFile.exists()) {
//           try {
//             await tempFile.delete();
//             log('Deleted existing file');
//           } catch (e) {
//             log('Could not delete existing file: $e');
//             // Continue anyway with a new unique filename
//           }
//         }

//         // 6. Write the file
//         await tempFile.writeAsBytes(bytes);

//         // 7. Launch the file using URL launcher
//         final uri = Uri.file(tempFilePath);
//         log('Launching PDF with URI: $uri');

//         if (await canLaunchUrl(uri)) {
//           final result = await launchUrl(
//             uri,
//             mode: LaunchMode.externalApplication,
//           );

//           if (result) {
//             log('Successfully launched PDF');
//           } else {
//             log('Failed to launch PDF');
//             throw 'Failed to launch PDF';
//           }
//         } else {
//           log('Cannot launch file: $tempFilePath');
//           throw 'Could not launch $tempFilePath';
//         }
//       }
//     } catch (e) {
//       log('Error opening PDF: $e');
//       rethrow; // Rethrow so the caller can handle or display error
//     }
//   }

//   static Future<void> openSocialMedia(String platform, String username) async {
//     String url;
//     switch (platform.toLowerCase()) {
//       case 'github':
//         url = 'https://github.com/$username';
//         break;
//       case 'linkedin':
//         url = 'https://linkedin.com/in/$username';
//         break;
//       case 'twitter':
//         url = 'https://twitter.com/$username';
//         break;
//       default:
//         return;
//     }
//     await openUrl(url);
//   }

//   // Store a BuildContext that can be set from the hero section
//   static BuildContext? _currentContext;

//   static void setContext(BuildContext context) {
//     _currentContext = context;
//   }

//   static void scrollToSection(String sectionId) {
//     if (_currentContext != null) {
//       final notification = ScrollToSectionNotification(sectionId);
//       notification.dispatch(_currentContext!);
//     } else if (navigatorKey.currentContext != null) {
//       // Fallback to using navigator key if context isn't set
//       final notification = ScrollToSectionNotification(sectionId);
//       notification.dispatch(navigatorKey.currentContext!);
//     }
//   }

//   // Add a global navigator key to access context outside of widgets
//   static final GlobalKey<NavigatorState> navigatorKey =
//       GlobalKey<NavigatorState>();
// }
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';

//import 'dart:html' as html;

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'scroll_utils.dart'; // Import for ScrollToSectionNotification

class UrlUtils {
  static Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> sendEmail(String email,
      {String? subject, String? body}) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters({
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      }),
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  static String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static Future<void> openMap(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$encodedAddress');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // static Future<void> openPdf(String url) async {
  //   log('clicked on open pdf');
  //   final uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(
  //       uri,
  //       mode: LaunchMode.externalApplication,
  //     );
  //   }
  // }

  static Future<void> openPdf(String assetPath) async {
    try {
      // Web implementation
      if (assetPath.startsWith('http://') || assetPath.startsWith('https://')) {
        html.window.open(assetPath, '_blank');
      } else {
        final response = await rootBundle.load(assetPath);
        final bytes = response.buffer.asUint8List();

        final blob = html.Blob([bytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);

        html.window.open(url, '_blank');
      }
    } catch (e) {
      print('Error opening PDF on web: $e');
    }
  }

  static Future<void> openSocialMedia(String platform, String username) async {
    String url;
    switch (platform.toLowerCase()) {
      case 'github':
        url = 'https://github.com/$username';
        break;
      case 'linkedin':
        url = 'https://linkedin.com/in/$username';
        break;
      case 'twitter':
        url = 'https://twitter.com/$username';
        break;
      default:
        return;
    }
    await openUrl(url);
  }

  // Store a BuildContext that can be set from the hero section
  static BuildContext? _currentContext;

  static void setContext(BuildContext context) {
    _currentContext = context;
  }

  static void scrollToSection(String sectionId) {
    if (_currentContext != null) {
      final notification = ScrollToSectionNotification(sectionId);
      notification.dispatch(_currentContext!);
    } else if (navigatorKey.currentContext != null) {
      // Fallback to using navigator key if context isn't set
      final notification = ScrollToSectionNotification(sectionId);
      notification.dispatch(navigatorKey.currentContext!);
    }
  }

  // Add a global navigator key to access context outside of widgets
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
