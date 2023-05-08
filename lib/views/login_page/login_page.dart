import 'package:app/UI/custom_appbar.dart';
import 'package:app/const/image_const.dart';
import 'package:app/utils/ui_util.dart';
import 'package:app/views/components/text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/toast_util.dart';

class LoginPage extends GetView with BaseUiMixin {
  LoginPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.clearAppBar(),
        body: SafeArea(
          child: Container(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageConst.logo_icon,
                  width: 100,
                ),
                TextFormView(formKey, [
                  TextFormModel(title: '账号:', placeHolder: '请输入账号'),
                  TextFormModel(title: '密码:', placeHolder: '请输入密码'),
                ], () {
                  debugPrint('>>> loading');
                }),
                TextButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        ToastUtil.toast('校验成功');
                      }
                    },
                    child: Text('asdfasdf'))
              ],
            ),
          )),
        ));
  }
}
