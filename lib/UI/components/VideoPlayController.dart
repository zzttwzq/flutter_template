// import 'package:prxdchatApp/components/CusView.dart';
// import 'package:flutter/material.dart';
//
// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoPlayController extends StatefulWidget {
//   final Map data;
//   VideoPlayController({Key key, @required this.data}) : super(key: key);
//
//   @override
//   createState() => new VideoPlayControllerState(data: data);
// }
//
// class VideoPlayControllerState extends CusView {
//   VideoPlayerController videoPlayerController;
//   ChewieController chewieController;
//
//   final Map data;
//   VideoPlayControllerState({Key key, @required this.data});
//
//   @override
//   custValue() {
//     // this.title = "   ";
//   }
//
//   @override
//   custAppBar() {
//     return AppBar(
//       title: Text(''),
//       centerTitle: false,
//       backgroundColor: Colors.black,
//       //右侧按钮图标
//       actions: [
//       ],
//       textTheme: TextTheme(
//           headline6: TextStyle(
//         color: Colors.black,
//         fontSize: 18,
//       )),
//     );
//   }
//
//   @override
//   custView(context) {
//
//     videoPlayerController = VideoPlayerController.network(data['url']);
//     chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       aspectRatio: 3 / 2, //宽高比
//       autoPlay: true, //自动播放
//       looping: false, //循环播放
//     );
//
//     var widget = <Widget>[
//       Positioned(child: Chewie(controller: chewieController))
//     ];
//
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       color: Colors.black,
//       child: Stack(children: widget),
//     );
//   }
//
//   @override
//   void dispose() {
//     /**
//     * 页面销毁时，视频播放器也销毁
//     */
//     videoPlayerController.dispose();
//     super.dispose();
//   }
// }
