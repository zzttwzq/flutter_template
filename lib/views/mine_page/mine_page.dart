import 'package:app/ui/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/mixins/ui_mixin.dart';
import 'package:get/get.dart';

class MinePage extends GetView with BaseUiMixin {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.clearAppBar(),
        body: SafeArea(
          child: Container(
            child: Text('>>> mine'),
          ),
        ));
  }
}
