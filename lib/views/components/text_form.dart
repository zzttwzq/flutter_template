import 'package:flutter/material.dart';

enum TextFormValidateType {
  custom,
  isEmpty,
  email,
  phoneNum,
}

class TextFormModel {
  /// 标题
  String title;

  /// 文本内容
  String text;

  /// 提示内容
  String placeHolder;

  /// 验证内容类型, type = custom 时，会调用自定义的验证方法
  TextFormValidateType validateType;

  /// 自定义验证方法
  Function? validate;

  TextFormModel(
      {this.validateType = TextFormValidateType.isEmpty,
      this.validate,
      this.title = '',
      this.text = '',
      // this.hintText = '',
      this.placeHolder = ''});
}

class TextFormView extends StatelessWidget {
  GlobalKey<FormState> formKey;
  List<TextFormModel> models;
  Function onChanged;

  TextFormView(this.formKey, this.models, this.onChanged, {super.key});

  static checkValidate(
      GlobalKey<FormState> key, Function(Map data) success, Function() error) {
    if (key.currentState?.validate() ?? false) {
      success({});
    } else {
      error();
    }
  }

  static reset(
    GlobalKey<FormState> key,
  ) {
    key.currentState?.reset();
  }

  static save(
    GlobalKey<FormState> key,
  ) {
    key.currentState?.save();
  }

  List<Widget> getTextForm(List<TextFormModel> models) {
    List<Widget> l = [];

    for (TextFormModel m in models) {
      TextEditingController textEditingController =
          TextEditingController(text: m.text);

      l.add(TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: m.placeHolder,
          prefix: Container(
            margin: const EdgeInsets.only(right: 10),
            child: Text(m.title),
          ),
        ),
        validator: (value) {
          if (m.validate == null) {
            return null;
          }
          return m!.validate!(value);
        },
      ));
    }

    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      onChanged: () {
        onChanged();
      },
      key: formKey,
      child: Column(children: getTextForm(models)),
    ));
  }
}
