import 'package:app/views/scroll_page/scroll_page_model.dart';
import 'package:get/get.dart';

class ScrollPageController extends GetxController {
  Rx<ScrollPageModel> scrollPageModel = ScrollPageModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
