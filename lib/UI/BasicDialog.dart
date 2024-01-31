import 'package:flutter/material.dart';

import '../utils/color_util.dart';

class BasicDialog extends Dialog {
  final String submitBtnTxt; //标题
  final Function? confirmFun; //确定回调
  final List<Widget> widgets; //内容

  const BasicDialog(
      {super.key,
      required this.submitBtnTxt,
      required this.widgets,
      this.confirmFun});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: widgets,
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget getCancelBtn(context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 11, 11, 0),
          child: Container(
              alignment: Alignment.centerRight,
              child: Image.asset('assets/images/delete_gray.png',
                  width: 20, height: 20, fit: BoxFit.fitWidth)),
        ));
  }

  static Widget getButton(title, submit) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 17, 20, 0),
        child: MaterialButton(
            padding: const EdgeInsets.all(12),
            color: ColorUtil.fromHex('#FF4589'),
            textColor: Colors.white,
            disabledColor: ColorUtil.fromHex('#E2E0E3'),
            shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            onPressed: () async {
              submit();
            },
            child: Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white))));
  }

  static Widget getBorderButton(title, submit) {
    return GestureDetector(
        onTap: submit,
        child: Container(
            width: double.infinity,
            height: 44,
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(20, 17, 20, 20),
            decoration: BoxDecoration(
              border:
                  Border.all(color: ColorUtil.fromHex('#FF4589'), width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: Text(
              '$title',
              style:
                  TextStyle(color: ColorUtil.fromHex('#FF4589'), fontSize: 16),
            )));
  }

  static Widget getSeparateLine() {
    return Container(
        width: double.infinity,
        height: 0.5,
        color: ColorUtil.fromHex('#EEEEEE'),
        margin: const EdgeInsets.fromLTRB(0, 24, 0, 0));
  }

  static Widget getConfirmButton(
      context, confirmText, cancelText, confirmCallback, cancelCallback) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    var showSep = true;
    var btnWidth = width * 0.4;
    if ((cancelText == null || cancelText?.length == 0) ||
        (confirmText == null || confirmText?.length == 0)) {
      btnWidth = width * 0.8;
      showSep = false;
    }

    return Container(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            cancelText != null && cancelText.length > 0
                ? GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      cancelCallback();
                    },
                    child: Container(
                        width: btnWidth,
                        child: Text('$cancelText',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorUtil.fromHex('#999999')))))
                : Container(),
            showSep
                ? Container(
                    width: 0.5,
                    height: 50,
                    color: ColorUtil.fromHex('#EEEEEE'),
                  )
                : Container(),
            confirmText != null && confirmText.length > 0
                ? GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      confirmCallback();
                    },
                    child: Container(
                        width: btnWidth,
                        child: Text('$confirmText',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorUtil.fromHex('#FF4589')))))
                : Container(),
          ],
        ));
  }
}
