import 'package:url_launcher/url_launcher.dart';

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

  static Future<void> openPdf(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
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

  static void scrollToSection(String sectionId) {
    // This is a placeholder method that will be implemented in the portfolio_app.dart file
    // The actual implementation will use the scroll controller to scroll to the section
    print('Scrolling to section: $sectionId');
  }
}
