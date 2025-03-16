import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../providers/firebase_provider.dart';

class DownloadCounterController extends GetxController {
  RxInt downloadCount = 0.obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  // Getters

  // Constructor - Load data on initialization
  DownloadCounterProvider() {
    loadDownloadCount();
  }

  // Load download count from Firestore
  Future<void> loadDownloadCount() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      update();

      final count = await FirebaseProvider().getResumeDownloadCount();
      log('in load downoad count $count');
      downloadCount.value = count;
      isLoading.value = false;
      update();
    } catch (e) {
      print('Error loading download count: $e');
      errorMessage.value =
          ''; // Keeping this empty to avoid showing error to users
      isLoading.value = false;
      update();
    }
  }

  // Increment count (used when a new download happens)
  void incrementDownloadCount() {
    downloadCount++;
    update();
  }
}
