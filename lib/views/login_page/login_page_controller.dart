import 'package:app/views/login_page/login_page_model.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  Rx<LoginPageModel> loginPageModel = LoginPageModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
