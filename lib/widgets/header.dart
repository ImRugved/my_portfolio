import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:flutter/widgets.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      color: AppColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Rugved Portfolio',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              _buildNavButton(context, 'Home', () { /* Navigate to Home */ }),
              _buildNavButton(context, 'About', () { /* Navigate to About */ }),
              _buildNavButton(context, 'Projects', () { /* Navigate to Projects */ }),
              _buildNavButton(context, 'Experience', () { /* Navigate to Experience */ }),
              _buildNavButton(context, 'Contact', () { /* Navigate to Contact */ }),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Add functionality for download resume
            },
            child: Text('Download Resume'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
