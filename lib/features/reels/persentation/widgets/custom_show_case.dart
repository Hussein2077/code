import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class CustomShowcaseWidget extends StatelessWidget {
  final String textInContainer;
  final Widget child;
  final GlobalKey globalKey;
  final void Function()? onTargetClick;
  const CustomShowcaseWidget({
    super.key,
    required this.globalKey,

    required this.child,required this.textInContainer, this.onTargetClick,
  });

  @override
  Widget build(BuildContext context) => Showcase(
        key: globalKey,
        // height: height,
        // width: width,
    descTextStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    ),
    overlayColor:Colors.transparent,
         // container: container??Container(
        //   height: ConfigSize.defaultSize!*1.5,
        //   width: ConfigSize.defaultSize!*1.5,
        //   color: Colors.transparent,
        //   child: const Text("Tab here"),
        // ),
        description: textInContainer,
        child: child,
      );
}
