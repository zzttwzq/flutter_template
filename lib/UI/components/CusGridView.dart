import 'package:flutter/material.dart';
import 'CusScrollView.dart';

class CusGridView extends CusScrollView {

  @override
  custView(context) {
    return list.length == 0
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            color: indicatorColor,
            //下拉刷新
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                if (index == list.length) {
                  return this.buildProgressMoreIndicator();
                } else {
                  return buildItem(index);
                }
              },
            ),
            onRefresh: this.refresh,
          );
  }
  
  // buildview
  buildItem(i) {}
}
