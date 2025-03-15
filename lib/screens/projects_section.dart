import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/responsive_helper.dart';
import '../widgets/section_title.dart';

class ProjectsSection extends StatefulWidget {
  ProjectsSection({Key? key}) : super(key: key);

  @override
  _ProjectsSectionState createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedCategory = 'All';
  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'CoreText - Medical Updates',
      'description':
          'Medical news application delivering concise 60-word articles to healthcare professionals with personalized content delivery based on user-selected interests.',
      'imageUrl':
          'https://img.freepik.com/free-vector/medical-healthcare-blue-color_1017-26807.jpg',
      'tags': ['Flutter', 'Firebase', 'Web View', 'GetX'],
      'category': 'healthcare',
      'links': [
        {
          'icon': Icons.play_arrow,
          'title': 'Play Store - Coming Soon',
          'url': '#'
        }
      ]
    },
    {
      'title': 'Indrayani - Educational App',
      'description':
          'Educational app with timed multiple-choice exams, secure payment integration, and comprehensive exam functionality including timers and detailed scorecards.',
      'imageUrl':
          'https://img.freepik.com/free-vector/online-certification-illustration_23-2148575636.jpg',
      'tags': ['Flutter', 'Razorpay', 'Firebase'],
      'category': 'education',
      'links': [
        {'icon': Icons.visibility, 'title': 'View Details', 'url': '#'}
      ]
    },
    {
      'title': 'WorksJoy (HRMS)',
      'description':
          'Employee attendance and HR management system using Flutter and Firebase, boosting productivity by 35% with features like real-time punch-in/out and leave management.',
      'imageUrl':
          'https://img.freepik.com/free-vector/time-management-concept_23-2148810392.jpg',
      'tags': ['Flutter', 'Firebase', 'Location'],
      'category': 'management',
      'links': [
        {'icon': Icons.play_arrow, 'title': 'Play Store', 'url': '#'}
      ]
    },
    {
      'title': 'Nishchinta (Canteen Management)',
      'description':
          'Comprehensive canteen management system with dynamic menu management, real-time dashboards, and flexible ordering capabilities.',
      'imageUrl':
          'https://img.freepik.com/free-vector/canteen-concept-illustration_114360-7024.jpg',
      'tags': ['Flutter', 'Firebase', 'Real-time'],
      'category': 'management',
      'links': [
        {'icon': Icons.play_arrow, 'title': 'Play Store', 'url': '#'},
        {'icon': Icons.phone_iphone, 'title': 'App Store', 'url': '#'}
      ]
    },
    {
      'title': 'Parking Management App',
      'description':
          'Multi-platform parking management system with QR code vehicle tracking, reducing entry time by 30% and checkout times by 50%.',
      'imageUrl':
          'https://img.freepik.com/free-vector/parking-concept-illustration_114360-8671.jpg',
      'tags': ['Flutter', 'QR Code', 'Billing'],
      'category': 'utility',
      'links': [
        {'icon': Icons.visibility, 'title': 'View Details', 'url': '#'}
      ]
    },
    {
      'title': 'Alleviz Meeting',
      'description':
          'Flutter meeting app with secure authentication, scheduling capabilities, and collaborative tools for meeting creation with real-time notifications.',
      'imageUrl':
          'https://img.freepik.com/free-vector/video-conference-remote-working-flat-illustration_88138-414.jpg',
      'tags': ['Flutter', 'Real-time', 'Scheduling'],
      'category': 'utility',
      'links': [
        {'icon': Icons.play_arrow, 'title': 'Play Store', 'url': '#'}
      ]
    },
    {
      'title': 'Site Survey Application',
      'description':
          'Flutter site survey app with REST API integration, product catalog and PDF management using GetX and MVC patterns.',
      'imageUrl':
          'https://img.freepik.com/free-vector/survey-concept-illustration_114360-5624.jpg',
      'tags': ['Flutter', 'REST API', 'PDF'],
      'category': 'utility',
      'links': [
        {'icon': Icons.play_arrow, 'title': 'Play Store', 'url': '#'},
        {'icon': Icons.phone_iphone, 'title': 'App Store', 'url': '#'}
      ]
    },
  ];

  List<Map<String, dynamic>> get _filteredProjects {
    if (_selectedCategory == 'All') {
      return _projects;
    }
    return _projects
        .where(
            (project) => project['category'] == _selectedCategory.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: ResponsiveHelper.getScreenPadding(context),
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'My Projects'),
          const SizedBox(height: 24),
          _buildCategoryFilters(),
          const SizedBox(height: 32),
          _buildProjectsGrid(),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters() {
    final categories = [
      'All',
      'Healthcare',
      'Education',
      'Management',
      'Utility'
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color:
                        isSelected ? AppColors.primary : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProjectsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = ResponsiveHelper.isMobile(context);
        final crossAxisCount =
            isMobile ? 2 : (constraints.maxWidth > 900 ? 3 : 3);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: isMobile ? 0.9 : 0.85,
          ),
          itemCount: _filteredProjects.length,
          itemBuilder: (context, index) {
            final project = _filteredProjects[index];
            return _buildProjectCard(project);
          },
        );
      },
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  project['imageUrl'],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(
                        _getCategoryIcon(project['category']),
                        size: 50,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                        stops: const [0.7, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Row(
                    children: (project['links'] as List<Map<String, dynamic>>)
                        .map((link) {
                      return Container(
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(link['icon'] as IconData, size: 18),
                          color: AppColors.primary,
                          onPressed: () {
                            // Handle link tap
                          },
                          tooltip: link['title'],
                          constraints: const BoxConstraints(
                            minHeight: 36,
                            minWidth: 36,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'],
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getFontSize(context, 18),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project['description'],
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getFontSize(context, 14),
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: (project['tags'] as List<String>).map((tag) {
                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize:
                                    ResponsiveHelper.getFontSize(context, 12),
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'healthcare':
        return Icons.local_hospital;
      case 'education':
        return Icons.school;
      case 'management':
        return Icons.business;
      case 'utility':
        return Icons.build;
      default:
        return Icons.code;
    }
  }
}
