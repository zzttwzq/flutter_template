// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
//
// import '../utils/color_util.dart';
// import '../utils/storage_util.dart';
// import 'BasicDialog.dart';
// import 'components/CusWebview.dart';
//
// const String showConversitionAlert = 'showConversitionAlert';
// const String showMiyouLevelUpdate = 'showMiyouLevelUpdate';
//
// class DialogFactory {
//   // 送礼物成为密友弹出框
//   static showGiftSendDialog(context, confirmCallback, userDetailCallback) {
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return BasicDialog(
//             widgets: [
//               BasicDialog.getCancelBtn(context),
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
//                   child: Center(
//                     child: Image.asset('assets/images/dongtaitanchuang_tan.png',
//                         width: 120, height: 129, fit: BoxFit.fitWidth),
//                   )),
//               Container(
//                   margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
//                   child: const Text('成为Ta的密友，查看Ta的动态吧',
//                       style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold))),
//               Container(
//                   padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                   child: Text('送一个“玫瑰花盒”礼物（共3000红豆），立即成为密友吧！',
//                       style: TextStyle(
//                           fontSize: 12, color: ColorUtil.fromHex('#999999')))),
//               BasicDialog.getButton('立即送礼升级', confirmCallback),
//               GestureDetector(
//                   onTap: userDetailCallback,
//                   child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                       margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                               margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                               child: Text('了解密友',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       color: ColorUtil.fromHex('#FF4589')))),
//                           Container(
//                               margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
//                               child: Center(
//                                 child: Image.asset(
//                                     'assets/images/arrow_red_right.png',
//                                     width: 10,
//                                     fit: BoxFit.fitWidth),
//                               )),
//                         ],
//                       ))),
//             ],
//             submitBtnTxt: 'asdf',
//           );
//         });
//   }
//
//   // 获取定位权限
//   static showLocationDialog(context, confirmCallback) {
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return BasicDialog(
//             widgets: [
//               BasicDialog.getCancelBtn(context),
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                   child: Center(
//                     child: Image.asset('assets/images/location_pic.png',
//                         width: 120, height: 129, fit: BoxFit.fitWidth),
//                   )),
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                   child: Text('请开启位置权限',
//                       style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold))),
//               Container(
//                   padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                   margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
//                   child: Text('你还未开启位置权限，无法准确 查看附近美女/帅哥，快去开启吧！',
//                       style: TextStyle(fontSize: 12, color: Colors.black))),
//               BasicDialog.getButton('立即开启', () {
//                 Navigator.pop(context);
//                 confirmCallback();
//               }),
//               Container(margin: EdgeInsets.fromLTRB(0, 0, 0, 20)),
//             ], submitBtnTxt: '',
//           );
//         });
//   }
//
//   // 送礼物成为密友弹出框
//   static showMiyouLevelUpdateDialog(
//       context, level, redcode, videoCallBack, voiceCallBack) async {
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return BasicDialog(
//             widgets: [
//               BasicDialog.getCancelBtn(context),
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 32, 0, 0),
//                   child: Center(
//                     child: Image.asset('assets/images/miyoushengji.png',
//                         width: 120, height: 129, fit: BoxFit.fitWidth),
//                   )),
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                   child: RichText(
//                     text: TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: '恭喜你们达到',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold)),
//                         TextSpan(
//                             text: '密友${level}级',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 color: ColorUtil.fromHex('#FF4589'),
//                                 fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                   )),
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                   child: RichText(
//                     text: TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: '(密友',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 color: ColorUtil.fromHex('#999999'))),
//                         TextSpan(
//                             text: '$level',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 color: ColorUtil.fromHex('#FF4589'))),
//                         TextSpan(
//                             text: '级差',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 color: ColorUtil.fromHex('#999999'))),
//                         TextSpan(
//                             text: '${redcode}红豆',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 color: ColorUtil.fromHex('#FF4589'))),
//                         TextSpan(
//                             text: ')',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 color: ColorUtil.fromHex('#999999'))),
//                       ],
//                     ),
//                   )),
//               Container(
//                   padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                   child: Text('语音/视频聊天更有趣！主动向ta发起吧～',
//                       style: TextStyle(
//                           fontSize: 12, color: ColorUtil.fromHex('#999999')))),
//               BasicDialog.getButton('视频聊', () {
//                 Navigator.pop(context);
//                 StorageUtil.setData(showMiyouLevelUpdate, true);
//                 videoCallBack();
//               }),
//               BasicDialog.getBorderButton('语音聊', () {
//                 Navigator.pop(context);
//                 StorageUtil.setData(showMiyouLevelUpdate, true);
//                 voiceCallBack();
//               }),
//             ],
//           );
//         });
//   }
//
//   // 对话警告弹窗
//   static showConversitionAlertDialog(context) async {
//     var show = await StorageUtil.getData(showConversitionAlert);
//     if (show != null) {
//       return;
//     }
//
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return BasicDialog(
//             widgets: [
//               BasicDialog.getCancelBtn(context),
//               Container(
//                   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                   child: RichText(
//                     text: TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: '(为保护个人隐私及维护平台绿色环境，视频聊天',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: ColorUtil.fromHex('#000000'))),
//                         TextSpan(
//                             text: '严禁涉黄',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: ColorUtil.fromHex('#FF4589'))),
//                         TextSpan(
//                             text: '。一旦平台收到用户举报，核实后，一律',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: ColorUtil.fromHex('#000000'))),
//                         TextSpan(
//                             text: '封号处理',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: ColorUtil.fromHex('#FF4589'))),
//                         TextSpan(
//                             text: '。',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: ColorUtil.fromHex('#000000'))),
//                       ],
//                     ),
//                   )),
//               GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                       width: double.infinity,
//                       margin: EdgeInsets.fromLTRB(20, 48, 20, 12),
//                       padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // Checkbox(value: true, onChanged: (val) {}),
//                           Container(
//                               margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
//                               child: Center(
//                                 child: Image.asset('assets/images/c_check.png',
//                                     width: 16, fit: BoxFit.fitWidth),
//                               )),
//                           Container(
//                               margin: EdgeInsets.fromLTRB(4, 0, 0, 0),
//                               child: Text('以后不再提醒',
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: ColorUtil.fromHex('#000000')))),
//                         ],
//                       ))),
//               BasicDialog.getButton('确认', () {
//                 StorageUtil.setData(showConversitionAlert, true);
//                 Navigator.pop(context);
//               }),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
//               ),
//             ],
//           );
//         });
//   }
//
//   // 获得学分弹窗
//   static showEarnScoreDialog(context, score) {
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return BasicDialog(
//             widgets: [
//               BasicDialog.getCancelBtn(context),
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                   child: Center(
//                     child: Image.asset('assets/images/earnscore.png',
//                         width: 120, height: 129, fit: BoxFit.fitWidth),
//                   )),
//               Container(
//                   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                   child: RichText(
//                     text: TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: '(恭喜获得',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: ColorUtil.fromHex('#000000'))),
//                         TextSpan(
//                             text: '$score礼金',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: ColorUtil.fromHex('#FF4589'))),
//                         TextSpan(
//                             text: '奖励',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: ColorUtil.fromHex('#000000'))),
//                       ],
//                     ),
//                   )),
//               Container(
//                   padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                   child: Text('（奖励已自动发放至钱包）',
//                       style: TextStyle(
//                           fontSize: 14, color: ColorUtil.fromHex('#999999')))),
//               BasicDialog.getButton('知道了', () {
//                 Navigator.pop(context);
//               }),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
//               ),
//             ],
//           );
//         });
//   }
//
//   // 能量升级弹窗
//   static showEngerUpgradeDialog(context, level) {
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return BasicDialog(
//             widgets: [
//               BasicDialog.getCancelBtn(context),
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                   child: Center(
//                     child: Image.asset('assets/images/engerupgrade.png',
//                         width: 120, height: 129, fit: BoxFit.fitWidth),
//                   )),
//               Container(
//                   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                   child: RichText(
//                     text: TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: '(恭喜升级到能量',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: ColorUtil.fromHex('#000000'))),
//                         TextSpan(
//                             text: '$level',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: ColorUtil.fromHex('#FF4589'))),
//                         TextSpan(
//                             text: '级)',
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: ColorUtil.fromHex('#000000'))),
//                       ],
//                     ),
//                   )),
//               BasicDialog.getButton('确认', () {
//                 Navigator.pop(context);
//               }),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
//               ),
//             ],
//           );
//         });
//   }
//
//   // 签到奖励领取成功弹窗
//   static showSignInGiftTakenDialog(context, money, shareCallback) {
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return BasicDialog(
//             widgets: [
//               BasicDialog.getCancelBtn(context),
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                   child: Center(
//                     child: Image.asset('assets/images/lijing.png',
//                         width: 120, height: 129, fit: BoxFit.fitWidth),
//                   )),
//               Container(
//                   padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                   child: Text('恭喜成功领取奖励',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black))),
//               Container(
//                   padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                   child: Text('$money礼金',
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: ColorUtil.fromHex('#FF4589')))),
//               BasicDialog.getButton('分享到朋友圈', () {
//                 Navigator.pop(context);
//                 shareCallback();
//               }),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
//               ),
//             ],
//           );
//         });
//   }
//
//   // 更换头像
//   static showChangeAvatarDialog(context, callBack) {
//     var show = StorageUtil.getData(showConversitionAlert);
//     print(show);
//     // if (show = null) {
//     //   return;
//     // }
//
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return BasicDialog(
//             widgets: [
//               BasicDialog.getCancelBtn(context),
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                   child: Center(
//                     child: Image.asset('assets/images/header_pic.png',
//                         width: 120, height: 129, fit: BoxFit.fitWidth),
//                   )),
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
//                   child: Text('亲爱的小姐姐',
//                       style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold))),
//               Container(
//                   margin: EdgeInsets.fromLTRB(20, 4, 20, 0),
//                   child: RichText(
//                     text: TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: '你上传的',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: ColorUtil.fromHex('#000000'))),
//                         TextSpan(
//                             text: '头像不清晰',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: ColorUtil.fromHex('#FF4589'))),
//                         TextSpan(
//                             text: '或',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: ColorUtil.fromHex('#000000'))),
//                         TextSpan(
//                             text: '头像不清晰',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: ColorUtil.fromHex('#FF4589'))),
//                       ],
//                     ),
//                   )),
//               Container(
//                   margin: EdgeInsets.fromLTRB(20, 4, 20, 0),
//                   child: RichText(
//                     text: TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: '建议你更换为',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: ColorUtil.fromHex('#000000'))),
//                         TextSpan(
//                             text: '本人高清照片',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: ColorUtil.fromHex('#FF4589'))),
//                       ],
//                     ),
//                   )),
//               Container(
//                   margin: EdgeInsets.fromLTRB(20, 4, 20, 0),
//                   child: RichText(
//                     text: TextSpan(
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: '这样就有',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: ColorUtil.fromHex('#000000'))),
//                         TextSpan(
//                             text: '帅哥主动找你聊天啦！',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: ColorUtil.fromHex('#FF4589'))),
//                       ],
//                     ),
//                   )),
//               Container(
//                   padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
//                   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                   child: Text('（上传6张本人高清照片，奖励200能量）',
//                       style: TextStyle(
//                           fontSize: 13, color: ColorUtil.fromHex('#999999')))),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 42, 0, 0),
//               ),
//               BasicDialog.getSepratorLine(),
//               BasicDialog.getConfirmBttnon(context, '更换头像', '稍后再说', () {
//                 callBack();
//               }, () {}),
//             ],
//           );
//         });
//   }
//
//   // 用户使用确认
//   static showUserConfirmDialog(context, confirmCallback) {
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return BasicDialog(
//             widgets: [
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
//                   child: Text('欢迎使用APP',
//                       style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold))),
//               Container(
//                   margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                   padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
//                   child: RichText(
//                     text: TextSpan(
//                       children: <TextSpan>[
//                         const TextSpan(
//                             text: '在使用APP前，请你认真阅读并了解',
//                             style:
//                                 TextStyle(fontSize: 15, color: Colors.black)),
//                         TextSpan(
//                             text: '《用户协议》',
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Navigator.push(context,
//                                     MaterialPageRoute(builder: (context) {
//                                   return CusWebview(data: {
//                                     'url': 'assets/files/agreement.html',
//                                     'title': '用户协议',
//                                     'fromLocal': 1
//                                   });
//                                 }));
//                               },
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 color: ColorUtil.fromHex('#FF4589'))),
//                         const TextSpan(
//                             text: '和',
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: Colors.black,
//                             )),
//                         TextSpan(
//                             text: '《隐私政策》',
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Navigator.push(context,
//                                     MaterialPageRoute(builder: (context) {
//                                   return CusWebview(data: {
//                                     'url': 'assets/files/privcy.html',
//                                     'title': '隐私政策',
//                                     'fromLocal': 1
//                                   });
//                                 }));
//                               },
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 color: ColorUtil.fromHex('#FF4589'))),
//                         TextSpan(
//                             text: '，点击同意即表示你已阅读并同意全部条款',
//                             style:
//                                 TextStyle(fontSize: 15, color: Colors.black)),
//                       ],
//                     ),
//                   )),
//               BasicDialog.getSepratorLine(),
//               BasicDialog.getConfirmBttnon(context, '确定', '退出', confirmCallback,
//                   () async {
//                 exit(0);
//               })
//             ],
//           );
//         });
//   }
//
//   // 用户注销确认
//   static showUserDestoryConfirmDialog(context, confirmCallback) {
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return BasicDialog(
//             widgets: [
//               Container(
//                   width: double.infinity,
//                   height: 430,
//                   child: CustomScrollView(
//                     shrinkWrap: true,
//                     slivers: <Widget>[
//                       new SliverPadding(
//                         padding: const EdgeInsets.all(0.0),
//                         sliver: new SliverList(
//                           delegate: new SliverChildListDelegate([
//                             Container(
//                                 alignment: Alignment.centerLeft,
//                                 margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                                 child: Text('注销账号不可恢复的操作，请仔细阅读以下内容，注销后，你的账号将：',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black,
//                                     ))),
//                             Container(
//                                 alignment: Alignment.centerLeft,
//                                 margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                                 child: Text(
//                                     '1.无法登陆，包括授权登录其他第三方应用，你的好友无法再与你取得联系（包括关注，粉色，群组等）；',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black,
//                                     ))),
//                             Container(
//                                 alignment: Alignment.centerLeft,
//                                 margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                                 child: Text(
//                                     '2.所有信息将被永久删除（动态、密友圈等内容），你的个人资料和历史信息（包括昵称、头像、签名、相册、消息记录、密友圈内容等）都将无法找回；',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black,
//                                     ))),
//                             Container(
//                                 alignment: Alignment.centerLeft,
//                                 margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                                 child: Text(
//                                     '3.绑定的手机/微信账号将会解绑，解绑后可再次注册APP；你的实名信息会解绑，解绑后可以再次绑定其他账号；',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black,
//                                     ))),
//                             Container(
//                                 alignment: Alignment.centerLeft,
//                                 margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                                 child: Text(
//                                     '4.我的钱包余额注销后将会被全部清零（包括：红豆，礼金，甜心，虚拟礼物，请注意已充值的虚拟币是不可以退款的，你可以进行消费后再进行注销，或者直接舍弃）；',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black,
//                                     ))),
//                             Container(
//                                 alignment: Alignment.centerLeft,
//                                 margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                                 child: Text(
//                                     '5.我的收益余额注销后将会被全部清零（包括：红豆，礼金，甜心，虚拟礼物），聊天和虚拟礼物当日收入需要次日提现后才能注销，如你强制进行注销，视同放弃所有收益；',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black,
//                                     ))),
//                             Container(
//                                 alignment: Alignment.centerLeft,
//                                 margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                                 child: Text(
//                                     '6.在账号注销期间，如果你的账号被他人投诉、被国家机关调查或正处于诉讼、仲裁程序中，我们有权自行终止你账号的注销进程而无需另行得到你的同意；',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black,
//                                     ))),
//                             Container(
//                                 alignment: Alignment.centerLeft,
//                                 margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                                 child: Text(
//                                     '7.请注意，注销你的账号并不代表本账号注销前的账号行为和相关责任得到豁免或减轻。',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.black,
//                                     ))),
//                             Container(
//                                 alignment: Alignment.centerLeft,
//                                 margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                                 child:
//                                     Text('以上条款你均同意无异议，即可在帮助与咨询页面联系客服，进行注销账号操作。',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           color: Colors.black,
//                                         ))),
//                           ]),
//                         ),
//                       )
//                     ],
//                   )),
//               BasicDialog.getSepratorLine(),
//               BasicDialog.getConfirmBttnon(
//                   context, '确定注销', '我再想想', confirmCallback, () async {
//                 //  Navigator.pop(context);
//               })
//             ],
//           );
//         });
//   }
//
//   // 确认弹窗
//   static showConfirmDialog(context, title, content, confirmText, cancelText,
//       confirmCallback, cancelCallback,
//       {Widget? otherText, otherCallBack}) {
//     showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return BasicDialog(
//             widgets: [
//               title != null && title?.length > 0
//                   ? Container(
//                       margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
//                       child: Text('$title',
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold)))
//                   : Container(
//                       margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
//                     ),
//               content != null && content?.length > 0
//                   ? Container(
//                       margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
//                       padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                       child: otherText != null
//                           ? otherText
//                           : Text('$content',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.black,
//                               )))
//                   : Container(),
//               BasicDialog.getSepratorLine(),
//               BasicDialog.getConfirmBttnon(context, confirmText, cancelText,
//                   confirmCallback, cancelCallback)
//             ],
//           );
//         });
//   }
//
//   // 来电是否接通界面
//   static showCallDialog(context, info) async {
//     var type = int.parse(info['type']);
//     var user = info['user'];
//     user['id'] = 1;
//     user['gender_type'] = 1;
//     var token = info['token'];
//     var channelName = info['channel'];
//     var currentTime = info['token']['current_time'] * 1000;
//
//     var dateTime = DateTime.now().millisecondsSinceEpoch;
//     if (dateTime - currentTime > 40 * 1000) {
//       return;
//     }
//
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return Container();
//         });
//   }
//
//   // 系统的acthonsheet
//   static showActhonSheetDialog(
//       context, List<String> actions, callBack(title, index)) {
//     List<Widget> list = [];
//     var index = 0;
//     actions.forEach((title) {
//       list.add(CupertinoActionSheetAction(
//         child: Text(
//           title,
//           style: TextStyle(color: Colors.black, fontSize: 15),
//         ),
//         onPressed: () {
//           callBack(title, index);
//           Navigator.pop(context);
//         },
//         isDefaultAction: true,
//       ));
//       index++;
//     });
//
//     showCupertinoModalPopup(
//         context: context,
//         builder: (context) {
//           return CupertinoActionSheet(
//             // title: title,
//             // message: content,
//             actions: list,
//           );
//         });
//   }
// }
