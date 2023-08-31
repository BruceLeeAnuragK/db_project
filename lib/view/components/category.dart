import 'dart:developer';

import 'package:db_project/helper/category_helper.dart';
import 'package:db_project/model/transaction_model.dart';
import 'package:db_project/provider/category_controller.dart';
import 'package:db_project/provider/transcationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/category images.dart';

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);
  CategoryController categoryController = Get.put(CategoryController());
  TransactionController transaction = TransactionController()..init();
  TransactionModel transactionModel = TransactionModel.init();
  GlobalKey<FormState> transactionkey = GlobalKey<FormState>();
  TextEditingController remarksTextEditingController = TextEditingController();
  TextEditingController amountTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() {
              return Row(
                children: [
                  ...List.generate(
                    allCategoryImages.length,
                    (index) => GestureDetector(
                      onTap: () async {
                        categoryController.selectIndex(index: index);

                        categoryController.imageByte = await rootBundle
                            .load(allCategoryImages[index]["image"]);
                        transactionModel.category =
                            allCategoryImages[index]['name'];
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 250,
                          width: 150,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(5, 5),
                                spreadRadius: 1,
                                blurRadius: 10,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: (categoryController.borderIndex.value ==
                                      index)
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  foregroundImage: AssetImage(
                                    allCategoryImages[index]["image"],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${allCategoryImages[index]["name"]}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: transactionkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (val) {
                      transactionModel.remarks = val;
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        "Enter the Remarks here.";
                      } else {
                        "";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Remark",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (val) {
                      transactionModel.amount = double.parse(val);
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        "Enter the Amount here.";
                      } else {
                        "";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Amount",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () {
                    return CupertinoSlidingSegmentedControl(
                      groupValue: categoryController.type.value,
                      children: const {
                        "INCOME": Text("INCOME"),
                        "EXPANSE": Text("EXPANSE"),
                      },
                      onValueChanged: (val) {
                        categoryController.selectType(type: val!);
                        transactionModel.type = val;
                        debugPrint(
                          categoryController.type.value,
                        );
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (transactionkey.currentState!.validate()) {
                        DateTime d = DateTime.now();
                        String time =
                            "${d.hour.toString().padLeft(2, '0')}: ${d.minute.toString().padLeft(2, '0')} : ${d.second.toString().padLeft(2, '0')}";
                        transactionModel.id = 0;
                        transactionModel.time = time;
                        String date = "${d.day}/${d.month}/${d.year}";
                        transactionModel.date = date;

                        int res = await DBHelper.dbHelper
                            .insertTransaction(transaction: transactionModel);

                        if (res >= 1) {
                          Get.snackbar("Successfully",
                              "Your Transaction of ${transactionModel.amount} of ${transactionModel.remarks} is Added ");
                        }
                      } else {
                        log("not saved");
                      }
                    },
                    child: Text("Add Transaction"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
