// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:inview_notifier_list/inview_notifier_list.dart';
// import 'package:tik_chat_v2/core/utils/config_size.dart';
// import 'package:tik_chat_v2/features/reels/persentation/reel_v2/vedio_widget.dart';
//
// class VideoList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return InViewNotifierList(
//           scrollDirection: Axis.vertical,
//         //  initialInViewIds: ['0'],
//           isInViewPortCondition:
//               (double deltaTop, double deltaBottom, double viewPortDimension) {
//             log("deltaTop :${deltaTop}");
//             log('deltaBottom : ${deltaBottom}');
//             if(deltaTop < (0.5 * viewPortDimension) &&
//                 deltaBottom > (0.5 * viewPortDimension)){
//               log("ttttttttt");
//             }
//
//             return deltaTop < (0.5 * viewPortDimension) &&
//                 deltaBottom > (0.5 * viewPortDimension);
//           },
//           builder: (BuildContext context,index){
//             return Container(
//               width: double.infinity,
//               height: ConfigSize.screenHeight!-150,
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(vertical: 10.0),
//               child: LayoutBuilder(
//
//                 builder: (BuildContext context, BoxConstraints constraints) {
//                   final InViewState? inViewState =
//                   InViewNotifierList.of(context);
//
//                   inViewState?.addContext(context: context, id: '$index');
//
//                   return AnimatedBuilder(
//                     animation: inViewState!,
//                     builder: (context, child)  {
//                       return VideoWidget(
//                           play: inViewState.inView('$index'),
//                           url:
//                           'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
//                     },
//                   );
//                 },
//
//               ),
//             ) ;
//           },
//           itemCount: 3,
//
//         );
//   }
// }