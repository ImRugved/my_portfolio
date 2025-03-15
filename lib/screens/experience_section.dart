import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/responsive_helper.dart';
import '../widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveHelper.getScreenPadding(context),
      color: AppColors.backgroundAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'My Experience'),
          const SizedBox(height: 32),
          _buildTimeline(context),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    final experiences = [
      {
        'role': 'Sr. Flutter Developer',
        'company': 'TechTrail Technologies Pvt. Ltd., Pune',
        'period': 'Dec 2024 - Present',
        'responsibilities': [
          'Developed 3 innovative mobile applications across education, healthcare, and medical communication sectors',
          'Implemented scalable Flutter solutions using Provider/Getx state management',
          'Engineered robust CI/CD pipelines and multi-environment Flutter flavors, reducing deployment time by 35%',
          'Integrated native functionalities via Kotlin and Flutter platform channels',
          'Created high-performance applications with optimized code structures'
        ],
      },
      {
        'role': 'Jr. Flutter Developer',
        'company': 'Daccess Security Systems Pvt Ltd, Pune',
        'period': 'Mar 2024 - Dec 2024',
        'responsibilities': [
          'Developed 5 high-impact mobile applications with increased user engagement',
          'Implemented MVC/MVVM patterns and BloC/GetX state management',
          'Integrated Google Maps and REST APIs, improved location accuracy by 45%',
          'Developed secure authentication systems using Firebase Authentication',
          'Leveraged Firebase Storage and Cloud Messaging for real-time data synchronization'
        ],
      },
      {
        'role': 'Flutter Development Intern',
        'company': 'Biencaps Systems Private Limited, Pune',
        'period': 'Sep 2023 - Feb 2024',
        'responsibilities': [
          'Mastered Dart and Flutter framework with extensive skills in mobile development',
          'Implemented diverse features to enhance user interface of mobile applications',
          'Built user-friendly interfaces with Flutter\'s widget-based architecture',
          'Worked with senior developers to troubleshoot and debug issues',
          'Collaborated in an Agile team environment to deliver timely updates'
        ],
      },
    ];

    return Column(
      children: experiences.asMap().entries.map((entry) {
        final index = entry.key;
        final exp = entry.value;
        return _buildTimelineItem(
          context,
          role: exp['role'] as String,
          company: exp['company'] as String,
          period: exp['period'] as String,
          responsibilities: exp['responsibilities'] as List<String>,
          isLast: index == experiences.length - 1,
        );
      }).toList(),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required String role,
    required String company,
    required String period,
    required List<String> responsibilities,
    required bool isLast,
  }) {
    final isSmallScreen = ResponsiveHelper.isMobile(context);
    final lineHeight = isLast ? 0.0 : 50.0;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isSmallScreen)
          Container(
            width: 40,
            margin: const EdgeInsets.only(top: 8),
            child: Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  height: lineHeight,
                  color: isLast ? Colors.transparent : AppColors.primary.withOpacity(0.3),
                  margin: const EdgeInsets.only(left: 9),
                ),
              ],
            ),
          ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: isSmallScreen ? 0 : 16,
              bottom: isLast ? 0 : 40,
            ),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    period,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: ResponsiveHelper.getFontSize(context, 14),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  role,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: ResponsiveHelper.getFontSize(context, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  company,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: ResponsiveHelper.getFontSize(context, 16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                ...responsibilities.map((responsibility) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              responsibility,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: ResponsiveHelper.getFontSize(context, 15),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
