import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../providers/firebase_provider.dart';

class DownloadCounterController extends GetxController {
  RxInt downloadCount = 0.obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;
  TextEditingController nmCtrl = TextEditingController();
  TextEditingController emCtrl = TextEditingController();
  TextEditingController nmCtrl1 = TextEditingController();
  TextEditingController emCtrl1 = TextEditingController();

  DownloadCounterProvider() {
    loadDownloadCount();
  }

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
      errorMessage.value = '';
      isLoading.value = false;
      update();
    }
  }

  void incrementDownloadCount() {
    downloadCount++;
    update();
  }
}
