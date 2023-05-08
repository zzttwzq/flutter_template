// import 'package:prxdchatApp/utils/Utils.dart';
// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view_gallery.dart';
//
// class PicScrollView {
//   getSize(url) async {
//     var resize = NetworkImage(url);
//     resize
//         .resolve(new ImageConfiguration())
//         .addListener(new ImageStreamListener((ImageInfo info, bool _) {
//       print(info.image.width);
//       print(info.image.height);
//     }));
//   }
//
//   getView(context, images, index, changed) {
//     PageController controller = PageController(initialPage: index,keepPage: false);
//     final size = MediaQuery.of(context).size;
//     int width = size.width.toInt();
//     return Stack(
//       children: <Widget>[
//         Positioned(
//           child: Container(
//               child: PhotoViewGallery.builder(
//             scrollPhysics: const BouncingScrollPhysics(),
//             builder: (BuildContext context, int index) {
//               return PhotoViewGalleryPageOptions(
//                   flag: 0,
//                   imageProvider: NetworkImage(images[index]));// ResizeImage(NetworkImage(images[index]), width: size.width.toInt(), height:(size.width * 0.667) .toInt()));
//             },
//             transitionOnUserGestures: true,
//             itemCount: images.length,
//             loadingChild: Container(
//               color: ColorUtil.fromHex('#f4f4f4'),
//             ),
//             pageController: controller,
//             onPageChanged: (index) {
//               changed(index);
//             },
//             scaleStateChangedCallback: (e) {
//               print(e);
//             },
//           )),
//         ),
//         images.length > 1
//             ? Positioned(
//                 //图片index显示
//                 top: width * (2 / 3.0) - 40,
//                 left: MediaQuery.of(context).size.width - 50,
//                 child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.black45,
//                         borderRadius: BorderRadius.circular(15)),
//                     padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
//                     child: Text("${index + 1}/${images.length}",
//                         style: TextStyle(color: Colors.white, fontSize: 13))),
//               )
//             : Container()
//       ],
//     );
//   }
// }
