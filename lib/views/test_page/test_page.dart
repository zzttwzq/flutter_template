import 'package:app/ui/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/mixins/ui_mixin.dart';
import 'package:get/get.dart';

class TestPage extends GetView with BaseUiMixin {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.regularAppBar('title'),
        body: SafeArea(
          child: Container(),
        ));
  }
}
