import 'dart:typed_data';

class Category {
  int id;
  String remark;
  Uint8List image;

  Category(
    this.id,
    this.remark,
    this.image,
  );

  factory Category.fromMap({required Map data}) {
    return Category(
      data['id'],
      data['remark'],
      data['image'],
    );
  }
}
