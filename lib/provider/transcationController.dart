import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../helper/category_helper.dart';
import '../model/transaction_model.dart';

class TransactionController extends GetxController {
  RxList<TransactionModel> _allTransactions = <TransactionModel>[].obs;
  RxList<TransactionModel> _allSearchedTransactions = <TransactionModel>[].obs;
  RxString remarks = "".obs;
  RxString amount = "".obs;
  static final storage = GetStorage();

  void OnSubmit(String remark, String amounts) {
    remarks.value = remark;
    amount.value = amounts;

    storage.write("userName", remarks.value);
    storage.write("email", amount.value);
  }

  TransactionController() {
    print("**** Done ****");
    init();
    print("**** End ****");
  }

  init() async {
    print("----- Init Start -----");
    _allTransactions(await DBHelper.dbHelper.getAllTransaction());
    for (var element in _allTransactions) {
      log("Data: ${element.id} => ${element.remarks}");
    }
    print("----- Init end -----");
  }

  Future<int> addTransaction(
      {required TransactionModel transactionModel}) async {
    return DBHelper.dbHelper.insertTransaction(transaction: transactionModel);
  }

  RxList<TransactionModel> get getAllTransactions {
    return _allTransactions;
  }

  RxList<TransactionModel> get getAllSerchedTransactions {
    return _allSearchedTransactions;
  }

  Future<int> delete({required int id}) async {
    init();

    if (_allTransactions.any((element) => element.id == id)) {
      return await DBHelper.dbHelper.deleteTransaction(id: id);
    } else {
      Get.snackbar("ERROR !!", "$id does not exist...");
      return 0;
    }
  }

  searchData({required String remarks}) async {
    _allSearchedTransactions(await DBHelper.dbHelper.getAllTransaction());
  }

  Update({required TransactionModel transactionModel}) async {
    int res =
        await DBHelper.dbHelper.update(transactionModel: transactionModel);

    if (res == 0) {
      Get.snackbar("Alert", "Record not found.");
    }
  }
}
