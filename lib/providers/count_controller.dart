import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../providers/firebase_provider.dart';

class DownloadCounterController extends GetxController {
  RxInt _downloadCount = 0.obs;
  RxBool _isLoading = true.obs;
  RxString _errorMessage = ''.obs;

  // Getters
  int get downloadCount => _downloadCount.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  // Constructor - Load data on initialization
  DownloadCounterProvider() {
    loadDownloadCount();
  }

  // Load download count from Firestore
  Future<void> loadDownloadCount() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      update();

      final count = await FirebaseProvider().getResumeDownloadCount();
      log('in load downoad count $count');
      _downloadCount.value = count;
      _isLoading.value = false;
      update();
    } catch (e) {
      print('Error loading download count: $e');
      _errorMessage.value =
          ''; // Keeping this empty to avoid showing error to users
      _isLoading.value = false;
      update();
    }
  }

  // Increment count (used when a new download happens)
  void incrementDownloadCount() {
    _downloadCount++;
    update();
  }
}
