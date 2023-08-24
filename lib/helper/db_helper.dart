import 'package:sqflite/sqflite.dart';

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
    String dbPath = await getDatabadePath();
    String dbName = "DB1.db";
    String path = join(dbPath, dbName);
    database = await openDatabase(path, version: 1, onCreate: (db, ver) {
      db.execute(
          "CREATE TABLE IF NOT EXISTS $tableBl($blId INTEGER PRIMARY KEY, $blAmt INTEGER)");
      db.rawInsert("INSERT INTO $tableBl VALUES (101,0)");

      db.execute("CREATE TABLE IF NOT EXISTS $tableTr");
    });
  }
}
