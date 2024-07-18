// import 'dart:convert';
// // import 'package:jpush_flutter/jpush_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../ui/DialogFactory.dart';

// class PushService {
//   static initJPUSH(context) async {
//     await Permission.notification.request();

//     // JPush jpush = new JPush();
//     // await jpush.addEventHandler(
//     //   onReceiveNotificationAuthorization: (event) {
//     //     print("flutter onReceiveNotificationAuthorization: $event");
//     //   },
//     //   // 接收通知回调方法。
//     //   onReceiveNotification: (Map<String, dynamic> message) async {
//     //     // print(">>>>>>>>");
//     //     // print("flutter<> onReceiveNotification: $message");

//     //     handleRemoteMessage(context, message);
//     //   },
//     //   // 点击通知回调方法。
//     //   onOpenNotification: (Map<String, dynamic> message) async {
//     //     // print("flutter onOpenNotification: $message");

//     //     handleRemoteMessage(context, message);
//     //   },
//     //   // 接收自定义消息回调方法。
//     //   onReceiveMessage: (Map<String, dynamic> message) async {
//     //     // print("flutter onReceiveMessage: $message");

//     //     handleRemoteMessage(context, message);
//     //   },
//     // );
//     jpush.setup(
//       appKey: "28179cfd4e517a21d01afec9",
//       channel: "developer-default",
//       production: false,
//       debug: false, // 设置是否打印 debug 日志
//     );

//     jpush.applyPushAuthority(
//         new NotificationSettingsIOS(sound: true, alert: true, badge: true));

//     // Platform messages may fail, so we use a try/catch PlatformException.
//     jpush.getRegistrationID().then((rid) {
//       print("flutter get registration id : $rid");
//     });

//     // var isbool = await JPush().isNotificationEnabled();
//     // print('JPUSH_bool：$isbool');

//     // JPush().applyPushAuthority();
//   }

//   static addJPUSHListner(context) async {
//     JPush jpush = new JPush();
//     jpush.addEventHandler(
//       onReceiveNotificationAuthorization: (event) {
//         print("flutter onReceiveNotificationAuthorization: $event");
//         return Future(() => null);
//       },
//       // 接收通知回调方法。
//       onReceiveNotification: (Map<String, dynamic> message) async {
//         // print(">>>>>>>>");
//         print("flutter<> onReceiveNotification: $message");

//         print('>>>>>>>>收到消息拉：$message');
//         print('message消息1：${message['aps']}');
//         print('message消息1：${message['aps'].runtimeType}');
//         print('message消息2：${message['message_body']}');
//         print('message消息2：${message['message_body'].runtimeType}');

//         var messagebody = {};
//         if (message['aps'] != null) {
//           messagebody = message['message_body'];
//           print('message消息:>>1');
//         } else {
//           messagebody = jsonDecode(
//               message['extras']['cn.jpush.android.EXTRA'])['message_body'];
//           print('message消息:>>2');
//         }
//         print('message消息3：${messagebody.runtimeType}');

//         // DialogFactory.showCallDialog(context, messagebody);

//         print('message消息3：$messagebody');

//         // handleRemoteMessage(context, message);
//       },
//       // 点击通知回调方法。
//       onOpenNotification: (Map<String, dynamic> message) async {
//         print("flutter onOpenNotification: $message");

//         print('>>>>>>>>收到消息拉：$message');
//         print('message消息1：${message['aps']}');
//         print('message消息1：${message['aps'].runtimeType}');
//         print('message消息2：${message['message_body']}');
//         print('message消息2：${message['message_body'].runtimeType}');

//         var messagebody = {};
//         if (message['aps'] != null) {
//           messagebody = message['message_body'];
//           print('message消息:>>1');
//         } else {
//           messagebody = jsonDecode(
//               message['extras']['cn.jpush.android.EXTRA'])['message_body'];
//           print('message消息:>>2');
//         }
//         print('message消息3：${messagebody.runtimeType}');

//         // DialogFactory.showCallDialog(context, messagebody);

//         print('message消息3：$messagebody');
//       },
//       // 接收自定义消息回调方法。
//       onReceiveMessage: (Map<String, dynamic> message) async {
//         print("flutter onReceiveMessage: $message");

//         print('>>>>>>>>收到消息拉：$message');
//         print('message消息1：${message['aps']}');
//         print('message消息1：${message['aps'].runtimeType}');
//         print('message消息2：${message['message_body']}');
//         print('message消息2：${message['message_body'].runtimeType}');

//         var messagebody = {};
//         if (message['aps'] != null) {
//           messagebody = message['message_body'];
//           print('message消息:>>1');
//         } else {
//           messagebody = jsonDecode(
//               message['extras']['cn.jpush.android.EXTRA'])['message_body'];
//           print('message消息:>>2');
//         }
//         print('message消息3：${messagebody.runtimeType}');

//         // DialogFactory.showCallDialog(context, messagebody);

//         print('message消息3：$messagebody');
//       },
//     );
//   }

//   static handleRemoteMessage(context, message) {
//     // print('>>>>>>>>收到消息拉：$message');
//     // print('message消息1：${message['aps']}');
//     // print('message消息1：${message['aps'].runtimeType}');
//     // print('message消息2：${message['message_body']}');
//     // print('message消息2：${message['message_body'].runtimeType}');

//     // var messagebody = {};
//     // if (message['aps'] != null) {
//     //   messagebody = message['message_body'];
//     //   print('message消息:>>1');
//     // } else {
//     //   messagebody = jsonDecode(
//     //       message['extras']['cn.jpush.android.EXTRA'])['message_body'];
//     //   print('message消息:>>2');
//     // }
//     // print('message消息3：${messagebody.runtimeType}');

//     // DialogFactory.showCallDialog(context, messagebody);

//     // print('message消息3：$messagebody');
//   }
// }
