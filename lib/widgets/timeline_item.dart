import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/responsive_helper.dart';

class TimelineItem extends StatelessWidget {
  final String period;
  final String title;
  final String company;
  final List<String> achievements;
  final int index;

  const TimelineItem({
    Key? key,
    required this.period,
    required this.title,
    required this.company,
    required this.achievements,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ResponsiveHelper.isMobile(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSmallScreen) ...[
            Container(
              width: 120,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                period,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveHelper.getFontSize(context, 14),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 32),
          ],
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isSmallScreen) ...[
                    Text(
                      period,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveHelper.getFontSize(context, 14),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveHelper.getFontSize(context, 20),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    company,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: ResponsiveHelper.getFontSize(context, 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...achievements.map((achievement) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            achievement,
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: ResponsiveHelper.getFontSize(context, 14),
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
      ),
    );
  }
}
