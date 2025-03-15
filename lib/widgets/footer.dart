import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      color: Colors.grey[800],
      child: Center(
        child: Text(
          '© 2025 Rugved. All rights reserved.',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
