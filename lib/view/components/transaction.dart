import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/transaction_model.dart';
import '../../provider/transcationController.dart';
import '../../utils/category images.dart';

class TransactionComponent extends StatelessWidget {
  TransactionComponent({super.key});

  TransactionController transactionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: transactionController.getAllTransactions.value.isNotEmpty
              ? ListView.builder(
                  itemCount:
                      transactionController.getAllTransactions.value.length,
                  itemBuilder: (context, index) {
                    TransactionModel transactionModal =
                        transactionController.getAllTransactions.value[index];

                    log("R: ${transactionModal.remarks}");

                    var image = allCategoryImages.where((element) =>
                        element['name'] == transactionModal.category);

                    log("Data: ${image.toList()[0]['image']}");

                    String img = image.toList()[0]['image'];

                    return Card(
                      child: ListTile(
                        onLongPress: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text(transactionModal.remarks!),
                              actions: [
                                TextButton.icon(
                                  onPressed: () async {
                                    int id = await transactionController.delete(
                                        id: transactionModal.id!);

                                    Get.snackbar("Deleted",
                                        "${transactionModal.id} ${transactionModal.remarks}");

                                    transactionController.init();

                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.delete),
                                  label: const Text("Delete"),
                                ),
                              ],
                            ),
                          );
                        },
                        leading: Image.asset(img),
                        title: Text(transactionModal.remarks!),
                        trailing: Text(
                          transactionModal.amount.toString(),
                          style: TextStyle(
                            color: transactionModal.type == "INCOME"
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
