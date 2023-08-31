import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../provider/db_provider.dart';
import '../../provider/transcationController.dart';
import '../components/category.dart';
import '../components/transaction.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  MypageController controller = Get.put(MypageController());
  TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget App"),
        centerTitle: true,
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          if (index == 1) {
            transactionController.init();
          }
        },
        children: [
          Categories(),
          TransactionComponent(),
          TransactionComponent(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.onChanged(index: index);
            if (index == 1) {
              transactionController.init();
            }
          },
          currentIndex: controller.getIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "Category",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "All Transactions",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
          ],
        ),
      ),
    );
  }
}
