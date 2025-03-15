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
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const HeaderSection({
    super.key,
    required this.sections,
    required this.onSectionSelected,
    this.activeSection,
    this.scaffoldKey,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      title: Container(
        padding: EdgeInsets.symmetric(
            horizontal: isTablet
                ? 10
                : isMobile
                    ? 8
                    : 12,
            vertical: 8),
        width: isMobile ? 200 : 420,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
                overflow: TextOverflow.ellipsis,
                fontSize: isMobile ? 16 : 20,
              ),
          maxLines: 1,
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
      titleSpacing: 8,
      centerTitle: false,
      leading: isMobile
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                if (scaffoldKey?.currentState != null) {
                  scaffoldKey!.currentState!.openDrawer();
                }
              },
            )
          : null,
      actions: [
        if (!isMobile)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet
                          ? 10
                          : isMobile
                              ? 8
                              : 14,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    section,
                    style: TextStyle(
                      fontSize: isTablet ? 12 : 16,
                    ),
                  ),
                ).animate(effects: AnimationUtils.fadeSlideUp),
            ],
          ),
        IconButton(
          padding: EdgeInsets.symmetric(
              horizontal: isTablet
                  ? 10
                  : isMobile
                      ? 8
                      : 12),
          icon: Icon(
            themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: () => themeProvider.toggleTheme(),
          tooltip: themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
        ).animate(effects: AnimationUtils.scaleIn),
      ],
    );
  }

  // Helper method to get icon for each section
  Widget _getIconForSection(String section) {
    IconData iconData;
    switch (section) {
      case 'Home':
        iconData = Icons.home;
        break;
      case 'About':
        iconData = Icons.person;
        break;
      case 'Skills':
        iconData = Icons.code;
        break;
      case 'Experience':
        iconData = Icons.work;
        break;
      case 'Projects':
        iconData = Icons.app_shortcut;
        break;
      case 'Contact':
        iconData = Icons.email;
        break;
      default:
        iconData = Icons.arrow_forward;
    }
    return Icon(iconData);
  }
}
