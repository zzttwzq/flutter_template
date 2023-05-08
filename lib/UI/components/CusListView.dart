import 'package:flutter/material.dart';

import 'CusScrollView.dart';

class CusListView extends CusScrollView {


  Widget custListHeader() {

    return Container();
  }

  Widget custListFooter() {

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: this.custAppBar(),
        body: SafeArea(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          color: this.getBackgroundColor(),
          child: Column(
            children: [
              custListHeader(),
              Expanded(child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return buildItem(list[index], index);
                },
                controller: this.scrollController, //指明控制器加载更多使用
              )),
              custListFooter(),
            ],
          ),
        )));
  }

  // buildview
  buildItem(item, index) {}
}
