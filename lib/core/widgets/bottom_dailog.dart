import 'package:flutter/material.dart';

Future<void> bottomDailog({
  required BuildContext context,
  required Widget widget,
  Color? color,
  double?height,
}) {
  return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 400),
      barrierColor: Colors.black.withOpacity(0.3),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return fromBottom(animation, secondaryAnimation, child);
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: const Alignment(0, 1),
          child: SizedBox(
            height: height,

            child: Material(
              type: MaterialType.transparency,
              child: widget,
            ),
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
