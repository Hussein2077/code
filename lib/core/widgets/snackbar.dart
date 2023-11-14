

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

SnackBar custoumSnackBar (String content){
  return SnackBar(
    margin: EdgeInsets.only(
        bottom: ConfigSize.screenHeight! - 100,
        right: 20,
        left: 20),
    behavior: SnackBarBehavior.floating,

    content:Text(content),
  );
}