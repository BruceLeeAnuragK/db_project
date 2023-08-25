import 'dart:typed_data';

import 'package:get/get.dart';

class CategoryController extends GetxController {
  ByteData? imageByte;
  RxInt borderIndex = (-1).obs;
  selectIndex({required int index}) {
    borderIndex = index.obs;
  }
}
