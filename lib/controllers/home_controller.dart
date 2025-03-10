import 'package:get/get.dart';

class HomeControllers extends GetxController {
  static HomeControllers get instance => Get.find();
  final carousalCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }
}
