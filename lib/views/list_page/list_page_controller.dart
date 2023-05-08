import 'package:app/views/list_page/list_page_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListPageController extends GetxController {
  Rx<ListPageModel> listPageModel = ListPageModel().obs;
  RxList<dynamic> list = [].obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    list.value = ['1', '2', '3'];

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    list.add('3');

    refreshController.loadComplete();
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
