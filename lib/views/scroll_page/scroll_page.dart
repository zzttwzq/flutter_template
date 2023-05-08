import 'package:app/UI/custom_appbar.dart';
import 'package:app/utils/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollPage extends GetView with BaseUiMixin {
  const ScrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.regularAppBar('title'),
        body: SafeArea(
          child: Container(
            child: CustomScrollView(
              shrinkWrap: true,
              // 内容
              slivers: <Widget>[
                new SliverPadding(
                  padding: const EdgeInsets.all(20.0),
                  sliver: new SliverList(
                    delegate: new SliverChildListDelegate(
                      <Widget>[
                        const Text('A'),
                        const Text('B'),
                        const Text('C'),
                        const Text('D'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
