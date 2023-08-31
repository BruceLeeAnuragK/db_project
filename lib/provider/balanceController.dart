import 'dart:typed_data';

import 'package:get/get.dart';

class BalanceController extends GetxController {
  ByteData? imageByte;
  RxInt borderIndex = (-1).obs;
  selectIndex({required int index}) {
    borderIndex = index.obs;
  }
}
