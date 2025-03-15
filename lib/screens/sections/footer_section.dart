import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../constants/portfolio_data.dart';
import '../../utils/animation_utils.dart';
import '../../utils/responsive_utils.dart';
import '../../widgets/common_widgets.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final verticalPadding = ResponsiveUtils.getVerticalPadding(context);
    final horizontalPadding = ResponsiveUtils.getHorizontalPadding(context);
    final padding = EdgeInsets.fromLTRB(
      horizontalPadding.left,
      verticalPadding.top,
      horizontalPadding.right,
      verticalPadding.bottom,
    );

    return SectionContainer(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      padding: padding,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final social in PortfolioData.socialLinks)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SocialIcon(
                    platform: social['name'] as String,
                    url: social['url'] as String,
                    size: ResponsiveUtils.getIconSize(context, 20),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '© ${DateTime.now().year} ${PortfolioData.name}. All rights reserved.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ).animate(effects: AnimationUtils.fadeSlideUp),
          const SizedBox(height: 8),
          Text(
            'Built with Flutter Web',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
            textAlign: TextAlign.center,
          ).animate(effects: AnimationUtils.fadeSlideUp),
        ],
      ),
    );
  }
}
