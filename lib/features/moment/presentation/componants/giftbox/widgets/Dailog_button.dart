import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Future<void> dailogbutton(BuildContext context, Widget widget) {
  return showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 400),
      barrierColor: Colors.transparent,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return fromBottom(animation, secondaryAnimation, child);
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: const  Alignment(
              0.45,.9),
          child: Material(
            type: MaterialType.transparency,
            child: widget,
          ),
        );
      });
}

fromBottom(Animation<double> animation, Animation<double> secondaryAnimation,
    Widget _child) {
  return SlideTransition(
      child: _child,
      position: Tween<Offset>(end: Offset.zero, begin: const  Offset(0, 0))
          .animate(animation));
}
