import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/responsive_helper.dart';

class SkillTag extends StatelessWidget {
  final String text;

  const SkillTag({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: ResponsiveHelper.getFontSize(context, 14),
        ),
      ),
    );
  }
}
