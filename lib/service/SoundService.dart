// import 'package:flutter_sound/public/tau.dart';
// import 'package:intl/intl.dart' show DateFormat;
// import 'dart:async';
//
// class SoundService {
//
//   late FlutterSound flutterSound;
//
//   bool _isRecording = false;
//   bool _isPlaying = false;
//   late StreamSubscription _recorderSubscription;
//   late StreamSubscription _dbPeakSubscription;
//   late StreamSubscription _playerSubscription;
//
//   double slider_current_position = 0;
//   double max_duration = 0;
//
//   void prepareSoundService() {
//     // flutterSound = FlutterSound()
//     // ..setSubscriptionDuration(0.01)
//     // ..setDbPeakLevelUpdate(0.8)
//     // ..setDbLevelEnabled(true);
//   }
//
//   //============================
//   // 开始录制
//   void startRecorde(progress) async {
//     String path = await flutterSound.startRecorder();
//     print("数据：$path");
//
//     _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
//       DateTime date = new DateTime.fromMillisecondsSinceEpoch(
//           e.currentPosition.toInt(),
//           isUtc: true);
//       String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
//
//       progress(txt.substring(0, 8), path);
//     });
//   }
//
//   // 结束录制
//   Future<String> stopRecorder() async {
//     try {
//       String result = await flutterSound.stopRecorder();
//       print('停止录音返回结果: $result');
//
//       if (_recorderSubscription != null) {
//         _recorderSubscription.cancel();
//         _recorderSubscription = null;
//       }
//       if (_dbPeakSubscription != null) {
//         _dbPeakSubscription.cancel();
//         _dbPeakSubscription = null;
//       }
//
//       this._isRecording = false;
//
//       return result;
//     } catch (err) {
//       print('stopRecorder error: $err');
//     }
//
//     return null;
//   }
//
//   //============================
//   // 开始播放
//   void startPlayer(soundUrl, progress) async {
//
//     print(soundUrl);
//
//     await RecordAmr.play(soundUrl, (path) {});
//
//     // AudioPlayer.logEnabled = true;
//     // AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
//     // int result = await audioPlayer.play(soundUrl);
//
//     // if (result == 1) {
//     //   success
//     //   audioPlayer.monitorNotificationStateChanges((e) {
//
//     //     // var slider_current_position = e.currentPosition;
//     //     // var max_duration = e.duration;
//     //     //
//     //     // DateTime date = new DateTime.fromMillisecondsSinceEpoch(
//     //     //     e.currentPosition.toInt(),
//     //     //     isUtc: true);
//     //     // String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
//     //     //
//     //     progress(e);
//     //   });
//     //   print('13123');
//     // }
//
//     // String path = await flutterSound.startPlayer(soundUrl);
//
//     MessageService.toast('播放中');
//
//     // try {
//     //   _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
//     //     if (e != null) {
//     //       slider_current_position = e.currentPosition;
//     //       max_duration = e.duration;
//
//     //       DateTime date = new DateTime.fromMillisecondsSinceEpoch(
//     //           e.currentPosition.toInt(),
//     //           isUtc: true);
//     //       String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
//
//     //       progress(txt);
//     //     }
//     //   });
//     // } catch (err) {
//     //   print('error: $err');
//     // }
//   }
//
//   // 结束播放
//   void stopPlayer() async {
//     try {
//       String result = await flutterSound.stopPlayer();
//       print('stopPlayer: $result');
//       if (_playerSubscription != null) {
//         _playerSubscription.cancel();
//         _playerSubscription = null;
//       }
//
//       this._isPlaying = false;
//
//     } catch (err) {
//       print('error: $err');
//     }
//   }
//
//   // 暂停播放
//   void pausePlayer() async {
//     String result = await flutterSound.pausePlayer();
//     print('pausePlayer: $result');
//   }
//
//   // 恢复播放
//   void resumePlayer() async {
//     String result = await flutterSound.resumePlayer();
//     print('resumePlayer: $result');
//   }
//
//   // 寻找播放位置
//   void seekToPlayer(int milliSecs) async {
//     String result = await flutterSound.seekToPlayer(milliSecs);
//     print('seekToPlayer: $result');
//   }
//
//   static getSoundTime(url) async {
//
//     return SoundUtil.getSoundTime(url);
//   }
// }
