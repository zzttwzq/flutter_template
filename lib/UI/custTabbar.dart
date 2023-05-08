import 'package:flutter/material.dart';

class CustTabbar extends StatefulWidget {
  final List<String> titleList;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Function callBack;
  final int type;

  CustTabbar(this.titleList, this.callBack(String title, int index),
      {this.margin = EdgeInsets.zero, this.padding = EdgeInsets.zero, this.type = 0});

  @override
  createState() => new _CustTabbarState();
}

class _CustTabbarState extends State<CustTabbar> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];

    var index = 0;
    widget.titleList.forEach((title) {
      list.add(buildTabBarItem(
        index,
        title,
      ));
      index++;
    });

    return Container(
      margin: widget.margin,
      padding: widget.padding,
      decoration: BoxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: widget.type == 0 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: list,
      ),
    );
  }

  buildTabBarItem(index, title) {

    return GestureDetector(
        onTap: () {
          tabBarItemClick(title, index);
        },
        child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, widget.type == 0 ? 0 : 24, 0),
            decoration: BoxDecoration(
              // color: Colors.red,
              image: currentIndex == index
                  ? DecorationImage(
                      alignment: Alignment.centerLeft,
                      matchTextDirection: true,
                      image: ExactAssetImage('assets/images/tabBack.png'),
                      fit: BoxFit.fitHeight,
                    )
                  : null,
            ),
            alignment: Alignment.center,
            child: Column(children: [
              Text(currentIndex == index ? ' $title' : '$title',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: currentIndex == index ? 20 : 16,
                      fontWeight: currentIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: Colors.black)),
            ])));
  }

  tabBarItemClick(title, index) {
    setState(() {
      currentIndex = index;
    });

    widget.callBack(title, index);
  }
}
