import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';


class EmptyWidget extends StatelessWidget {
  final String message;
  final double? height;
  final Color? backgrpundColor;
  final TextStyle? style;
  const EmptyWidget({required this.message, super.key, this.height,this.backgrpundColor ,this.style });

  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Container(
          height: ConfigSize.screenHeight!*0.7,
          alignment: Alignment.center,
          color: backgrpundColor??Colors.white,
          child: Text(
            message,
            style:style?? TextStyle(
                color: Colors.black, fontSize: ConfigSize.defaultSize! * 2),
          ),
        ),
      )

    ;
  }
}