// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:responsive_framework/responsive_framework.dart';
// import '../../constants/portfolio_data.dart';
// import '../../theme/theme_constants.dart';
// import '../../utils/animation_utils.dart';
// import '../../utils/responsive_utils.dart' as app_responsive;
// import '../../utils/url_utils.dart';
// import '../../widgets/common_widgets.dart';
// import '../../utils/scroll_utils.dart';

// class HeroSection extends StatelessWidget {
//   const HeroSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = ResponsiveBreakpoints.of(context).isMobile;
//     final isTablet = ResponsiveBreakpoints.of(context).isTablet;

//     // Set the context in the UrlUtils for scrolling
//     UrlUtils.setContext(context);

//     return SectionContainer(
//       backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 40),
//         child: ResponsiveRowColumn(
//           rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
//           rowCrossAxisAlignment: CrossAxisAlignment.center,
//           columnCrossAxisAlignment: CrossAxisAlignment.center,
//           layout: isMobile
//               ? ResponsiveRowColumnType.COLUMN
//               : ResponsiveRowColumnType.ROW,
//           children: [
//             ResponsiveRowColumnItem(
//               rowFlex: 6,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: isMobile
//                     ? CrossAxisAlignment.center
//                     : CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Hi, I\'m',
//                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                           color: Theme.of(context).colorScheme.primary,
//                           fontWeight: FontWeight.bold,
//                           fontSize: app_responsive.ResponsiveUtils.getFontSize(
//                               context, 24),
//                         ),
//                     textAlign: isMobile ? TextAlign.center : TextAlign.start,
//                   ).animate(effects: AnimationUtils.fadeSlideUp),
//                   const SizedBox(height: 8),
//                   Text(
//                     PortfolioData.name2,
//                     style: Theme.of(context).textTheme.displayLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           fontSize: app_responsive.ResponsiveUtils.getFontSize(
//                               context, 48),
//                         ),
//                     textAlign: isMobile ? TextAlign.center : TextAlign.start,
//                   ).animate(effects: AnimationUtils.fadeSlideUp),
//                   const SizedBox(height: 16),
//                   DefaultTextStyle(
//                     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                           color: Theme.of(context).colorScheme.secondary,
//                           fontSize: app_responsive.ResponsiveUtils.getFontSize(
//                               context, 32),
//                         ),
//                     textAlign: isMobile ? TextAlign.center : TextAlign.start,
//                     child: AnimatedTextKit(
//                       animatedTexts: PortfolioData.roles.map((role) {
//                         return TypewriterAnimatedText(
//                           role,
//                           speed: const Duration(milliseconds: 100),
//                           cursor: '_',
//                           textAlign:
//                               isMobile ? TextAlign.center : TextAlign.start,
//                         );
//                       }).toList(),
//                       repeatForever: true,
//                       pause: const Duration(seconds: 2),
//                       isRepeatingAnimation: true,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     PortfolioData.about,
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                           fontSize: app_responsive.ResponsiveUtils.getFontSize(
//                               context, 16),
//                           height: 1.6,
//                           color: ThemeConstants.textLight,
//                         ),
//                     textAlign: isMobile ? TextAlign.center : TextAlign.start,
//                   ).animate(effects: AnimationUtils.fadeSlideUp),
//                   const SizedBox(height: 32),
//                   Wrap(
//                     spacing: 16,
//                     runSpacing: 16,
//                     alignment:
//                         isMobile ? WrapAlignment.center : WrapAlignment.start,
//                     children: [
//                       CustomButton(
//                         text: 'Hire Me',
//                         onPressed: () => UrlUtils.sendEmail(
//                           PortfolioData.email,
//                           subject: 'Job Opportunity for ${PortfolioData.name2}',
//                           body:
//                               'Hello ${PortfolioData.name2},\n\nI am interested in hiring you for a project. Let\'s discuss further.\n\nRegards,',
//                         ),
//                         icon: Icons.person_add,
//                         color: Colors.white,
//                       ),
//                       CustomButton(
//                         text: 'View Projects',
//                         onPressed: () {
//                           // Use direct notification dispatch to ensure reliable scrolling
//                           ScrollToSectionNotification.scrollTo(
//                               context, 'Projects');
//                         },
//                         isOutlined: true,
//                         icon: Icons.work,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 32),
//                   Wrap(
//                     spacing: 16,
//                     runSpacing: 16,
//                     alignment:
//                         isMobile ? WrapAlignment.center : WrapAlignment.start,
//                     children: [
//                       for (final social in PortfolioData.socialLinks)
//                         SocialIcon(
//                           platform: social['name'] as String,
//                           url: social['url'] as String,
//                           size: app_responsive.ResponsiveUtils.getIconSize(
//                               context, 24),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             ResponsiveRowColumnItem(
//               rowFlex: 5,
//               child: Container(
//                 margin: EdgeInsets.only(top: isMobile ? 40 : 0),
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Background blur circle - larger than the image
//                     Container(
//                       width: (isMobile
//                               ? MediaQuery.of(context).size.width * 0.4
//                               : isTablet
//                                   ? 350
//                                   : 450) +
//                           12, // Smaller offset for mobile
//                       height: (isMobile
//                               ? MediaQuery.of(context).size.width * 0.4
//                               : isTablet
//                                   ? 350
//                                   : 450) +
//                           12, // Smaller offset for mobile
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.transparent,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Theme.of(context)
//                                 .colorScheme
//                                 .primary
//                                 .withOpacity(0.1),
//                             blurRadius: 20, // Reduced blur
//                             spreadRadius: 5, // Reduced spread
//                           ),
//                         ],
//                       ),
//                     ).animate(
//                       onPlay: (controller) => controller.repeat(reverse: true),
//                       effects: [
//                         ScaleEffect(
//                           begin: const Offset(1, 1),
//                           end: const Offset(1.05, 1.05),
//                           duration: const Duration(seconds: 4),
//                           curve: Curves.easeInOut,
//                         ),
//                       ],
//                     ),

//                     // Main image container with enhanced shadow effect
//                     Container(
//                       width: isMobile
//                           ? MediaQuery.of(context).size.width *
//                               0.4 // 40% of screen width for very small screens
//                           : isTablet
//                               ? 350
//                               : 450,
//                       height: isMobile
//                           ? MediaQuery.of(context).size.width *
//                               0.4 // Keep aspect ratio 1:1
//                           : isTablet
//                               ? 350
//                               : 450,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           // Inner shadow
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             blurRadius: 15,
//                             spreadRadius: 1,
//                           ),
//                           // Outer glow
//                           BoxShadow(
//                             color: Theme.of(context)
//                                 .colorScheme
//                                 .primary
//                                 .withOpacity(0.3),
//                             blurRadius: 12,
//                             spreadRadius: 0,
//                           ),
//                         ],
//                       ),
//                       child: ClipOval(
//                         child: Image.asset(
//                           'assets/images/profile.png',
//                           fit: BoxFit.cover,
//                           errorBuilder: (BuildContext context, Object error,
//                               StackTrace? stackTrace) {
//                             // Properly typed error handler
//                             return Container(
//                               color: Colors.grey[300],
//                               child: Icon(
//                                 Icons.person,
//                                 size: isMobile ? 50 : 150,
//                                 color: Colors.grey[600],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ).animate(
//                       onPlay: (controller) => controller.repeat(reverse: true),
//                       effects: [
//                         MoveEffect(
//                           begin: const Offset(0, 0),
//                           end: const Offset(0, -5),
//                           duration: const Duration(seconds: 3),
//                           curve: Curves.easeInOut,
//                         ),
//                       ],
//                     ),

//                     // Outline highlight circle
//                     Container(
//                       width: (isMobile
//                               ? MediaQuery.of(context).size.width * 0.4
//                               : isTablet
//                                   ? 350
//                                   : 450) +
//                           8, // Smaller offset for mobile
//                       height: (isMobile
//                               ? MediaQuery.of(context).size.width * 0.4
//                               : isTablet
//                                   ? 350
//                                   : 450) +
//                           8, // Smaller offset for mobile
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Theme.of(context)
//                               .colorScheme
//                               .primary
//                               .withOpacity(0.2),
//                           width: 1.5, // Thinner border for mobile
//                         ),
//                       ),
//                     ).animate(
//                       onPlay: (controller) => controller.repeat(reverse: true),
//                       effects: [
//                         ScaleEffect(
//                           begin: const Offset(1, 1),
//                           end: const Offset(1.03, 1.03),
//                           duration: const Duration(seconds: 2),
//                           curve: Curves.easeInOut,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ).animate(effects: AnimationUtils.fadeSlideRight),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/portfolio_data.dart';
import '../../theme/theme_constants.dart';
import '../../utils/animation_utils.dart';
import '../../utils/responsive_utils.dart' as app_responsive;
import '../../utils/url_utils.dart';
import '../../widgets/common_widgets.dart';
import '../../utils/scroll_utils.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    // Set the context in the UrlUtils for scrolling
    UrlUtils.setContext(context);

    return Stack(
      children: [
        // Main Content
        SectionContainer(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: ResponsiveRowColumn(
              rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
              rowCrossAxisAlignment: CrossAxisAlignment.center,
              columnCrossAxisAlignment: CrossAxisAlignment.center,
              layout: isMobile
                  ? ResponsiveRowColumnType.COLUMN
                  : ResponsiveRowColumnType.ROW,
              children: [
                ResponsiveRowColumnItem(
                  rowFlex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, I\'m',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  app_responsive.ResponsiveUtils.getFontSize(
                                      context, 24),
                            ),
                        textAlign:
                            isMobile ? TextAlign.center : TextAlign.start,
                      ).animate(effects: AnimationUtils.fadeSlideUp),
                      const SizedBox(height: 8),
                      Text(
                        PortfolioData.name2,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  app_responsive.ResponsiveUtils.getFontSize(
                                      context, 48),
                            ),
                        textAlign:
                            isMobile ? TextAlign.center : TextAlign.start,
                      ).animate(effects: AnimationUtils.fadeSlideUp),
                      const SizedBox(height: 16),
                      DefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize:
                                  app_responsive.ResponsiveUtils.getFontSize(
                                      context, 32),
                            ),
                        textAlign:
                            isMobile ? TextAlign.center : TextAlign.start,
                        child: AnimatedTextKit(
                          animatedTexts: PortfolioData.roles.map((role) {
                            return TypewriterAnimatedText(
                              role,
                              speed: const Duration(milliseconds: 100),
                              cursor: '_',
                              textAlign:
                                  isMobile ? TextAlign.center : TextAlign.start,
                            );
                          }).toList(),
                          repeatForever: true,
                          pause: const Duration(seconds: 2),
                          isRepeatingAnimation: true,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        PortfolioData.about,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize:
                                  app_responsive.ResponsiveUtils.getFontSize(
                                      context, 16),
                              height: 1.6,
                              color: ThemeConstants.textLight,
                            ),
                        textAlign:
                            isMobile ? TextAlign.center : TextAlign.start,
                      ).animate(effects: AnimationUtils.fadeSlideUp),
                      const SizedBox(height: 32),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: isMobile
                            ? WrapAlignment.center
                            : WrapAlignment.start,
                        children: [
                          CustomButton(
                            text: 'Hire Me',
                            onPressed: () => UrlUtils.sendEmail(
                              PortfolioData.email,
                              subject:
                                  'Job Opportunity for ${PortfolioData.name2}',
                              body:
                                  'Hello ${PortfolioData.name2},\n\nI am interested in hiring you for a project. Let\'s discuss further.\n\nRegards,',
                            ),
                            icon: Icons.person_add,
                            color: Colors.white,
                          ),
                          CustomButton(
                            text: 'View Projects',
                            onPressed: () {
                              // Use direct notification dispatch to ensure reliable scrolling
                              ScrollToSectionNotification.scrollTo(
                                  context, 'Projects');
                            },
                            isOutlined: true,
                            icon: Icons.work,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: isMobile
                            ? WrapAlignment.center
                            : WrapAlignment.start,
                        children: [
                          for (final social in PortfolioData.socialLinks)
                            SocialIcon(
                              platform: social['name'] as String,
                              url: social['url'] as String,
                              size: app_responsive.ResponsiveUtils.getIconSize(
                                  context, 24),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                ResponsiveRowColumnItem(
                  rowFlex: 5,
                  child: Container(
                    margin: EdgeInsets.only(top: isMobile ? 40 : 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background blur circle - larger than the image
                        Container(
                          width: (isMobile
                                  ? MediaQuery.of(context).size.width * 0.4
                                  : isTablet
                                      ? 350
                                      : 450) +
                              12, // Smaller offset for mobile
                          height: (isMobile
                                  ? MediaQuery.of(context).size.width * 0.4
                                  : isTablet
                                      ? 350
                                      : 450) +
                              12, // Smaller offset for mobile
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                blurRadius: 20, // Reduced blur
                                spreadRadius: 5, // Reduced spread
                              ),
                            ],
                          ),
                        ).animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                          effects: [
                            const ScaleEffect(
                              begin: Offset(1, 1),
                              end: Offset(1.05, 1.05),
                              duration: Duration(seconds: 4),
                              curve: Curves.easeInOut,
                            ),
                          ],
                        ),

                        // Main image container with enhanced shadow effect
                        Container(
                          width: isMobile
                              ? MediaQuery.of(context).size.width *
                                  0.4 // 40% of screen width for very small screens
                              : isTablet
                                  ? 350
                                  : 450,
                          height: isMobile
                              ? MediaQuery.of(context).size.width *
                                  0.4 // Keep aspect ratio 1:1
                              : isTablet
                                  ? 350
                                  : 450,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              // Inner shadow
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                              // Outer glow
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.3),
                                blurRadius: 12,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/profile.png',
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                // Properly typed error handler
                                return Container(
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.person,
                                    size: isMobile ? 50 : 150,
                                    color: Colors.grey[600],
                                  ),
                                );
                              },
                            ),
                          ),
                        ).animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                          effects: [
                            const MoveEffect(
                              begin: Offset(0, 0),
                              end: Offset(0, -5),
                              duration: Duration(seconds: 3),
                              curve: Curves.easeInOut,
                            ),
                          ],
                        ),

                        // Outline highlight circle
                        Container(
                          width: (isMobile
                                  ? MediaQuery.of(context).size.width * 0.4
                                  : isTablet
                                      ? 350
                                      : 450) +
                              8, // Smaller offset for mobile
                          height: (isMobile
                                  ? MediaQuery.of(context).size.width * 0.4
                                  : isTablet
                                      ? 350
                                      : 450) +
                              8, // Smaller offset for mobile
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              width: 1.5, // Thinner border for mobile
                            ),
                          ),
                        ).animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                          effects: [
                            const ScaleEffect(
                              begin: Offset(1, 1),
                              end: Offset(1.03, 1.03),
                              duration: Duration(seconds: 2),
                              curve: Curves.easeInOut,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate(effects: AnimationUtils.fadeSlideRight),
                ),
              ],
            ),
          ),
        ),

        // Development Banner - positioned at the top
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: DefaultTextStyle(
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize:
                      app_responsive.ResponsiveUtils.getFontSize(context, 14),
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText(
                      '🚧 Portfolio Under Development 🚧',
                      duration: const Duration(seconds: 2),
                    ),
                    FadeAnimatedText(
                      '🔨 Working on exciting new features! 🔨',
                      duration: const Duration(seconds: 2),
                    ),
                    FadeAnimatedText(
                      '📅 Coming Soon - Stay Tuned! 📅',
                      duration: const Duration(seconds: 2),
                    ),
                  ],
                  repeatForever: true,
                  isRepeatingAnimation: true,
                ),
              ),
            ),
          ).animate(
            onPlay: (controller) => controller.repeat(reverse: true),
            effects: [
              const ScaleEffect(
                begin: Offset(1, 1),
                end: Offset(1.05, 1.05),
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
              ),
              const FadeEffect(
                begin: 0.8,
                end: 1.0,
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
