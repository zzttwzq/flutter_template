import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

/// 注册登录用的输入框
loginRegisterTextField(
    {String hintText = "",
    Color hintColor = Colors.black12,
    double fontSize = 18,
    double height = 100,
    Color textColor = Colors.black45,
    TextEditingController? controller,
    bool isPwd = false,
    Widget? rightIcon}) {
  return TextField(
    obscureText: isPwd,
    controller: controller,
    style: TextStyle(
      letterSpacing: 2,
      color: textColor,
      fontSize: sFontSize(fontSize),
    ),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(25, 14, 0, 14),
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: TextStyle(
        color: hintColor,
        fontSize: fontSize,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: rightIcon,
      ),
    ),
  );
}

/// 注册登录的按钮
loginRegisterButton({
  required VoidCallback onPressed,
  required String title,
  required Color beginColor,
  Color? endColor,
  Color? disableColor,
  double titleFontSize = 20,
  double letterSpacing = 10,
  Color titleColor = Colors.white,
  bool enable = true,
  double height = 50,
  EdgeInsets margin = EdgeInsets.zero,
}) {
  return Container(
    margin: margin,
    height: sHeight(height),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(sHeight(height)), //圆角
      gradient: LinearGradient(
        colors: enable
            ? <Color>[
                //背景渐变
                beginColor,
                endColor ?? beginColor,
              ]
            : [
                disableColor ?? beginColor,
                disableColor ?? beginColor,
              ],
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: enable ? onPressed : () {},
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: titleColor,
                fontSize: sFontSize(titleFontSize),
                letterSpacing: letterSpacing,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

// /// 侧滑的Item
// slideItem({
//   required Widget child,
//   required List<IconSlideAction> actions,
//   EdgeInsets margin = EdgeInsets.zero,
// }) {
//   return Container(
//     margin: margin,
//     child: Slidable(
//       actionPane: SlidableScrollActionPane(), // 滑出选项的面板 动画
//       actionExtentRatio: 0.25,
//       child: child,
//       secondaryActions: actions,
//     ),
//   );
// }
//
// /// 侧滑的"删除"类型action
// slideDeleteAction({
//   required VoidCallback onTap,
// }) {
//   return IconSlideAction(
//     color: Colors.red,
//     iconWidget: _slidableActionItem(
//       '删除',
//       Icons.delete,
//     ),
//     closeOnTap: true,
//     onTap: onTap,
//   );
// }
//
// /// 侧滑的"更多"类型action
// slideNormalAction({
//   VoidCallback onTap,
//   String label = '更多',
//   IconData icon,
//   Color color = Colors.black45,
// }) {
//   return IconSlideAction(
//     color: Colors.red,
//     iconWidget: _slidableActionItem(
//       label,
//       icon ?? Icons.more_horiz,
//     ),
//     closeOnTap: true,
//     onTap: onTap,
//   );
// }

/// 侧滑按钮样式
_slidableActionItem(String caption, IconData icon) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Flexible(
        child: Icon(
          icon,
          color: Colors.white,
          size: sWidth(28),
        ),
      ),
      Flexible(
        child: Text(
          caption,
          style: TextStyle(
            color: Colors.white,
            fontSize: sFontSize(16),
          ),
        ),
      ),
    ],
  );
}

/// 未读数
unreadCoundWidget(int unreadCount) {
  if (unreadCount == 0) return Container();
  String count;
  if (unreadCount > 99) {
    count = '99+';
  } else {
    count = unreadCount.toString();
  }
  return Container(
    padding: EdgeInsets.only(left: sWidth(3), right: sWidth(3)),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.all(
        Radius.circular(sWidth(15)),
      ),
    ),
    constraints: BoxConstraints(
      minWidth: sWidth(18),
      maxWidth: sWidth(30),
    ),
    child: Text(
      count,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: sFontSize(12),
        color: Colors.white,
      ),
    ),
  );
}

/// 屏幕宽度
double sWidth(double w) {
  return ScreenUtil.getInstance().getWidth(w);
}

/// 屏幕高度
double sHeight(double h) {
  return ScreenUtil.getInstance().getHeight(h);
}

/// 屏幕字体
double sFontSize(double size) {
  return ScreenUtil.getInstance().getSp(size);
}

/// 时间转换string
