import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainViewModel extends GetxController {
  final PageController controller = PageController(initialPage: 0);
  final currentIndex = 0.obs;

  void onButtonNavTap(int index) {
    controller.jumpToPage(index);
    currentIndex(index);
  }
}
