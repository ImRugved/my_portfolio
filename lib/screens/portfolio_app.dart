import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_saver/file_saver.dart';
import '../theme/theme_provider.dart';
import '../widgets/animated_logo.dart';
import '../utils/scroll_utils.dart';
import 'sections/home_section.dart';
import 'sections/about_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';
import 'sections/header_section.dart';
import 'sections/hero_section.dart';
import 'sections/skills_section.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  final _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'Home': GlobalKey(),
    'About': GlobalKey(),
    'Skills': GlobalKey(),
    'Experience': GlobalKey(),
    'Projects': GlobalKey(),
    'Contact': GlobalKey(),
  };
  String _activeSection = 'Home';
  bool _isMobileMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Update active section based on scroll position
    for (final entry in _sectionKeys.entries) {
      final key = entry.value;
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        if (position.dy <= 100 && position.dy >= -box.size.height) {
          if (_activeSection != entry.key) {
            setState(() => _activeSection = entry.key);
          }
          break;
        }
      }
    }
  }

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    final context = key?.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);
      final offset = _scrollController.offset + position.dy - 80;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _downloadResume() async {
    try {
      final ByteData data = await rootBundle.load('assets/resume/resume.pdf');
      final Uint8List bytes = data.buffer.asUint8List();
      await FileSaver.instance.saveFile(
        name: 'Rugved_Belkundkar_Resume.pdf',
        bytes: bytes,
        ext: 'pdf',
        mimeType: MimeType.pdf,
      );
    } catch (e) {
      debugPrint('Error downloading resume: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Scaffold(
      appBar: HeaderSection(
        sections: _sectionKeys.keys.toList(),
        onSectionSelected: _scrollToSection,
        activeSection: _activeSection,
      ),
      body: Stack(
        children: [
          NotificationListener<ScrollToSectionNotification>(
            onNotification: (notification) {
              // Handle notification by scrolling to the section
              if (_sectionKeys.containsKey(notification.sectionName)) {
                _scrollToSection(notification.sectionName);
              }
              return true; // Stop notification propagation
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  VisibilityDetector(
                    key: _sectionKeys['Home']!,
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.5) {
                        setState(() => _activeSection = 'Home');
                      }
                    },
                    child: const HeroSection(),
                  ),
                  VisibilityDetector(
                    key: _sectionKeys['About']!,
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.5) {
                        setState(() => _activeSection = 'About');
                      }
                    },
                    child: const AboutSection(),
                  ),
                  VisibilityDetector(
                    key: _sectionKeys['Skills']!,
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.5) {
                        setState(() => _activeSection = 'Skills');
                      }
                    },
                    child: const SkillsSection(),
                  ),
                  VisibilityDetector(
                    key: _sectionKeys['Experience']!,
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.5) {
                        setState(() => _activeSection = 'Experience');
                      }
                    },
                    child: const ExperienceSection(),
                  ),
                  VisibilityDetector(
                    key: _sectionKeys['Projects']!,
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.5) {
                        setState(() => _activeSection = 'Projects');
                      }
                    },
                    child: const ProjectsSection(),
                  ),
                  VisibilityDetector(
                    key: _sectionKeys['Contact']!,
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.5) {
                        setState(() => _activeSection = 'Contact');
                      }
                    },
                    child: const ContactSection(),
                  ),
                  const FooterSection(),
                ],
              ),
            ),
          ),
          if (!isDesktop && _isMobileMenuOpen)
            Positioned(
              top: kToolbarHeight,
              left: 0,
              right: 0,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Home'),
                      onTap: () => _scrollToSection('Home'),
                    ),
                    ListTile(
                      title: const Text('About'),
                      onTap: () => _scrollToSection('About'),
                    ),
                    ListTile(
                      title: const Text('Skills'),
                      onTap: () => _scrollToSection('Skills'),
                    ),
                    ListTile(
                      title: const Text('Experience'),
                      onTap: () => _scrollToSection('Experience'),
                    ),
                    ListTile(
                      title: const Text('Projects'),
                      onTap: () => _scrollToSection('Projects'),
                    ),
                    ListTile(
                      title: const Text('Contact'),
                      onTap: () => _scrollToSection('Contact'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _downloadResume,
        icon: const Icon(Icons.download),
        label: const Text('Download Resume'),
      ),
    );
  }
}
