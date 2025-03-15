import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/responsive_helper.dart';
import '../widgets/section_title.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveHelper.getScreenPadding(context),
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'About Me'),
          const SizedBox(height: 32),
          _buildAboutContent(context),
        ],
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    final isSmallScreen = ResponsiveHelper.isMobile(context);

    if (isSmallScreen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAboutImage(),
          const SizedBox(height: 24),
          _buildAboutText(context),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildAboutImage()),
        const SizedBox(width: 48),
        Expanded(flex: 3, child: _buildAboutText(context)),
      ],
    );
  }

  Widget _buildAboutImage() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          'https://img.freepik.com/free-photo/programming-background-with-person-working-with-codes-computer_23-2150010125.jpg',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.grey[400],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAboutText(BuildContext context) {
    final skills = [
      'Flutter',
      'Dart',
      'Firebase',
      'RESTful APIs',
      'GetX',
      'Provider',
      'BLoC',
      'MVC',
      'MVVM',
      'SQFlite',
      'Shared Preferences',
      'Hive',
      'Get Storage',
      'Phone Payment SDK',
      'Razorpay',
      'FCM',
      'Rive',
      'Lottie'
    ];

    final tools = [
      'Android Studio',
      'VS Code',
      'Xcode',
      'GitLab',
      'GitHub',
      'Shorebird CI/CD',
      'Firebase Console',
      'Play Store',
      'App Store'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter Developer & Mobile App Specialist',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: ResponsiveHelper.getFontSize(context, 22),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I\'m a Senior Flutter Developer with extensive experience in building user-friendly mobile applications for Android and iOS platforms. With a strong focus on clean code and optimal performance, I\'ve successfully deployed multiple apps on Play Store and Apple App Store, revolutionizing operational efficiency and increasing user engagement.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: ResponsiveHelper.getFontSize(context, 16),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'I graduated with a Bachelor\'s degree in Electrical Engineering from TSSM\'s Bhivarabai Sawant College, Pune University with a CGPA of 8.18. My technical journey began with an internship at Biencaps Systems, where I mastered Flutter and Dart, and I\'ve since grown into a Senior Flutter Developer creating innovative solutions across various domains.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: ResponsiveHelper.getFontSize(context, 16),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        _buildDownloadResumeButton(context),
        const SizedBox(height: 24),
        _buildSkillsSection(context, 'Technical Skills', skills),
        const SizedBox(height: 24),
        _buildSkillsSection(context, 'Tools & Platforms', tools),
      ],
    );
  }

  Widget _buildDownloadResumeButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _downloadResume,
      icon: const Icon(Icons.download_rounded, color: Colors.white),
      label: const Text(
        'Download Resume',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
      ),
    );
  }

  void _downloadResume() {
    // For web platform
    final anchor = html.AnchorElement(
      href: 'assets/resume/resume.pdf',
    )
      ..setAttribute('download', 'Rugved_Resume.pdf')
      ..click();
  }

  Widget _buildSkillsSection(
      BuildContext context, String title, List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: ResponsiveHelper.getFontSize(context, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              skills.map((skill) => _buildSkillChip(context, skill)).toList(),
        ),
      ],
    );
  }

  Widget _buildSkillChip(BuildContext context, String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        skill,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: ResponsiveHelper.getFontSize(context, 14),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
