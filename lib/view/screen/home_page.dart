import 'package:db_project/components/category.dart';
import 'package:db_project/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  MypageController myPageController = Get.put(MypageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Base"),
        centerTitle: true,
      ),
      body: PageView(
        controller: myPageController.pageController,
        children: [Categories()],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: myPageController.getIndex,
          onTap: (index) {
            myPageController.onChanged(index: index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: "Call",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
