import 'dart:typed_data';

class Category {
  int id;
  String remarks;
  Uint8List image;

  Category(this.id, this.remarks, this.image);
  factory Category.fromMap({required Map data}) {
    return Category(
      data["id"],
      data["remarks"],
      data["image"],
    );
  }
}
