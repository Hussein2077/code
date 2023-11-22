import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

Future<void> dailogRoom({
  required BuildContext context,
  required Widget widget,
  Color? color,
}) {
  return showGeneralDialog(
      context: context,
      barrierLabel: "",
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return fromBottom(animation, secondaryAnimation, child);
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: const Alignment(0, 1),
          child: Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
              side: const BorderSide(color: Colors.blue, width: 1),
            ),
            color: color ?? Colors.white,
            type: MaterialType.transparency,
            child: widget,
          ),
        );
      });
}

fromBottom(Animation<double> animation, Animation<double> secondaryAnimation,
    Widget child) {
  return SlideTransition(
      position: Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, 1.0))
          .animate(animation),
      child: child);
}
