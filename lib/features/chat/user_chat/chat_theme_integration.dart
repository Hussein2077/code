
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart' as cometchat;
import 'package:flutter/material.dart';




class ChatThemeIntegration{

  // cometchat.Typography typography = fl.Typography.fromDefault(
  //     name: FontStyle(fontSize: 22, fontWeight: FontWeight.w400));
  final Palette _palette =
  const Palette(accent: PaletteModel(light: Colors.white, dark: Colors.black));
  final cometchat.Typography typography = cometchat.Typography.fromDefault();
}



