// import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoPlayerView {
//   VideoPlayerController videoPlayerController;
//   ChewieController _chewieController;
//   var playState = 0;
//
//   getView(context, url, autoPlay, callback) {
//
//     videoPlayerController = VideoPlayerController.network(url);
//     _chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       aspectRatio: 2 / 1,
//       autoInitialize: true,
//       showControlsOnInitialize: true,
//       autoPlay: autoPlay,
//     );
//
//     _chewieController.addListener(() {
//       // print(_chewieController.isFullScreen);
//
//       callback(_chewieController.isFullScreen);
//
//       videoPlayerController.play();
//     });
//
//     return Positioned(child: Chewie(controller: _chewieController));
//
//     // var viewlist = [Positioned(child: Chewie(controller: _chewieController))];
//     var image = Image.asset(
//       'assets/images/play_btn.png',
//       width: 40,
//     );
//
//     // if (playState == 0) {
//     //   viewlist.add(Positioned(
//     //       top: (233 - 40) / 2,
//     //       left: (width - 40) / 2,
//     //       child: GestureDetector(
//     //           onTap: () {
//     //             playState = 1;
//     //             videoPlayerController.play();
//
//     //             click(playState);
//     //           },
//     //           child: image)));
//     // }
//     // else if (playState == 1) {
//     //   viewlist.add(Positioned(
//     //       top: (233 - 40) / 2,
//     //       left: (width - 40) / 2,
//     //       child: GestureDetector(
//     //           onTap: () {
//     //             playState = 1;
//     //             videoPlayerController.play();
//     //           },
//     //           child: Container())));
//     // }
//
//     // return viewlist;
//   }
//
//   static Element findChild(Element e, Widget w) {
//     Element child;
//     void visit(Element element) {
//       if (w == element.widget)
//         child = element;
//       else
//         element.visitChildren(visit);
//     }
//
//     visit(e);
//     return child;
//   }
// }
