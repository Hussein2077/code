import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';


class EmptyWidget extends StatelessWidget {
  final String message;
  final double? height;
  const EmptyWidget({required this.message, super.key, this.height,  });

  @override
  Widget build(BuildContext context) {
    return
      Center(
        child: Container(
          height: ConfigSize.screenHeight!*0.7,
          alignment: Alignment.center,
          color: Colors.white,
          child: Text(
            message,
            style: TextStyle(
                color: Colors.black, fontSize: ConfigSize.defaultSize! * 2),
          ),
        ),
      )

    ;
  }
}