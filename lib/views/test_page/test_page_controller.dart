import 'package:app/views/test_page/test_page_model.dart';
import 'package:get/get.dart';

class TestPageController extends GetxController {
  Rx<TestPageModel> testPageModel = TestPageModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
