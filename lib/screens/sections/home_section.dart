import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: isDesktop ? 100 : 50,
      ),
      child: ResponsiveRowColumn(
        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
        layout: isDesktop
            ? ResponsiveRowColumnType.ROW
            : ResponsiveRowColumnType.COLUMN,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hi, I'm",
                  style: TextStyle(
                    fontSize: isDesktop ? 24 : 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 8),
                Text(
                  'Rugved Belkundkar',
                  style: TextStyle(
                    fontSize: isDesktop ? 48 : 32,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(delay: 400.ms).slideX(),
                const SizedBox(height: 16),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: isDesktop ? 24 : 20,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Senior Flutter Developer',
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'Mobile App Specialist',
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'UI/UX Enthusiast',
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    repeatForever: true,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Senior Flutter Developer with proven expertise in building user-friendly mobile applications. Successfully deployed 5+ apps on Play Store and Apple App Store.',
                  style: TextStyle(
                    fontSize: isDesktop ? 18 : 16,
                    height: 1.5,
                  ),
                ).animate().fadeIn(delay: 600.ms),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement scroll to contact section
                      },
                      icon: const Icon(Icons.person_add),
                      label: const Text('Hire Me'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ).animate().fadeIn(delay: 800.ms),
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Implement scroll to projects section
                      },
                      icon: const Icon(Icons.work),
                      label: const Text('View Projects'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ).animate().fadeIn(delay: 1000.ms),
                  ],
                ),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 16,
                  children: [
                    IconButton(
                      onPressed: () =>
                          _launchUrl('https://www.linkedin.com/in/imrugved'),
                      icon: const Icon(FontAwesomeIcons.linkedinIn),
                    ).animate().fadeIn(delay: 1200.ms),
                    IconButton(
                      onPressed: () =>
                          _launchUrl('https://gitlab.com/ImRugved'),
                      icon: const Icon(FontAwesomeIcons.gitlab),
                    ).animate().fadeIn(delay: 1400.ms),
                    IconButton(
                      onPressed: () =>
                          _launchUrl('mailto:rugvedbelkundkar@gmail.com'),
                      icon: const Icon(Icons.email),
                    ).animate().fadeIn(delay: 1600.ms),
                    IconButton(
                      onPressed: () => _launchUrl('tel:9545724774'),
                      icon: const Icon(Icons.phone),
                    ).animate().fadeIn(delay: 1800.ms),
                  ],
                ),
              ],
            ),
          ),
          if (isDesktop || isTablet) ...[
            ResponsiveRowColumnItem(
              child: const SizedBox(width: 40),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 2,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://img.freepik.com/free-photo/portrait-young-indian-top-manager-suit-with-crossed-arms_496169-1513.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ).animate().scale(delay: 500.ms).fadeIn(),
            ),
          ],
        ],
      ),
    );
  }
}
