import 'package:flutter/material.dart';
import 'CusView.dart';

class CusScrollView extends CusView with WidgetsBindingObserver {
  var list = [];
  var page = 1;
  var pageSize = 10;
  var total = 0;

  var scrollController = new ScrollController();
  var indicatorColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: this.custAppBar(),
        body: SafeArea(
            child: GestureDetector(
                onTap: () {
                  //点击空白处隐藏键盘
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: getBackgroundColor(),
                    child: CustomScrollView(
                      shrinkWrap: true,
                      slivers: <Widget>[
                        new SliverPadding(
                          padding: const EdgeInsets.all(0.0),
                          sliver: new SliverList(
                            delegate: new SliverChildListDelegate(
                              columViews().length > 0
                                  ? columViews()
                                  : <Widget>[this.custView(context)],
                            ),
                          ),
                        )
                      ],
                    )))));
  }

  List<Widget> columViews() {
    return [];
  }

  getData() {}

  buildProgressMoreIndicator() {}

  //下拉刷新
  Future<void> refresh() async {
    page = 1;

    getData();
  }
}
