import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
 * 常用图片按钮
 */
class SimpleImageButton extends StatefulWidget {
  final String normalImage;
  final String pressedImage;
  final Function onPressed;
  final double width;
  final String? title;

  const SimpleImageButton({
    required this.normalImage,
    required this.pressedImage,
    required this.onPressed,
    required this.width,
    this.title,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    return _SimpleImageButtonState();
  }
}

class _SimpleImageButtonState extends State<SimpleImageButton> {
  @override
  Widget build(BuildContext context) {
    return ImageButton(
      normalImage: Image(
        image: AssetImage(widget.normalImage),
        width: widget.width,
        height: widget.width,
      ),
      pressedImage: Image(
        image: AssetImage(widget.pressedImage),
        width: widget.width,
        height: widget.width,
      ),
      title: widget.title ?? "",
      //文本是否为空
      normalStyle: TextStyle(
          color: Colors.white, fontSize: 14, decoration: TextDecoration.none),
      pressedStyle: TextStyle(
          color: Colors.white, fontSize: 14, decoration: TextDecoration.none),
      onPressed: widget.onPressed,
    );
  }
}

/*
 * 图片 按钮
 */
class ImageButton extends StatefulWidget {
  //常规状态
  final Image normalImage;

  //按住状态
  final Image? pressedImage;

  //按下状态
  final Image? selectedImage;

  //选中按下状态
  final bool selected;

  //按钮文本
  final String? title;

  //常规文本TextStyle
  final TextStyle? normalStyle;

  //按下文本TextStyle
  final TextStyle? pressedStyle;

  //按下回调
  final Function onPressed;

  //文本与图片之间的距离
  final double padding;

  ImageButton({
    required this.normalImage,
    required this.onPressed,
    this.pressedImage,
    this.selectedImage,
    this.selected = false,
    this.title,
    this.normalStyle,
    this.pressedStyle,
    this.padding = 0,
  }) : super();

  @override
  _ImageButtonState createState() {
    return _ImageButtonState();
  }
}

class _ImageButtonState extends State<ImageButton> {
  var isPressed = false;

  @override
  Widget build(BuildContext context) {
    double padding = widget.padding ?? 0;
    return GestureDetector(
      onTap: () {
        widget.onPressed.call();
      },
      onTapDown: (d) {
        //按下，更改状态
        setState(() {
          isPressed = true;
        });
      },
      onTapCancel: () {
        //取消，更改状态
        setState(() {
          isPressed = false;
        });
      },
      onTapUp: (d) {
        //抬起，更改按下状态
        setState(() {
          isPressed = false;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          isPressed ? widget.pressedImage??Container() : widget.normalImage??Container(), //不同状态显示不同的Image
          widget.title != null
              ? Padding(padding: EdgeInsets.fromLTRB(0, padding, 0, 0))
              : Container(),
          Text(
            "${widget.title}",
            style: isPressed ? widget.pressedStyle : widget.normalStyle,
          )
        ],
      ),
    );
  }
}
