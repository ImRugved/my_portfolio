import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../constants/portfolio_data.dart';
import '../../theme/theme_constants.dart';
import '../../utils/animation_utils.dart';
import '../../utils/responsive_utils.dart' as app_responsive;
import '../../utils/url_utils.dart';
import '../../widgets/common_widgets.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return SectionContainer(
      title: 'My Projects',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCategoryFilters(context),
                const SizedBox(height: 32),
                if (isMobile)
                  _buildProjectList(context, 2, _filteredProjects)
                else if (isTablet)
                  _buildProjectList(context, 2, _filteredProjects)
                else
                  _buildProjectList(context, 3, _filteredProjects)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectList(
      BuildContext context, int columns, List<Map<String, dynamic>> projects) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Calculate available width accounting for constraints and spacing
    double availableWidth = screenWidth > 1200 ? 1200 : screenWidth;

    // Adjust spacing for smaller screens
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final spacing = isMobile ? 8.0 : 24.0;

    // Calculate card widths with proper spacing
    double cardWidth;
    if (isMobile) {
      // For mobile, ensure cards fit properly with minimal spacing
      cardWidth = (availableWidth - (spacing * (columns + 1))) / columns;
    } else if (columns == 2) {
      cardWidth =
          (availableWidth - 72) / 2; // Account for spacing between 2 cards
    } else {
      cardWidth =
          (availableWidth - 96) / 3; // Account for spacing between 3 cards
    }

    return AnimationLimiter(
      child: Wrap(
        spacing: spacing,
        runSpacing: spacing,
        alignment: WrapAlignment.center,
        children: List.generate(projects.length, (index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: columns,
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: SizedBox(
                  width: cardWidth,
                  child: _buildProjectCard(context, projects[index]),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCategoryFilters(BuildContext context) {
    final categories = [
      {'id': 'all', 'name': 'All'},
      {'id': 'education', 'name': 'Education'},
      {'id': 'healthcare', 'name': 'Healthcare'},
      {'id': 'management', 'name': 'Management'},
      {'id': 'utility', 'name': 'Utility'},
    ];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: categories.map((category) {
            final isSelected = _selectedCategory == category['id'];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: FilterChip(
                showCheckmark: false,
                label: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  child: Text(
                    category['name'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    _selectedCategory = category['id'] as String;
                  });
                },
                backgroundColor: Theme.of(context).colorScheme.surface,
                selectedColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(
                    width: 1.5,
                    color: isSelected
                        ? Colors.transparent
                        : Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                  ),
                ),
              ).animate(effects: AnimationUtils.scaleIn),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final imageHeight =
        isMobile ? 150.0 : 200.0; // Smaller image height on mobile

    return InkWell(
      onTap: () => _showProjectDetailsDialog(context, project),
      borderRadius: BorderRadius.circular(24),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(isMobile ? 4 : 8), // Smaller margin on mobile
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Project Image with Overlay
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              child: Stack(
                children: [
                  project['assetImage'] != null
                      ? Image.asset(
                          project['assetImage'] as String,
                          height: imageHeight,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Container(
                              height: imageHeight,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: Center(
                                child: Icon(
                                  Icons.broken_image_rounded,
                                  color: Colors.grey[400],
                                  size: isMobile ? 30 : 50,
                                ),
                              ),
                            );
                          },
                        )
                      : Image.network(
                          project['image'] as String,
                          height: imageHeight,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: imageHeight,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            // Properly typed error handler
                            return Container(
                              height: imageHeight,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: Center(
                                child: Icon(
                                  Icons.broken_image_rounded,
                                  color: Colors.grey[400],
                                  size: isMobile ? 30 : 50,
                                ),
                              ),
                            );
                          },
                        ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          stops: const [0.6, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              project['title'] as String,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Tooltip(
                            message: 'View details',
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Project Info
            Padding(
              padding: EdgeInsets.all(isMobile ? 12 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: isMobile ? 50 : 60, // Smaller height on mobile
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            project['description'] as String,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  height: 1.4,
                                  color: ThemeConstants.textLight,
                                  fontSize: isMobile
                                      ? 12
                                      : 14, // Smaller font on mobile
                                ),
                            maxLines: isMobile ? 2 : 3, // Fewer lines on mobile
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          'Tap for more details',
                          style: TextStyle(
                            fontSize: isMobile ? 10 : 11,
                            color: Theme.of(context).colorScheme.primary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  // Technology tags
                  Wrap(
                    spacing: isMobile ? 4 : 6,
                    runSpacing: isMobile ? 4 : 6,
                    children: [
                      for (final tech
                          in project['technologies'] as List<dynamic>)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 8 : 10,
                              vertical: isMobile ? 4 : 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF007BFF),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            tech as String,
                            style: TextStyle(
                              fontSize: isMobile ? 10 : 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  // App store and action buttons
                  project['isDeployed'] == '1'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              spacing: isMobile ? 4 : 8,
                              children: [
                                if (project.containsKey('playStore'))
                                  InkWell(
                                    onTap: () {
                                      if (project['playStore'] != "") {
                                        UrlUtils.openUrl(
                                            project['playStore'] as String);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              'This app will be available on Google Play Store soon. Thank you for your patience.',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            backgroundColor:
                                                Colors.blue.shade800,
                                            duration:
                                                const Duration(seconds: 5),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            action: SnackBarAction(
                                              label: 'CLOSE',
                                              textColor: Colors.white,
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Tooltip(
                                      message: 'Play Store',
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          FontAwesomeIcons.googlePlay,
                                          size: 20,
                                          color: Colors.green[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                if (project.containsKey('appStore'))
                                  InkWell(
                                    onTap: () {
                                      if (project['appStore'] != "") {
                                        UrlUtils.openUrl(
                                            project['appStore'] as String);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              'This app will be available on App Store soon. Thank you for your patience.',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            backgroundColor:
                                                Colors.blue.shade800,
                                            duration:
                                                const Duration(seconds: 5),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            action: SnackBarAction(
                                              label: 'CLOSE',
                                              textColor: Colors.white,
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Tooltip(
                                      message: 'App Store',
                                      child: Container(
                                        padding:
                                            EdgeInsets.all(isMobile ? 6 : 8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          FontAwesomeIcons.appStore,
                                          size: isMobile ? 16 : 20,
                                          color: Colors.blue[700],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                if (project.containsKey('liveUrl') &&
                                    project['liveUrl'] != '#')
                                  InkWell(
                                    onTap: () {
                                      UrlUtils.openUrl(
                                          project['liveUrl'] as String);
                                    },
                                    child: Tooltip(
                                      message: 'View Project',
                                      child: Container(
                                        padding:
                                            EdgeInsets.all(isMobile ? 6 : 8),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          FontAwesomeIcons
                                              .arrowUpRightFromSquare,
                                          size: isMobile ? 14 : 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (project.containsKey('githubUrl'))
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: isMobile ? 4 : 8),
                                    child: InkWell(
                                      onTap: () {
                                        UrlUtils.openUrl(
                                            project['githubUrl'] as String);
                                      },
                                      child: Tooltip(
                                        message: 'Source Code',
                                        child: Container(
                                          padding:
                                              EdgeInsets.all(isMobile ? 6 : 8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[800],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            FontAwesomeIcons.github,
                                            size: isMobile ? 14 : 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            if (project['isDeployed'] != "0") {
                              UrlUtils.openUrl(project['driverLink'] as String);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'This app will be available on Google drive soon. Thank you for your patience.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  backgroundColor: Colors.blue.shade800,
                                  duration: const Duration(seconds: 5),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  action: SnackBarAction(
                                    label: 'CLOSE',
                                    textColor: Colors.white,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    },
                                  ),
                                ),
                              );
                            }
                          },
                          child: Tooltip(
                            message: 'Google Drive',
                            child: Container(
                              padding: EdgeInsets.all(isMobile ? 6 : 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                FontAwesomeIcons.googleDrive,
                                size: isMobile ? 16 : 20,
                                color: Colors.blue[700],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> get _filteredProjects {
    if (_selectedCategory == 'all') {
      return PortfolioData.projects;
    }
    return PortfolioData.projects.where((project) {
      return project['category'] == _selectedCategory;
    }).toList();
  }

  void _showProjectDetailsDialog(
      BuildContext context, Map<String, dynamic> project) {
    // Capture MediaQuery values early to avoid context issues after disposal
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width <
        768; // Manually determine instead of using ResponsiveBreakpoints
    final dialogWidth = isMobile ? screenSize.width * 0.95 : 600.0;
    final dialogHeight = screenSize.height * 0.85;

    showDialog(
      context: context,
      barrierDismissible: true, // Allow clicking outside to dismiss
      builder: (BuildContext dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: dialogWidth,
            maxHeight: dialogHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dialog header with close button
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    child: project['assetImage'] != null
                        ? Image.asset(
                            project['assetImage'] as String,
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                color: Colors.grey[200],
                                child: Center(
                                  child: Icon(
                                    Icons.broken_image_rounded,
                                    color: Colors.grey[400],
                                    size: 50,
                                  ),
                                ),
                              );
                            },
                          )
                        : Image.network(
                            project['image'] as String,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                color: Colors.grey[200],
                                child: Center(
                                  child: Icon(
                                    Icons.broken_image_rounded,
                                    color: Colors.grey[400],
                                    size: 50,
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  // Gradient overlay for image
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          stops: const [0.6, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Project title
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 56,
                    child: Text(
                      project['title'] as String,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Close button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        color: Colors.white,
                        onPressed: () => Navigator.of(dialogContext).pop(),
                      ),
                    ),
                  ),
                ],
              ),
              // Dialog content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full description
                      Text(
                        'Description',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project['description'] as String,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.6,
                              color: ThemeConstants.textLight,
                            ),
                      ),
                      const SizedBox(height: 24),

                      // Technologies used
                      Text(
                        'Technologies Used',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final tech
                              in project['technologies'] as List<dynamic>)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF007BFF),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                tech as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // App store links
                      if (project.containsKey('playStore') ||
                          project.containsKey('appStore'))
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available On',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            project['isDeployed'] == '1'
                                ? Row(
                                    children: [
                                      if (project.containsKey('playStore'))
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            if (project['playStore'] != "") {
                                              UrlUtils.openUrl(
                                                  project['playStore']
                                                      as String);
                                            }
                                            Navigator.of(dialogContext)
                                                .pop(); // Close dialog after action
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.googlePlay,
                                            size: isMobile ? 16 : 18,
                                          ),
                                          label: Text(
                                            'Play Store',
                                            style: TextStyle(
                                                fontSize: isMobile ? 12 : 16),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green[700],
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: isMobile ? 12 : 16,
                                                vertical: 12),
                                          ),
                                        ),
                                      const SizedBox(width: 12),
                                      if (project.containsKey('appStore'))
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            if (project['appStore'] != "") {
                                              UrlUtils.openUrl(
                                                  project['appStore']
                                                      as String);
                                            }
                                            Navigator.of(dialogContext)
                                                .pop(); // Close dialog after action
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.appStore,
                                            size: isMobile ? 16 : 20,
                                          ),
                                          label: Text(
                                            'App Store',
                                            style: TextStyle(
                                                fontSize: isMobile ? 12 : 16),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue[700],
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: isMobile ? 12 : 16,
                                                vertical: 12),
                                          ),
                                        ),
                                    ],
                                  )
                                : ElevatedButton.icon(
                                    onPressed: () {
                                      if (project['driverLink'] != "") {
                                        UrlUtils.openUrl(
                                            project['driverLink'] as String);
                                      }
                                      Navigator.of(dialogContext)
                                          .pop(); // Close dialog after action
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.googleDrive,
                                      size: isMobile ? 16 : 18,
                                    ),
                                    label: Text(
                                      'Google Drive',
                                      style: TextStyle(
                                          fontSize: isMobile ? 12 : 16),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[700],
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: isMobile ? 12 : 16,
                                          vertical: 12),
                                    ),
                                  ),
                          ],
                        ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
