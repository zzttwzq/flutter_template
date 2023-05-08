import 'package:app/const/image_const.dart';
import 'package:app/views/splash/splash_controller.dart';
import 'package:get/get.dart';
import '../../UI/common_image_view.dart';
import '../../utils/size_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends GetWidget<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: ColorConstant.whiteA700,
        body: SafeArea(
            child: Container(
                width: size.width,
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                      Container(
                          height: getVerticalSize(167.00),
                          width: getHorizontalSize(374.00),
                          margin: getMargin(left: 1),
                          child:
                              Stack(alignment: Alignment.centerLeft, children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: CommonImageView(
                                    imagePath: ImageConst.avatar,
                                    height: getVerticalSize(167.00),
                                    width: getHorizontalSize(374.00))),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: CommonImageView(
                                    imagePath: ImageConst.avatar,
                                    height: getVerticalSize(167.00),
                                    width: getHorizontalSize(374.00)))
                          ])),
                      Padding(
                          padding: getPadding(left: 108, top: 42, right: 108),
                          child: CommonImageView(
                              svgPath: ImageConst.avatar,
                              height: getSize(140.00),
                              width: getSize(140.00))),
                      Padding(
                          padding: getPadding(left: 108, top: 31, right: 108),
                          child: Text(
                            "lbl_grocery_plus".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          )),
                      Container(
                          height: getVerticalSize(274.00),
                          width: getHorizontalSize(374.00),
                          margin: getMargin(left: 1, top: 83),
                          child:
                              Stack(alignment: Alignment.centerLeft, children: [
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                    padding: getPadding(top: 10),
                                    child: CommonImageView(
                                        imagePath: ImageConst.avatar,
                                        height: getVerticalSize(151.00),
                                        width: getHorizontalSize(374.00)))),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: CommonImageView(
                                    imagePath: ImageConst.avatar,
                                    height: getVerticalSize(274.00),
                                    width: getHorizontalSize(374.00)))
                          ]))
                    ])))));
  }
}
