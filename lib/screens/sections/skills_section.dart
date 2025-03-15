import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../constants/portfolio_data.dart';
import '../../utils/animation_utils.dart';
import '../../utils/responsive_utils.dart';
import '../../widgets/common_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return SectionContainer(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Skills',
            subtitle: 'My Technical Expertise',
          ),
          const SizedBox(height: 48),
          if (isMobile)
            Column(
              children: [
                for (final category in PortfolioData.skills)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: _buildSkillCategory(context, category),
                  ),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final category in PortfolioData.skills)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildSkillCategory(context, category),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 48),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Other Interests',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ).animate(effects: AnimationUtils.fadeSlideUp),
              const SizedBox(height: 24),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final interest in PortfolioData.interests)
                    _buildSkillChip(context, interest),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(
      BuildContext context, Map<String, dynamic> category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category['category'] as String,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ).animate(effects: AnimationUtils.fadeSlideUp),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final skill in category['items'] as List<dynamic>)
              _buildSkillChip(context, skill as String),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillChip(BuildContext context, String skill) {
    return Chip(
      label: Text(skill),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
    ).animate(effects: AnimationUtils.scaleIn);
  }
}
