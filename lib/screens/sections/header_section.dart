import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../constants/portfolio_data.dart';
import '../../theme/theme_provider.dart';
import '../../utils/animation_utils.dart';
import '../../utils/responsive_utils.dart';

class HeaderSection extends StatelessWidget implements PreferredSizeWidget {
  final List<String> sections;
  final Function(String) onSectionSelected;
  final String? activeSection;

  const HeaderSection({
    super.key,
    required this.sections,
    required this.onSectionSelected,
    this.activeSection,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return AppBar(
      title: SizedBox(
        width: isMobile ? 200 : 350, // Adjust width based on screen size
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
                overflow: TextOverflow.ellipsis, // Handle overflow gracefully
              ),
          maxLines: 1, // Ensure text stays on one line
          child: AnimatedTextKit(
            animatedTexts: PortfolioData.headings.map((heading) {
              return TypewriterAnimatedText(
                heading,
                speed: const Duration(milliseconds: 80),
                cursor: '...',
              );
            }).toList(),
            repeatForever: true,
            pause: const Duration(seconds: 3),
            displayFullTextOnTap: true,
            isRepeatingAnimation: true,
          ),
        ),
      ).animate(effects: AnimationUtils.scaleIn),
      actions: [
        if (!isMobile) ...[
          for (final section in sections)
            TextButton(
              onPressed: () => onSectionSelected(section),
              style: TextButton.styleFrom(
                foregroundColor: activeSection == section
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).textTheme.bodyMedium?.color,
                textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: activeSection == section
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
              ),
              child: Text(section),
            ).animate(effects: AnimationUtils.fadeSlideUp),
          const SizedBox(width: 16),
        ],
        IconButton(
          icon: Icon(
            themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: () => themeProvider.toggleTheme(),
          tooltip: themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
        ).animate(effects: AnimationUtils.scaleIn),
        if (isMobile)
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _showMobileMenu(context),
              tooltip: 'Menu',
            ).animate(effects: AnimationUtils.scaleIn),
          ),
      ],
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final section in sections)
              ListTile(
                title: Text(section),
                selected: activeSection == section,
                onTap: () {
                  onSectionSelected(section);
                  Navigator.pop(context);
                },
              ).animate(effects: AnimationUtils.fadeSlideUp),
          ],
        ),
      ),
    );
  }
}
