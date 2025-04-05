import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rugved_portfolio_flutter/providers/count_controller.dart';
import 'package:rugved_portfolio_flutter/providers/downloadCount_provider.dart';
import 'package:rugved_portfolio_flutter/providers/firebase_provider.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //final DownloadCounterProvider downloadProvider = DownloadCounterProvider();
  final DownloadCounterController downloadProvider =
      Get.put(DownloadCounterController());
  final Map<String, GlobalKey> _sectionKeys = {
    'Home': GlobalKey(),
    'About': GlobalKey(),
    'Skills': GlobalKey(),
    'Experience': GlobalKey(),
    'Projects': GlobalKey(),
    'Contact': GlobalKey(),
  };
  String _activeSection = 'Home';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    downloadProvider.loadDownloadCount();
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
    // Close drawer if open
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();

      // Add a small delay to ensure the drawer is fully closed before scrolling
      Future.delayed(const Duration(milliseconds: 300), () {
        _performScroll(section);
      });
    } else {
      _performScroll(section);
    }
  }

  void _performScroll(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      final box = key!.currentContext!.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);
      final offset = _scrollController.offset + position.dy - 80;

      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      // Update active section
      if (_activeSection != section) {
        setState(() => _activeSection = section);
      }
    }
  }

  static Future<void> downloadResume(BuildContext context) async {
    try {
      final downloadProvider = Get.put(DownloadCounterController());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text(
              'Enter your name and email to download resume',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: downloadProvider.nmCtrl1,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: downloadProvider.emCtrl1,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String name = downloadProvider.nmCtrl1.text.trim();
                    String email = downloadProvider.emCtrl1.text.trim();
                    if (name != '' && email != '') {
                      // TODO: Handle download logic here
                      await FirebaseProvider().resumeDownloadMessage(
                        name: name,
                        email: email,
                      );

                      Navigator.of(context).pop();
                      // Close the dialog
                      // Optional: Show snackbar or toast
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Preparing resume for download...'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // Track download in Firebase
                      await FirebaseProvider().trackResumeDownload();

                      // Load the resume PDF from assets
                      final ByteData data =
                          await rootBundle.load('assets/resume/resume.pdf');
                      final Uint8List bytes = data.buffer.asUint8List();

                      bool success = false;

                      // Handle different platforms
                      if (kIsWeb) {
                        // Web platform
                        await FileSaver.instance.saveFile(
                          name: 'Rugved_Belkundkar_Resume.pdf',
                          bytes: bytes,
                          ext: 'pdf',
                          mimeType: MimeType.pdf,
                        );
                        success = true;
                      } else if (Platform.isWindows ||
                          Platform.isLinux ||
                          Platform.isMacOS) {
                        // Desktop platforms
                        success = await _saveFileOnDesktop(bytes);
                      } else {
                        // Mobile platforms
                        await FileSaver.instance.saveFile(
                          name: 'Rugved_Belkundkar_Resume.pdf',
                          bytes: bytes,
                          ext: 'pdf',
                          mimeType: MimeType.pdf,
                        );
                        success = true;
                      }

                      // Show success or error message
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Resume downloaded successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        downloadProvider.nmCtrl1.clear();

                        downloadProvider.emCtrl1
                            .clear(); // Update the provider to reflect the new download count
                        // Option 1: Increment the local count immediately

                        downloadProvider.incrementDownloadCount();
                        downloadProvider.loadDownloadCount();
                        // Option 2: Refresh from Firebase (more accurate but slower)
                        // Provider.of<DownloadCounterProvider>(context, listen: false).loadDownloadCount();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Failed to download resume. Please try again.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please enter both name and email to see the resume'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      // Optional: Show error message
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Download Resume'),
                ),
              ],
            ),
          );
        },
      );
      // Show loading indicator
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Preparing resume for download...'),
      //     duration: Duration(seconds: 2),
      //   ),
      // );

      // // Track download in Firebase
      // await FirebaseProvider().trackResumeDownload();

      // // Load the resume PDF from assets
      // final ByteData data = await rootBundle.load('assets/resume/resume.pdf');
      // final Uint8List bytes = data.buffer.asUint8List();

      // bool success = false;

      // // Handle different platforms
      // if (kIsWeb) {
      //   // Web platform
      //   await FileSaver.instance.saveFile(
      //     name: 'Rugved_Belkundkar_Resume.pdf',
      //     bytes: bytes,
      //     ext: 'pdf',
      //     mimeType: MimeType.pdf,
      //   );
      //   success = true;
      // } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      //   // Desktop platforms
      //   success = await _saveFileOnDesktop(bytes);
      // } else {
      //   // Mobile platforms
      //   await FileSaver.instance.saveFile(
      //     name: 'Rugved_Belkundkar_Resume.pdf',
      //     bytes: bytes,
      //     ext: 'pdf',
      //     mimeType: MimeType.pdf,
      //   );
      //   success = true;
      // }

      // // Show success or error message
      // if (success) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Resume downloaded successfully!'),
      //       backgroundColor: Colors.green,
      //     ),
      //   );
      //   downloadProvider.nmCtrl1.clear();

      //   downloadProvider.emCtrl1
      //       .clear(); // Update the provider to reflect the new download count
      //   // Option 1: Increment the local count immediately

      //   downloadProvider.incrementDownloadCount();
      //   downloadProvider.loadDownloadCount();
      //   // Option 2: Refresh from Firebase (more accurate but slower)
      //   // Provider.of<DownloadCounterProvider>(context, listen: false).loadDownloadCount();
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Failed to download resume. Please try again.'),
      //       backgroundColor: Colors.red,
      //     ),
      //   );
      // }
    } catch (e) {
      debugPrint('Error downloading resume: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Save file using FilePicker's saveFile method (for desktop platforms)
  static Future<bool> _saveFileOnDesktop(Uint8List bytes) async {
    try {
      // Ask user to select where to save the file
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Resume',
        fileName: 'Rugved_Belkundkar_Resume.pdf',
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (outputFile == null) {
        // User canceled the save dialog
        return false;
      }

      // Create the file at the selected location and write the bytes
      final file = File(outputFile);
      await file.writeAsBytes(bytes);
      return true;
    } catch (e) {
      debugPrint('Error saving file on desktop: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _scaffoldKey,
        appBar: HeaderSection(
          sections: _sectionKeys.keys.toList(),
          onSectionSelected: _scrollToSection,
          activeSection: _activeSection,
          scaffoldKey: _scaffoldKey,
        ),
        drawer: isMobile ? _buildDrawer() : null,
        body: NotificationListener<ScrollToSectionNotification>(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await downloadResume(context);
          },
          icon: const Icon(Icons.download),
          label: const Text('Resume'),
        ));
  }

  Widget _buildDrawer() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    radius: 24,
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Portfolio',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      themeProvider.isDarkMode
                          ? Icons.light_mode
                          : Icons.dark_mode,
                    ),
                    onPressed: () => themeProvider.toggleTheme(),
                    tooltip:
                        themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  for (final section in _sectionKeys.keys)
                    ListTile(
                      title: Text(section),
                      selected: _activeSection == section,
                      leading: _getIconForSection(section),
                      onTap: () => _scrollToSection(section),
                    ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Download Resume'),
              leading: const Icon(Icons.download),
              onTap: () async {
                await downloadResume(context);
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

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
