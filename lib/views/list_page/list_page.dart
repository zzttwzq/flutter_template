import 'package:app/UI/custom_appbar.dart';
import 'package:app/utils/ui_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'list_page_controller.dart';

class ListPage extends GetView with BaseUiMixin {
  ListPage({super.key});

  final ListPageController listPageController = Get.find<ListPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.regularAppBar('title'),
        body: SafeArea(
            child: Container(
                child: Obx(
          () => SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load more");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: listPageController.refreshController,
            onRefresh: listPageController.onRefresh,
            onLoading: listPageController.onLoading,
            child: ListView.builder(
              itemBuilder: (c, i) =>
                  Card(child: Center(child: Text(listPageController.list.value[i]))),
              itemExtent: 100.0,
              itemCount: listPageController.list.value.length,
            ),
          ),
        ))));
  }
}
