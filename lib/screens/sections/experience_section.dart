import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/portfolio_data.dart';
import '../../theme/theme_constants.dart';
import '../../utils/animation_utils.dart';
import '../../utils/responsive_utils.dart' as app_responsive;
import '../../widgets/common_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SectionContainer(
      title: 'My Experience',
      backgroundColor: isDarkMode ? ThemeConstants.dark : ThemeConstants.light,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 16),
      child: Column(
        children: [
            _buildTimeline(context, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, bool isMobile) {
    return Column(
      children: [
        for (int i = 0; i < PortfolioData.experience.length; i++)
          _buildTimelineItem(
            context,
            PortfolioData.experience[i],
            isLast: i == PortfolioData.experience.length - 1,
            isMobile: isMobile,
          ),
      ],
    ).animate(effects: AnimationUtils.fadeSlideUp);
  }

  Widget _buildTimelineItem(
    BuildContext context,
    Map<String, dynamic> experience, {
    required bool isLast,
    required bool isMobile,
  }) {
    final title = experience['title'] as String;
    final company = experience['company'] as String;
    final location = experience['location'] as String;
    final duration = experience['duration'] as String;
    final description = experience['description'] as List<dynamic>;

    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) _buildTimelineDot(context, isLast),
          Expanded(
            child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
                    color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
                    offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                        fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                              "$company, $location",
                              style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
          ),
            decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              duration,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
              ),
            ),
          ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  company != 'Udemy'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var item in description)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                                        item as String,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            description[0] as String,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildTimelineDot(BuildContext context, bool isLast) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 72,
      margin: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkMode ? ThemeConstants.dark : Colors.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          if (!isLast)
            Container(
              width: 2,
              height: 180,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
        ],
      ),
        );
  }
}
