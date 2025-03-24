import 'package:app/ui/custom_appbar.dart';
import 'package:app/views/grid_page/grid_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/flutterbase.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GridPage extends GetView with BaseUiMixin {
  GridPage({super.key});

  final GridPageController listPageController = Get.find<GridPageController>();

  _getList(BuildContext context, int index) {
    return Container(
      child: Text(listPageController.list.value[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.regularAppBar('title'),
        body: SafeArea(
            child: Container(
                child: Container(
                    child: Obx(() => SmartRefresher(
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
                          child: GridView.builder(
                            itemCount: listPageController.list.value.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    //横轴元素个数
                                    crossAxisCount: 2,
                                    //纵轴间距
                                    mainAxisSpacing: 20.0,
                                    //横轴间距
                                    crossAxisSpacing: 10.0,
                                    //子组件宽高长度比例
                                    childAspectRatio: 1.0),
                            itemBuilder: (BuildContext context, int index) {
                              return _getList(context, index);
                            },
                          ),
                        ))))));
  }
}
