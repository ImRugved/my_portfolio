import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../utils/responsive_helper.dart';

class HomeSection extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeSection({Key? key, required this.onNavigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ResponsiveHelper.isMobile(context);
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      height: screenSize.height,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 20 : 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, I\'m',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: isSmallScreen ? 24 : 32,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Rugved Belkundkar',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: isSmallScreen ? 40 : 56,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Flutter Developer',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: isSmallScreen ? 32 : 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: isSmallScreen ? screenSize.width : screenSize.width * 0.5,
            child: Text(
              'I build exceptional mobile and web applications that provide intuitive, pixel-perfect user interfaces with efficient and modern backends.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: isSmallScreen ? 16 : 20,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => onNavigate(4), // Navigate to Contact section
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Get In Touch',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () => onNavigate(3), // Navigate to Projects section
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'View Projects',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(FontAwesomeIcons.linkedinIn, 'https://www.linkedin.com/in/imrugved'),
              const SizedBox(width: 16),
              _buildSocialIcon(FontAwesomeIcons.gitlab, 'https://gitlab.com/ImRugved'),
              const SizedBox(width: 16),
              _buildSocialIcon(Icons.email, 'mailto:rugvedbelkundkar@gmail.com'),
              const SizedBox(width: 16),
              _buildSocialIcon(Icons.phone, 'tel:9545724774'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      color: AppColors.primary,
      iconSize: 24,
      splashRadius: 24,
      tooltip: url,
    );
  }
}
