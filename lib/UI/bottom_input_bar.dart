// import 'package:flutter/material.dart';
//
// import '../utils/color_util.dart';
//
// // ignore: must_be_immutable
// class BottomInputBar extends StatefulWidget {
//   late BottomInputBarDelegate delegate;
//   BottomInputBar(BottomInputBarDelegate d) {
//     delegate = d;
//   }
//
//   @override
//   State<StatefulWidget> createState() {
//     return _BottomInputBarState(delegate);
//   }
// }
//
// class _BottomInputBarState extends State<BottomInputBar> {
//   late BottomInputBarDelegate delegate;
//   late TextField textField;
//   FocusNode focusNode = FocusNode();
//   late InputBarStatus inputBarStatus;
//
//   String message = "";
//   bool isChanged = false;
//   bool isShowVoiceAction = false;
//   bool _isDark;
//
//   final controller = new TextEditingController();
//
//   _BottomInputBarState(BottomInputBarDelegate d) {
//     delegate = d;
//     inputBarStatus = InputBarStatus.Normal;
//
//     textField = TextField(
//       onSubmitted: _submittedMessage,
//       controller: controller,
//       maxLines: 1,
//       decoration: InputDecoration(
//         border: InputBorder.none,
//         fillColor: Color(0x1F000000),
//         contentPadding: EdgeInsets.fromLTRB(6, 0, 15, 8),
//         hintText: '想和Ta说点什么？',
//         hintStyle: TextStyle(
//           color: ColorUtil.fromHex('#999999'),
//           fontSize: 15,
//         ),
//       ),
//       focusNode: focusNode,
//       onChanged: (text) {
//         //内容改变的回调
//         message = text;
//         isChanged = true;
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         _notifyInputStatusChanged(InputBarStatus.Normal);
//       }
//     });
//   }
//
//   void _submittedMessage(String messageStr) {
//     if (messageStr == null || messageStr.length <= 0) {
//       print('不能为空');
//       return;
//     }
//     if (this.delegate != null) {
//       this.delegate.sendText(messageStr);
//     } else {
//       print("没有实现 BottomInputBarDelegate");
//     }
//     this.textField.controller.text = '';
//     this.message = '';
//   }
//
//   switchExt() {
//     InputBarStatus status = InputBarStatus.Normal;
//     _notifyInputStatusChanged(status);
//
//     print("switchExtention");
//     if (focusNode.hasFocus) {
//       focusNode.unfocus();
//     }
//     status = InputBarStatus.Normal;
//     if (this.inputBarStatus != InputBarStatus.Ext) {
//       status = InputBarStatus.Ext;
//     }
//     if (this.delegate != null) {
//       this.delegate.onTapExtButton();
//     } else {
//       print("没有实现 BottomInputBarDelegate");
//     }
//     _notifyInputStatusChanged(status);
//   }
//
//   switchEmoji() {
//     InputBarStatus status = InputBarStatus.Normal;
//     _notifyInputStatusChanged(status);
//
//     print("switchEmoji");
//     if (focusNode.hasFocus) {
//       focusNode.unfocus();
//     }
//     status = InputBarStatus.Normal;
//     if (this.inputBarStatus != InputBarStatus.Emoji) {
//       status = InputBarStatus.Emoji;
//     }
//     _notifyInputStatusChanged(status);
//   }
//
//   switchVoice() {
//     InputBarStatus status = InputBarStatus.Normal;
//     _notifyInputStatusChanged(status);
//
//     print("switchVoice");
//     if (focusNode.hasFocus) {
//       focusNode.unfocus();
//     }
//     status = InputBarStatus.Normal;
//     if (this.inputBarStatus != InputBarStatus.Voice) {
//       status = InputBarStatus.Voice;
//     }
//     _notifyInputStatusChanged(status);
//   }
//
//   switchGift() {
//     InputBarStatus status = InputBarStatus.Normal;
//     _notifyInputStatusChanged(status);
//
//     print("switchGift");
//     if (focusNode.hasFocus) {
//       focusNode.unfocus();
//     }
//     status = InputBarStatus.Normal;
//     if (this.inputBarStatus != InputBarStatus.Gift) {
//       status = InputBarStatus.Gift;
//     }
//     _notifyInputStatusChanged(status);
//   }
//
//   sendMessages() {
//     if (message == null || message.isEmpty || message.length <= 0) {
//       MessageService.toast('消息内容不能为空！');
//       return;
//     }
//     if (this.delegate != null && isChanged) {
//       print(message + '...');
//       this.delegate.sendText(message);
//     } else {
//       print("没有实现 BottomInputBarDelegate");
//     }
//     this.textField.controller.text = '';
//     this.message = '';
//   }
//
//   _onTapVoiceLongPress() {
//     print("_onTapVoiceLongPress");
//   }
//
//   _onTapVoiceLongPressEnd() {
//     print("_onTapVoiceLongPressEnd");
//   }
//
//   void _notifyInputStatusChanged(InputBarStatus status) {
//     this.inputBarStatus = status;
//     if (this.delegate != null) {
//       this.delegate.inputStatusChanged(status);
//     } else {
//       print("没有实现 BottomInputBarDelegate");
//     }
//   }
//
//   ///点击相册 选择图片
//   void _selectPicture() async {
//     String imgPath = await MediaUtil.instance.pickImage();
//     if (imgPath == null) {
//       return;
//     }
//     this.delegate.onTapItemPicture(imgPath);
//   }
//
//   ///点击相机拍照
//   void _takePicture() async {
//     String imgPath = await MediaUtil.instance.takePhoto();
//     if (imgPath == null) {
//       return;
//     }
//     this.delegate.onTapItemCamera(imgPath);
//   }
//
//   ///点击表情item
//   void _selectEmojicon() async {
//     print("_selectEmojicon_");
//     this.delegate.onTapItemEmojicon();
//   }
//
//   ///点击音频item
//   void _makeVoiceCall() async {
//     this.delegate.onTapItemPhone();
//   }
//
//   ///点击文件item
//   void _makeFileCall() async {
//     print("_makeFileCall_");
//     this.delegate.onTapItemFile();
//   }
//
//   ///点击语音消息item
//   void _sendVoiceMessage() async {
//     print("_sendVoiceMessage_");
//     this.delegate.sendVoice('', 0);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _isDark = ThemeUtils.isDark(context);
//     return Container(
//       color: ThemeUtils.isDark(context) ? EMColor.darkAppMain : EMColor.appMain,
//       padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: Container(
//                   child: this.textField,
//                   height: 38,
//                   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                   // decoration: BoxDecoration(
//                   //     color:
//                   //         _isDark ? EMColor.darkBorderLine : EMColor.borderLine,
//                   //     border: new Border.all(color: Colors.black26, width: 0.3),
//                   //     borderRadius: BorderRadius.circular(18)),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   sendMessages();
//                 },
//                 child: Container(
//                   width: 48,
//                   height: 28,
//                   decoration: BoxDecoration(
//                     color: ColorUtil.fromHex('#FF4589'),
//                     borderRadius: BorderRadius.all(Radius.circular(50)),
//                   ),
//                   alignment: Alignment.center,
//                   // shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
//                   child: Image.asset(
//                     'assets/images/send.png',
//                     width: 17,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             width: 48,
//             height: 15,
//           ),
//           Row(
//             children: <Widget>[
//               Expanded(
//                 child: SimpleImageButton(
//                   normalImage: 'assets/images/emoji_un.png',
//                   pressedImage: 'assets/images/emoji_sel.png',
//                   width: 24,
//                   onPressed: () {
//                     switchEmoji();
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: SimpleImageButton(
//                   normalImage: 'assets/images/voice_un.png',
//                   pressedImage: 'assets/images/voice_sel.png',
//                   width: 24,
//                   onPressed: () {
//                     isShowVoiceAction = true;
//                     switchVoice();
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: SimpleImageButton(
//                   normalImage: 'assets/images/gift.png',
//                   pressedImage: 'assets/images/gift_sel.png',
//                   width: 24,
//                   onPressed: () {
//                     switchGift();
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: SimpleImageButton(
//                   normalImage: 'assets/images/add.png',
//                   pressedImage: 'assets/images/add_sel.png',
//                   width: 24,
//                   onPressed: () {
//                     switchExt();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// enum InputBarStatus {
//   Normal, //正常
//   Voice, //语音输入
//   Ext, //扩展栏
//   Gift, //扩展栏
//   Emoji, //扩展栏
// }
//
// abstract class BottomInputBarDelegate {
//   ///输入工具栏状态发生变更
//   void inputStatusChanged(InputBarStatus status);
//
//   ///发送消息
//   void sendText(String text);
//
//   ///发送语音
//   void sendVoice(String path, int duration);
//
//   ///开始录音
//   void startRecordVoice();
//
//   ///停止录音
//   void stopRecordVoice();
//
//   ///点击了加号按钮
//   void onTapExtButton();
//
//   ///点击了相机
//   void onTapItemCamera(String imgPath);
//
//   ///点击了相册
//   void onTapItemPicture(String imgPath);
//
//   ///点击了表情
//   void onTapItemEmojicon();
//
//   ///点击音频
//   void onTapItemPhone();
//
//   ///点击文件
//   void onTapItemFile();
// }
