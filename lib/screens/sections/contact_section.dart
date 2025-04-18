// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:rugved_portfolio_flutter/providers/firebase_provider.dart';
// import 'package:rugved_portfolio_flutter/screens/sections/download_counter.dart';
// import '../../constants/portfolio_data.dart';
// import '../../utils/animation_utils.dart';
// import '../../utils/responsive_utils.dart';
// import '../../utils/url_utils.dart';
// import '../../widgets/common_widgets.dart';
// // Import the Firebase provider

// class ContactSection extends StatefulWidget {
//   const ContactSection({super.key});

//   @override
//   State<ContactSection> createState() => _ContactSectionState();
// }

// class _ContactSectionState extends State<ContactSection> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _subjectController = TextEditingController();
//   final _messageController = TextEditingController();

//   // Loading state for the form submission
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _subjectController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       try {
//         // Submit form data to Firestore
//         await FirebaseProvider().submitContactForm(
//           name: _nameController.text,
//           email: _emailController.text,
//           subject: _subjectController.text,
//           message: _messageController.text,
//         );

//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Message sent successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );

//         // Clear the form
//         _nameController.clear();
//         _emailController.clear();
//         _subjectController.clear();
//         _messageController.clear();
//       } catch (e) {
//         // Show error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to send message: ${e.toString()}'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = ResponsiveUtils.isMobile(context);

//     return SectionContainer(
//       backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SectionTitle(
//             title: 'Get In Touch',
//             subtitle: 'Let\'s Connect and Create Something Amazing Together',
//             centerAlign: true,
//           ),
//           const SizedBox(height: 48),
//           if (isMobile)
//             Column(
//               children: [
//                 _buildContactForm(context),
//                 const SizedBox(height: 32),
//                 _buildContactInfo(context),
//                 const SizedBox(height: 32),
//                 _buildSocialLinks(context),
//               ],
//             )
//           else
//             Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       flex: 6,
//                       child: _buildContactForm(context),
//                     ),
//                     const SizedBox(width: 48),
//                     Expanded(
//                       flex: 4,
//                       child: Column(
//                         children: [
//                           _buildContactInfo(context),
//                           const SizedBox(height: 32),
//                           _buildSocialLinks(context),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           const SizedBox(height: 48),
//           CustomButton(
//             text: 'See Resume',
//             // onPressed: () async {
//             //   try {
//             //     // Track resume download in Firestore
//             //     // await FirebaseProvider().trackResumeDownload().whenComplete(
//             //     //   () {
//             //     //     UrlUtils.openPdf('assets/resume/resume.pdf');
//             //     //   },
//             //     // );
//             //     UrlUtils.openPdf('assets/resume/resume.pdf');
//             //   } catch (e) {
//             //     print('Failed to track resume download: $e');
//             //     // Continue with download even if tracking fails
//             //   }

//             //   // Open the PDF
//             // },
//             onPressed: () async {
//               try {
//                 // Show loading indicator
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Preparing resume...'),
//                     duration: Duration(seconds: 1),
//                   ),
//                 );

//                 // Track resume download in Firestore
//                 await FirebaseProvider().trackResumeDownload();

//                 // Open the PDF
//                 await UrlUtils.openPdf('assets/resume/resume.pdf');
//               } catch (e) {
//                 // Show error message if opening fails
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Failed to open resume: ${e.toString()}'),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//                 print('Failed to open resume: $e');
//               }
//             },
//             icon: Icons.visibility_outlined,
//             color: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContactForm(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Send Me a Message',
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//               ).animate(effects: AnimationUtils.fadeSlideUp),
//               const SizedBox(height: 24),
//               _buildTextField(
//                 controller: _nameController,
//                 hintText: 'Your Name',
//                 prefixIcon: Icons.person_outline,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 controller: _emailController,
//                 hintText: 'Your Email',
//                 prefixIcon: Icons.email_outlined,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                       .hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 controller: _subjectController,
//                 hintText: 'Subject',
//                 prefixIcon: Icons.subject,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a subject';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 controller: _messageController,
//                 hintText: 'Your Message',
//                 prefixIcon: Icons.message_outlined,
//                 maxLines: 5,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your message';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _isLoading ? null : _submitForm,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).colorScheme.primary,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     elevation: 2,
//                   ),
//                   child: _isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text(
//                           'Send Message',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ).animate(effects: AnimationUtils.fadeIn);
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     required IconData prefixIcon,
//     required String? Function(String?) validator,
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//   }) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: TextStyle(
//           color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
//         ),
//         prefixIcon: Icon(
//           prefixIcon,
//           color: isDarkMode ? Colors.grey[400] : null,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.primary,
//             width: 2,
//           ),
//         ),
//         filled: true,
//         fillColor: isDarkMode
//             ? Theme.of(context).inputDecorationTheme.fillColor ??
//                 Theme.of(context).cardColor
//             : Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       ),
//       style: TextStyle(
//         color: Theme.of(context).textTheme.bodyLarge?.color,
//       ),
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       validator: validator,
//     );
//   }

//   Widget _buildContactInfo(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           'Contact Information',
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//         ).animate(effects: AnimationUtils.fadeSlideUp),
//         const SizedBox(height: 24),
//         _buildContactItem(
//           context,
//           icon: Icons.email,
//           title: 'Email',
//           value: PortfolioData.email,
//           onTap: () => UrlUtils.sendEmail(
//             PortfolioData.email,
//             subject: 'Hello from Portfolio',
//           ),
//         ),
//         const SizedBox(height: 16),
//         _buildContactItem(
//           context,
//           icon: Icons.phone,
//           title: 'Phone',
//           value: PortfolioData.phone,
//           onTap: () => UrlUtils.makePhoneCall(PortfolioData.phone),
//         ),
//         const SizedBox(height: 16),
//         _buildContactItem(
//           context,
//           icon: Icons.location_on,
//           title: 'Location',
//           value: PortfolioData.location,
//           onTap: () => UrlUtils.openMap(PortfolioData.location),
//         ),
//       ],
//     );
//   }

//   Widget _buildContactItem(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required String value,
//     required VoidCallback onTap,
//   }) {
//     return Card(
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Icon(
//                 icon,
//                 color: Theme.of(context).colorScheme.primary,
//                 size: ResponsiveUtils.getIconSize(context, 24),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                             color: Theme.of(context).textTheme.bodySmall?.color,
//                           ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       value,
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_forward_ios,
//                 size: ResponsiveUtils.getIconSize(context, 16),
//                 color: Theme.of(context).textTheme.bodySmall?.color,
//               ),
//             ],
//           ),
//         ),
//       ),
//     ).animate(effects: AnimationUtils.fadeSlideUp);
//   }

//   Widget _buildSocialLinks(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           'Social Links',
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//         ).animate(effects: AnimationUtils.fadeSlideUp),
//         const SizedBox(height: 24),
//         Wrap(
//           spacing: 16,
//           runSpacing: 16,
//           alignment: WrapAlignment.center,
//           children: [
//             for (final social in PortfolioData.socialLinks)
//               SocialIcon(
//                 platform: social['name'] as String,
//                 url: social['url'] as String,
//                 size: ResponsiveUtils.getIconSize(context, 32),
//               ),
//           ],
//         ),
//       ],
//     );
//   }
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rugved_portfolio_flutter/providers/count_controller.dart';
import 'package:rugved_portfolio_flutter/providers/downloadCount_provider.dart';
import 'package:rugved_portfolio_flutter/providers/firebase_provider.dart';
import 'package:rugved_portfolio_flutter/screens/sections/download_counter.dart';
import '../../constants/portfolio_data.dart';
import '../../utils/animation_utils.dart';
import '../../utils/responsive_utils.dart';
import '../../utils/url_utils.dart';
import '../../widgets/common_widgets.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  // Loading state for the form submission
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Submit form data to Firestore
        await FirebaseProvider().submitContactForm(
          name: _nameController.text,
          email: _emailController.text,
          subject: _subjectController.text,
          message: _messageController.text,
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear the form
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void showResumeDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

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
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text.trim();
                  String email = emailController.text.trim();
                  if (name.isNotEmpty && email.isNotEmpty) {
                    // TODO: Handle download logic here
                    await FirebaseProvider().resumeDownloadMessage(
                      name: _nameController.text,
                      email: _emailController.text,
                    );

                    Navigator.of(context).pop();
                    // Close the dialog
                    // Optional: Show snackbar or toast
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
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return SectionContainer(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            title: 'Get In Touch',
            subtitle: 'Let\'s Connect and Create Something Amazing Together',
            centerAlign: true,
          ),
          const SizedBox(height: 48),
          if (isMobile)
            Column(
              children: [
                _buildContactForm(context),
                const SizedBox(height: 32),
                _buildContactInfo(context),
                const SizedBox(height: 32),
                _buildSocialLinks(context),
              ],
            )
          else
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildContactForm(context),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          _buildContactInfo(context),
                          const SizedBox(height: 32),
                          _buildSocialLinks(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 48),

          // ChangeNotifierProvider(
          //   create: (_) => DownloadCounterProvider(),
          //   child: Column(
          //     children: [
          //       Consumer<DownloadCounterProvider>(
          //         builder: (context, downloadProvider, child) {
          //           return CustomButton(
          //             text: 'See Resume',
          //             onPressed: () async {
          //               try {
          //                 // Show loading indicator
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   const SnackBar(
          //                     content: Text('Preparing resume...'),
          //                     duration: Duration(seconds: 1),
          //                   ),
          //                 );

          //                 // Track resume download in Firestore
          //                 await FirebaseProvider().trackResumeDownload();

          //                 // Refresh the counter after tracking the download
          //                 downloadProvider.loadDownloadCount();

          //                 // Open the PDF
          //                 await UrlUtils.openPdf('assets/resume/resume.pdf');
          //               } catch (e) {
          //                 // Show error message if opening fails
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   SnackBar(
          //                     content: Text(
          //                         'Failed to open resume: ${e.toString()}'),
          //                     backgroundColor: Colors.red,
          //                   ),
          //                 );
          //                 print('Failed to open resume: $e');
          //               }
          //             },
          //             icon: Icons.visibility_outlined,
          //             color: Colors.white,
          //           );
          //         },
          //       ),
          //       // The DownloadCounter widget will be able to access the provider
          //       const DownloadCounter(),
          //     ],
          //   ),
          // ),
          Column(
            children: [
              GetBuilder(
                init: DownloadCounterController(),
                builder: (downloadProvider) {
                  return CustomButton(
                    text: 'See Resume',
                    onPressed: () async {
                      try {
                        // Show loading indicator
                        //   showResumeDialog(context);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              title: const Text(
                                'Enter your name and email to download resume',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: downloadProvider.nmCtrl,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: downloadProvider.emCtrl,
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () async {
                                      String name =
                                          downloadProvider.nmCtrl.text.trim();
                                      String email =
                                          downloadProvider.emCtrl.text.trim();
                                      if (name != '' && email != '') {
                                        // TODO: Handle download logic here
                                        await FirebaseProvider()
                                            .resumeDownloadMessage(
                                          name: name,
                                          email: email,
                                        );

                                        Navigator.of(context).pop();
                                        // Close the dialog
                                        // Optional: Show snackbar or toast
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Preparing resume...'),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );

                                        await FirebaseProvider()
                                            .trackResumeDownload();

                                        downloadProvider.loadDownloadCount();

                                        await UrlUtils.openPdf(
                                            'assets/resume/resume.pdf');
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
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
                                    child: const Text('Submit'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        //..........................................
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text('Preparing resume...'),
                        //     duration: Duration(seconds: 1),
                        //   ),
                        // );

                        // await FirebaseProvider().trackResumeDownload();

                        // downloadProvider.loadDownloadCount();

                        // await UrlUtils.openPdf('assets/resume/resume.pdf');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Failed to open resume: ${e.toString()}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        print('Failed to open resume: $e');
                      }
                    },
                    icon: Icons.visibility_outlined,
                    color: Colors.white,
                  );
                },
              ),
              const DownloadCounter(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send Me a Message',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ).animate(effects: AnimationUtils.fadeSlideUp),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _nameController,
                hintText: 'Your Name',
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                hintText: 'Your Email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _subjectController,
                hintText: 'Subject',
                prefixIcon: Icons.subject,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _messageController,
                hintText: 'Your Message',
                prefixIcon: Icons.message_outlined,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Send Message',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate(effects: AnimationUtils.fadeIn);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: isDarkMode ? Colors.grey[400] : null,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: isDarkMode
            ? Theme.of(context).inputDecorationTheme.fillColor ??
                Theme.of(context).cardColor
            : Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Contact Information',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ).animate(effects: AnimationUtils.fadeSlideUp),
        const SizedBox(height: 24),
        _buildContactItem(
          context,
          icon: Icons.email,
          title: 'Email',
          value: PortfolioData.email,
          onTap: () => UrlUtils.sendEmail(
            PortfolioData.email,
            subject: 'Hello from Portfolio',
          ),
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          context,
          icon: Icons.phone,
          title: 'Phone',
          value: PortfolioData.phone,
          onTap: () => UrlUtils.makePhoneCall(PortfolioData.phone),
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          context,
          icon: Icons.location_on,
          title: 'Location',
          value: PortfolioData.location,
          onTap: () => UrlUtils.openMap(PortfolioData.location),
        ),
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: ResponsiveUtils.getIconSize(context, 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: ResponsiveUtils.getIconSize(context, 16),
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ],
          ),
        ),
      ),
    ).animate(effects: AnimationUtils.fadeSlideUp);
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Social Links',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ).animate(effects: AnimationUtils.fadeSlideUp),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            for (final social in PortfolioData.socialLinks)
              SocialIcon(
                platform: social['name'] as String,
                url: social['url'] as String,
                size: ResponsiveUtils.getIconSize(context, 32),
              ),
          ],
        ),
      ],
    );
  }
}
