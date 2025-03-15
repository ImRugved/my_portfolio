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
                  _buildProjectList(context, 1, _filteredProjects)
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
    // Calculate card widths with proper spacing
    double cardWidth = columns == 1
        ? 320
        : columns == 2
            ? (availableWidth - 72) / 2 // Account for spacing between 2 cards
            : (availableWidth - 96) / 3; // Account for spacing between 3 cards

    return AnimationLimiter(
      child: Wrap(
        spacing: 24,
        runSpacing: 24,
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: categories.map((category) {
            final isSelected = _selectedCategory == category['id'];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FilterChip(
                showCheckmark: false,
                label: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  borderRadius: BorderRadius.circular(30),
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
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Project Image with Overlay
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Stack(
              children: [
                Image.network(
                  project['image'] as String,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
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
                    child: Text(
                      project['title'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                ),
              ],
            ),
          ),
          // Project Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 60,
                  child: Text(
                    project['description'] as String,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                          color: ThemeConstants.textLight,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 16),
                // Technology tags
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final tech in project['technologies'] as List<dynamic>)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          tech as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                // App store and action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: [
                        if (project.containsKey('playStore'))
                          InkWell(
                            onTap: () {
                              UrlUtils.openUrl(project['playStore'] as String);
                            },
                            child: Tooltip(
                              message: 'Play Store',
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
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
                              UrlUtils.openUrl(project['appStore'] as String);
                            },
                            child: Tooltip(
                              message: 'App Store',
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.appStore,
                                  size: 20,
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
                              UrlUtils.openUrl(project['liveUrl'] as String);
                            },
                            child: Tooltip(
                              message: 'View Project',
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.arrowUpRightFromSquare,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        if (project.containsKey('githubUrl'))
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: InkWell(
                              onTap: () {
                                UrlUtils.openUrl(
                                    project['githubUrl'] as String);
                              },
                              child: Tooltip(
                                message: 'Source Code',
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.github,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
}
