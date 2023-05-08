// import 'package:flutter/material.dart';
// import 'package:prxdchatApp/utils/Utils.dart';
//
// class MoreView {
//   showView(context, item, click) {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//
//     var list = [];
//
//     if (item['related_links'] == null || item['related_links'].length == 0) {
//       return 0;
//     }
//
//     item['related_links'].forEach((item) {
//       list.add(item);
//     });
//
//     var listview = Container(
//       width: double.infinity,
//       height: (317 - 70).toDouble(),
//       child: ListView.builder(
//           itemCount: list.length,
//           itemBuilder: (context, index) {
//             return buildItem(context, list[index], index, click);
//           }),
//     );
//
//     showModalBottomSheet(
//         context: context,
//         backgroundColor: Colors.transparent, //重点
//         builder: (BuildContext context) {
//           return Container(
//             height: 317,
//             width: width,
//             child: Container(
//               child: Column(children: [
//                 getTitleView(context),
//                 listview,
//               ]),
//             ),
//             // child: Column(children: [titleview, listview]),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//             ),
//           );
//         });
//   }
//
//   getTitleView(context) {
//     return Container(
//         margin: EdgeInsets.fromLTRB(20, 30, 20, 15),
//         child:
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           Container(
//             child: Text(
//               '相关链接',
//               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Image.asset(
//               'assets/images/delete.png',
//               width: 25,
//             ),
//           )
//         ]));
//   }
//
//   buildItem(context, item, index, click) {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//
//     return GestureDetector(
//       onTap: () {
//         Navigator.pop(context);
//         click(item);
//       },
//       child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
//           child: Column(children: [
//             Container(
//                 alignment: Alignment.topCenter,
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 8,
//                       height: 8,
//                       decoration: BoxDecoration(
//                           color: ColorUtil.fromHex('#567BF0'),
//                           borderRadius: BorderRadius.circular(8)),
//                       margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
//                     ),
//                     Container(
//                       // color: Colors.red,
//                       width: width - 80,
//                       margin: EdgeInsets.fromLTRB(0, 5, 20, 0),
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                           item['title'],
//                           maxLines: 10,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                               color: ColorUtil.fromHex('#333333'),
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold)),
//                     ),
//                   ],
//                 )),
//             Container(
//               margin: EdgeInsets.fromLTRB(18, 5, 20, 15),
//               alignment: Alignment.centerLeft,
//               child: Text(item['des'],
//                   style: TextStyle(
//                       color: ColorUtil.fromHex('#D7D7D7'), fontSize: 16)),
//             ),
//             Container(
//               width: double.infinity,
//               height: 1,
//               color: ColorUtil.fromHex('#f4f4f4'),
//             ),
//           ])),
//     );
//   }
// }
