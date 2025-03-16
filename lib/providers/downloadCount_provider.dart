import 'dart:developer';

import 'package:flutter/foundation.dart';
import '../providers/firebase_provider.dart';

class DownloadCounterProvider extends ChangeNotifier {
  int _downloadCount = 0;
  bool _isLoading = true;
  String _errorMessage = '';

  // Getters
  int get downloadCount => _downloadCount;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Constructor - Load data on initialization
  DownloadCounterProvider() {
    loadDownloadCount();
  }

  // Load download count from Firestore
  Future<void> loadDownloadCount() async {
    try {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();

      final count = await FirebaseProvider().getResumeDownloadCount();
      log('in load downoad count $count');
      _downloadCount = count;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error loading download count: $e');
      _errorMessage = ''; // Keeping this empty to avoid showing error to users
      _isLoading = false;
      notifyListeners();
    }
  }

  // Increment count (used when a new download happens)
  void incrementDownloadCount() {
    _downloadCount++;
    notifyListeners();
  }
}
