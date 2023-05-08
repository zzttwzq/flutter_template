import 'package:app/views/index_page/index_page_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../home_page/home_page.dart';
import '../mine_page/mine_page.dart';

class IndexPageController extends GetxController {
  Rx<IndexPageModel> indexPageModel = IndexPageModel().obs;

  Rx<int> tabIndex = 0.obs;
  List<Widget> tabList = [
    const HomePage(),
    const MinePage(),
  ];

  changeTab(index) {
    tabIndex.value = index;
    // update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
