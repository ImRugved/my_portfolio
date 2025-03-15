import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/portfolio_data.dart';
import '../../theme/theme_constants.dart';
import '../../utils/animation_utils.dart';
import '../../utils/responsive_utils.dart' as app_responsive;
import '../../widgets/common_widgets.dart';
import '../../utils/scroll_utils.dart'; // Import for ScrollToSectionNotification

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return SectionContainer(
      title: 'About Me',
      child: ResponsiveRowColumn(
        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        layout: isMobile
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 5,
            child: Container(
              margin: EdgeInsets.only(
                  right: isMobile ? 0 : 40, bottom: isMobile ? 40 : 0),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(38),
                  child: Image.asset(
                    'assets/images/about.jpg',
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(38),
                        ),
                        child: const Center(
                          child: Icon(Icons.error, size: 50),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ).animate(effects: AnimationUtils.fadeSlideUp),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 7,
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  PortfolioData.aboutMe['title']!,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: app_responsive.ResponsiveUtils.getFontSize(
                            context, 24),
                      ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                ).animate(effects: AnimationUtils.fadeSlideUp),
                const SizedBox(height: 16),
                Text(
                  PortfolioData.aboutMe['description1']!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: ThemeConstants.textLight,
                      ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                ).animate(effects: AnimationUtils.fadeSlideUp),
                const SizedBox(height: 16),
                Text(
                  PortfolioData.aboutMe['description2']!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: ThemeConstants.textLight,
                      ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                ).animate(effects: AnimationUtils.fadeSlideUp),
                const SizedBox(height: 24),
                // Button to navigate to Skills section
                OutlinedButton.icon(
                  onPressed: () {
                    // Using Notification to communicate with parent
                    ScrollToSectionNotification.scrollTo(context, "Skills");
                  },
                  icon: Icon(Icons.arrow_circle_right_outlined,
                      color: Theme.of(context).colorScheme.primary),
                  label: Text(
                    'View My Skills',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ).animate(effects: AnimationUtils.fadeSlideUp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
