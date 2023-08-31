import 'dart:typed_data';

import 'package:get/get.dart';

class CategoryController extends GetxController {
  ByteData? imageByte;
  RxInt borderIndex = (-1).obs;
  RxString type = "INCOME".obs;

  selectIndex({required int index}) {
    borderIndex(index);
  }

  selectType({required String type}) {
    this.type(type);
  }
}
