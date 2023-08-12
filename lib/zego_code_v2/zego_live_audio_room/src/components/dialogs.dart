// Dart imports:
import 'dart:core';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/widgets/dialogs.dart';


Future<bool> showLiveDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String leftButtonText,
  required VoidCallback leftButtonCallback,
  required String rightButtonText,
  required VoidCallback rightButtonCallback,
}) async {
  return showAlertDialog(
    context,
    title,
    content,
    [
      CupertinoDialogAction(
        onPressed: leftButtonCallback,
        child: Text(
          leftButtonText,
          style: TextStyle(
            fontSize: 32.r,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      CupertinoDialogAction(
        onPressed: rightButtonCallback,
        child: Text(
          rightButtonText,
          style: TextStyle(
            fontSize: 32.r,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
    titleStyle: TextStyle(
      fontSize: 32.0.r,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    contentStyle: TextStyle(
      fontSize: 28.0.r,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    actionsAlignment: MainAxisAlignment.spaceEvenly,
    backgroundColor: const Color(0xff111014).withOpacity(0.8),
  );
}
