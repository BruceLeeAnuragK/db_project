import 'dart:developer';

class TransactionModel {
  int? id;
  String? remarks;
  String? type;
  String? category;
  var amount;
  String? date;
  String? time;

  TransactionModel(
    this.id,
    this.remarks,
    this.type,
    this.category,
    this.amount,
    this.date,
    this.time,
  );

  TransactionModel.init() {
    log("Empty transaction initialized...");
  }

  factory TransactionModel.fromMap({required Map data}) {
    return TransactionModel(
      data['Id'],
      data['Remarks'],
      data['Type'],
      data['Category'],
      data['Amount'].toString(),
      data['trDate'],
      data['trTime'],
    );
  }
}
