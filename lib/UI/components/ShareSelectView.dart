// import 'package:prxdchatApp/utils/Utils.dart';
// import 'package:prxdchatApp/services/WxService.dart';
// import 'package:flutter/material.dart';
//
// class ShareSelectView {
//   getView(context, click) async {
//     var list;
//     var isWxinstall = await WxService.isWxinstall();
//
//     if (isWxinstall) {
//       list = [
//         {
//           "title": "微信",
//           "image": "assets/images/weixin1.png",
//         },
//         {
//           "title": "朋友圈",
//           "image": "assets/images/pengyouquan.png",
//         },
//         {
//           "title": "保存本地",
//           "image": "assets/images/storage.png",
//         },
//       ];
//     } else {
//       list = [
//         {
//           "title": "保存本地",
//           "image": "assets/images/storage.png",
//         },
//       ];
//     }
//
//     List<Widget> listview = [];
//
//     list.forEach((v) {
//       var item = FlatButton(
//           onPressed: () {
//             Navigator.pop(context);
//             click(v['title']);
//           },
//           child: Container(
//               width: 60,
//               height: 100,
//               child: Column(children: [
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
//                   child: Image.asset(
//                     v['image'],
//                     width: 29,
//                     height: 25,
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                   child: Text(v['title'],
//                       style: TextStyle(
//                           color: ColorUtil.fromHex('#373737'),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500)),
//                 )
//               ])));
//
//       listview.add(item);
//     });
//
//     showModalBottomSheet(
//         context: context,
//         backgroundColor: Colors.transparent, //重点
//         builder: (BuildContext context) {
//           return Container(
//             height: 200,
//             width: double.infinity,
//             child: Column(children: [
//               getTitleView(context),
//               Container(
//                 width: double.infinity,
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: listview,
//               )
//             ]),
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
//         padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//         child:
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           Container(
//             child: Text(
//               '分享到',
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
// }
