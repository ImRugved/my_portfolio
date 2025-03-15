import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/animation_utils.dart';
import '../utils/responsive_utils.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool centerAlign;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.centerAlign = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveUtils.getFontSize(context, 32),
              ),
        ).animate(effects: AnimationUtils.fadeSlideUp),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
            textAlign: centerAlign ? TextAlign.center : TextAlign.start,
          ).animate(effects: AnimationUtils.fadeSlideUp),
        ],
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = isOutlined
        ? Theme.of(context).outlinedButtonTheme.style
        : Theme.of(context).elevatedButtonTheme.style;

    final button = icon != null
        ? (isOutlined
            ? OutlinedButton.icon(
                onPressed: onPressed,
                icon: Icon(icon),
                label: Text(text),
                style: buttonStyle,
              )
            : ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(icon),
                label: Text(text),
                style: buttonStyle,
              ))
        : (isOutlined
            ? OutlinedButton(
                onPressed: onPressed,
                style: buttonStyle,
                child: Text(text),
              )
            : ElevatedButton(
                onPressed: onPressed,
                style: buttonStyle,
                child: Text(text),
              ));

    return button.animate(effects: AnimationUtils.scaleIn);
  }
}

class SocialIcon extends StatelessWidget {
  final String platform;
  final String url;
  final double? size;

  const SocialIcon({
    super.key,
    required this.platform,
    required this.url,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    IconData getIcon() {
      switch (platform.toLowerCase()) {
        case 'github':
          return FontAwesomeIcons.github;
        case 'linkedin':
          return FontAwesomeIcons.linkedin;
        case 'twitter':
          return FontAwesomeIcons.twitter;
        case 'gitlab':
          return FontAwesomeIcons.gitlab;
        case 'email':
          return FontAwesomeIcons.envelope;
        case 'phone':
          return FontAwesomeIcons.phone;
        default:
          return FontAwesomeIcons.link;
      }
    }

    return IconButton(
      icon: Icon(
        getIcon(),
        size: size ?? ResponsiveUtils.getIconSize(context, 24),
      ),
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      tooltip: platform,
    ).animate(effects: AnimationUtils.scaleIn);
  }
}

class SkillCard extends StatelessWidget {
  final String name;
  final double level;

  const SkillCard({
    super.key,
    required this.name,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: level,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    ).animate(effects: AnimationUtils.fadeSlideUp);
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: Theme.of(context).cardTheme.color,
      selectedColor: Theme.of(context).colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected
            ? Colors.white
            : Theme.of(context).textTheme.bodyMedium?.color,
      ),
    ).animate(effects: AnimationUtils.scaleIn);
  }
}

class SectionContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final String? title;
  final String? subtitle;
  final bool centerTitle;

  const SectionContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.title,
    this.subtitle,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: padding ??
          ResponsiveUtils.getHorizontalPadding(context).add(
            ResponsiveUtils.getVerticalPadding(context),
          ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveUtils.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              if (title != null) ...[
                SectionTitle(
                  title: title!,
                  subtitle: subtitle,
                  centerAlign: centerTitle,
                ),
                const SizedBox(height: 48),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }
}
