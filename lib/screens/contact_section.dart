import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../utils/responsive_helper.dart';
import '../widgets/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveHelper.getScreenPadding(context),
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Contact Me'),
          const SizedBox(height: 32),
          _buildContactContent(context),
        ],
      ),
    );
  }

  Widget _buildContactContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Let\'s Connect',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: ResponsiveHelper.getFontSize(context, 24),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I\'m currently open for new opportunities and collaborations. Feel free to reach out!',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: ResponsiveHelper.getFontSize(context, 16),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        _buildContactItem(
          context,
          icon: Icons.location_on,
          title: 'Location',
          value: 'Pune, Maharashtra',
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          context,
          icon: Icons.phone,
          title: 'Phone',
          value: '+91 9545724774',
          onTap: () => _launchUrl('tel:9545724774'),
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          context,
          icon: Icons.email,
          title: 'Email',
          value: 'rugvedbelkundkar@gmail.com',
          onTap: () => _launchUrl('mailto:rugvedbelkundkar@gmail.com'),
        ),
        const SizedBox(height: 32),
        _buildSocialLinks(context),
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: ResponsiveHelper.getFontSize(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: onTap != null ? AppColors.primary : AppColors.textSecondary,
                    fontSize: ResponsiveHelper.getFontSize(context, 14),
                    decoration: onTap != null ? TextDecoration.underline : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    final socialLinks = [
      {
        'icon': FontAwesomeIcons.linkedin,
        'url': 'https://www.linkedin.com/in/imrugved',
      },
      {
        'icon': FontAwesomeIcons.gitlab,
        'url': 'https://gitlab.com/ImRugved',
      },
      {
        'icon': Icons.email,
        'url': 'mailto:rugvedbelkundkar@gmail.com',
      },
      {
        'icon': Icons.phone,
        'url': 'tel:9545724774',
      },
    ];

    return Row(
      children: socialLinks.map((link) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: InkWell(
            onTap: () => _launchUrl(link['url'] as String),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                link['icon'] as IconData,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
