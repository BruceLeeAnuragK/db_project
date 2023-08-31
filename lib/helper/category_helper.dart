import 'dart:typed_data';

import 'package:db_project/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/category_model.dart';

class DBHelper {
  DBHelper._private();
  static final DBHelper dbHelper = DBHelper._private();
  late Database database;

  String tableTr = "TableTransaction";
  String tableBl = "Balance";
  String tableCt = "Category";

  String trID = "Id";
  String trRemarks = "Remarks";
  String trType = "Type";
  String trCat = "Category";
  String trAmt = "Amount";
  String trDate = "trDate";
  String trTime = "trTime";

  String blId = "Id";
  String blAmt = "Amount";

  String ctId = "Id";
  String ctTitle = "Title";
  String ctImage = "Image";

  initDB() async {
    String dbPath = await getDatabasesPath();
    String dbName = "DB6.db";
    String path = join(dbPath, dbName);
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, ver) {
        db.execute(
            "CREATE TABLE IF NOT EXISTS $tableBl($blId INTEGER PRIMARY KEY, $blAmt INTEGER)");
        db.rawInsert("INSERT INTO $tableBl VALUES (101,0)");

        db.execute(
            'CREATE TABLE IF NOT EXISTS $tableTr($trID INTEGER PRIMARY KEY AUTOINCREMENT,$trRemarks TEXT, $trAmt INTEGER, $trType TEXT CHECK($trType IN("INCOME","EXPANSE")), $trCat TEXT, $trDate TEXT, $trTime TEXT)');
      },
    );
  }

  //'CREATE TABLE IF NOT EXISTS $tableTr($trId INTEGER PRIMARY KEY AUTOINCREMENT,$trRemarks TEXT,$trAmt INTEGER,$trType TEXT CHECK($trType IN("INCOME","EXPANSE")),$trCat TEXT,$trDate TEXT)'
  setBalance({required int amt}) {
    database
        .rawUpdate("UPDATE TABLE $tableBl SET $blAmt = $amt WHERE $blId = 101");
  }

  categoryInsert(
      {required String categoryName, required Uint8List categoryImage}) async {
    String query = "INSERT INTO $tableCt($ctTitle, $ctImage)VALUES(?,?);";
    List args = [categoryName, categoryImage];
    int res = await database.rawInsert(query, args);
    debugPrint("####################");
    debugPrint(res.toString());
    debugPrint("####################");
    return res;
  }

  Future<List<Category>?> fetchAllCategory() async {
    List res = await database.rawQuery("SELECT * FROM $tableCt");
    List<Category> allCategory =
        res.map((e) => Category.fromMap(data: e)).toList();
    return allCategory;
  }

  Future<int> insertTransaction({required TransactionModel transaction}) async {
    String query =
        "INSERT INTO $tableTr($trRemarks,$trAmt, $trType, $trCat, $trDate, $trTime) VALUES(?,?,?,?,?,?)";
    List args = [
      transaction.remarks,
      transaction.amount,
      transaction.type,
      transaction.category,
      transaction.date,
      transaction.time,
    ];

    return await database.rawInsert(query, args);
  }

  Future<List<TransactionModel>> getAllTransaction() async {
    String query = "SELECT * FROM $tableTr";
    List allData = await database.rawQuery(query);
    List<TransactionModel> allTransactions =
        allData.map((e) => TransactionModel.fromMap(data: e)).toList();
    return allTransactions;
  }

  Future<int> deleteTransaction({required int id}) async {
    String query = "DELETE FROM $tableTr WHERE Id = $id";
    return await database.rawDelete(query);
  }

  Future<int> update({required TransactionModel transactionModel}) async {
    String query =
        "UPDATE $tableTr SET $trRemarks = ?, $trAmt = ?, $trType = ?";
    List args = [
      transactionModel.remarks,
      transactionModel.amount,
      transactionModel.type,
    ];
    return await database.rawUpdate(query, args);
  }
}
// visiblity
