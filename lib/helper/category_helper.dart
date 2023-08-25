import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/category_model.dart';

class DBHelper {
  DBHelper._private();
  static final DBHelper dbHelper = DBHelper._private();
  late Database database;

  String tableTr = "Transaction";
  String tableBl = "Balance";
  String tableCt = "Category";

  String trID = "Id";
  String trRemarks = "Remarks";
  String trType = "Type";
  String trCat = "Category";
  String trAmt = "Amount";
  String trDate = "Date";

  String blId = "Id";
  String blAmt = "Amount";

  String ctId = "Id";
  String ctTitle = "Title";
  String ctImage = "Image";

  initDB() async {
    String dbPath = await getDatabasesPath();
    String dbName = "DB1.db";
    String path = join(dbPath, dbName);
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, ver) {
        db.execute(
            "CREATE TABLE IF NOT EXISTS $tableBl($blId INTEGER PRIMARY KEY, $blAmt INTEGER)");
        db.rawInsert("INSERT INTO $tableBl VALUES (101,0)");

        db.execute(
            'CREATE TABLE IF NOT EXISTS $tableTr($trID INTEGER PRIMARY KEY AUTOINCREAMENT,$trRemarks TEXT, $trAmt INTEGER, $trType TEXT CHECK($trType IN("INCOME","EXPANSE")), $trCat TEXT, $trDate TEXT');
      },
    );
  }

  //'CREATE TABLE IF NOT EXISTS $tableTr($trId INTEGER PRIMARY KEY AUTOINCREMENT,$trRemarks TEXT,$trAmt INTEGER,$trType TEXT CHECK($trType IN("INCOME","EXPANSE")),$trCat TEXT,$trDate TEXT)'
  setBalance({required int amt}) {
    database
        .rawUpdate("UPDATE TABLE $tableBl SET $blAmt = $amt WHERE $blId = 101");
  }

  categoryInsert(
      {required String category_Name,
      required Uint8List category_image}) async {
    String query = "INSERT INTO $tableCt($ctTitle, $ctImage)VALUES(?,?);";
    List args = [category_Name, category_image];
    int res = await database.rawInsert(query, args);
    print("####################");
    print(res);
    print("####################");
    return res;
  }

  Future<List<Category>?> fetchAllCategory() async {
    List res = await database.rawQuery("*SELECT* FROM $tableCt");
    List<Category> allCategory =
        res.map((e) => Category.fromMap(data: e)).toList();
    return allCategory;
  }
}
