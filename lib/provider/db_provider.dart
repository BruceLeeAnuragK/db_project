import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MypageController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();
  int get getIndex {
    return currentIndex.value;
  }

  void onChanged({required int index}) {
    currentIndex = index.obs;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }
}
