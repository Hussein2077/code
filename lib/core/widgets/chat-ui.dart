import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart' as cometchat;
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ChatUi {
  Palette palette = Palette(

      primary:PaletteModel(

          light: Colors.deepOrangeAccent,
          dark: Colors.deepOrangeAccent
      )  ,
      accent100:PaletteModel(
          light: Colors.grey.withOpacity(0.3),
          dark: Colors.grey.withOpacity(0.3)
      ) );

  // accent: PaletteModel(
  //     light: Colors.red,
  //     dark: Colors.green));

  cometchat.Typography typography = cometchat.Typography.fromDefault(
      name: FontStyle(
          fontSize: ConfigSize.defaultSize!*1.5,
          fontWeight: FontWeight.w400
      )
  );


  MessageHeaderConfiguration  asad = MessageHeaderConfiguration();
}