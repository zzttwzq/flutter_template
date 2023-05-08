// import 'package:flutter/material.dart';
// import 'package:prxdchatApp/utils/Utils.dart';
//
// class NoDataView {
//   Widget getView(context, type, click) {
//
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//
//     var image;
//     var top;
//     var text;
//
//     if (type == 0) {
//       image = 'assets/images/nodata.png';
//       top = height*0.4/2+140;
//       text = "网络连接错误，点击重试";
//     }
//     else if (type == 1) {
//       image = 'assets/images/fav_none.png';
//       top = height*0.4/2+110;
//       text = "收藏夹还空着";
//     }
//
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       color: Color.fromRGBO(0, 0, 0, 0.05),
//       child: Stack(children: [
//         Positioned(
//             top: height*0.4/2,
//             left: (width-100)/2,
//             child: GestureDetector(
//                 onTap: () => {click()},
//                 child: Image.asset(
//                   image,
//                   width: 100,
//                 ))),
//         Positioned(
//             top: top,
//             child: GestureDetector(
//                 onTap: () => {click()},
//                 child: Container(
//                   width: width,
//                   height: 20,
//                   alignment: Alignment.center,
//                   child:Text(text,
//                     style: TextStyle(
//                         color: ColorUtil.fromHex('#D7D7D7'), fontSize: 15))
//                 ))),
//       ]),
//     );
//   }
// }
