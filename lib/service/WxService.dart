// import 'package:flutter/cupertino.dart';
// import 'package:fluwx/fluwx.dart' as fluwx;
//
// class WxService {
//   static init() {
//     fluwx.registerWxApi(
//         appId: "",
//         doOnAndroid: true,
//         doOnIOS: true,
//         universalLink: "");
//   }
//
//   static isWxinstall() {
//     return fluwx.isWeChatInstalled;
//   }
//
//   static wxPay(result) async {
//
//     print(result);
//
//     return await fluwx.payWithWeChat(
//       appId: result['appid'],
//       partnerId: result['partnerid'],
//       prepayId: result['prepayid'],
//       packageValue: result['package'],
//       nonceStr: result['noncestr'],
//       timeStamp: result['timestamp'],
//       sign: result['sign'],
//     );
//   }
//
//   static shareLocalImageWithFile(title, file, pyq) async {
//     var isinstal = await isWxinstall();
//     print("is wx installed $isinstal");
//
//     try {
//       var res = await fluwx.shareToWeChat(fluwx.WeChatShareImageModel(
//           fluwx.WeChatImage.file(file),
//           scene: pyq == 1
//               ? fluwx.WeChatScene.TIMELINE
//               : fluwx.WeChatScene.SESSION));
//
//       return res;
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   static shareLocalImage(title, imageData, pyq) async {
//     var isinstal = await isWxinstall();
//     print("is wx installed $isinstal");
//
//     try {
//       var res = await fluwx.shareToWeChat(fluwx.WeChatShareImageModel(
//           fluwx.WeChatImage.binary(imageData),
//           scene: pyq == 1
//               ? fluwx.WeChatScene.TIMELINE
//               : fluwx.WeChatScene.SESSION));
//
//       return res;
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   static shareURLImage(url, pyq) async {
//     try {
//       var res = await fluwx.shareToWeChat(fluwx.WeChatShareImageModel(
//           fluwx.WeChatImage.network(url), // 头像  fluwx.WeChatImage.assent  本地图片
//           scene: pyq == 1
//               ? fluwx.WeChatScene.TIMELINE
//               : fluwx.WeChatScene.SESSION));
//
//       return res;
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   static share(url, title, des, thumImage, session) async {
//     var res = await fluwx.shareToWeChat(fluwx.WeChatShareWebPageModel(
//         "http://www.baidu.com", // 分享出去的链接地址，也就是用户在微信里面点击跳转的链接
//         title: '21323123', // 标题
//         description: '一起来围观吧！', // 描述，默认是👆的链接
//         thumbnail: fluwx.WeChatImage.network(
//             'https://meideli.oss-cn-beijing.aliyuncs.com/images/shareimage.jpeg'), // 头像  fluwx.WeChatImage.assent  本地图片
//         scene: fluwx.WeChatScene.SESSION));
//
//     return res;
//   }
//
//   static login(ret) async {
//     // wechat_sdk_demo_test
//     var res = await fluwx
//         .sendWeChatAuth(
//             scope: "snsapi_userinfo", state: "wechat_sdk_xb_live_state")
//         .then((data) {
//       print('数据');
//       print(data);
//       // ret(data);
//     }).catchError((e) {
//       print('weChatLogin  e  $e');
//     });
//
//     print('返回');
//     print(res);
//
//     return res;
//   }
// }
