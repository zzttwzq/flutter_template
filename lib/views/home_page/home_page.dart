import 'package:app/ui/custom_appbar.dart';
import 'package:app/utils/ui_util.dart';
import 'package:app/views/components/text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomePage extends GetView with BaseUiMixin {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.noBackAppBar(),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                // TextFormView(),
                // Lottie.asset('assets/lottie/Polite Chicky.json'),
              ],
            ),
          ),
        ));
  }
}
