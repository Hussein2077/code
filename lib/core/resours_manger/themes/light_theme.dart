import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';

ThemeData lightTheme = ThemeData(
    textTheme:  TextTheme(
    headlineLarge: const TextStyle(
      fontFamily: 'ElMessiri',
      fontSize:20,
      color: Colors.black,
    ),
    headlineMedium:  const TextStyle(
      fontFamily: 'ElMessiri',
      fontSize: 18,
      color: Colors.black,
    ),
    
    bodyLarge: 
    const TextStyle(
      fontFamily: 'ElMessiri',
      fontSize:16,
      color: Colors.black,
    ),
     bodyMedium:const TextStyle(
      fontFamily: 'ElMessiri',
      fontSize: 14,
      color: Colors.black,
    ), 
      bodySmall:const TextStyle(
      fontFamily: 'ElMessiri',
      fontSize: 12,
      color: Colors.black,
    ), 

titleMedium: TextStyle(
      fontFamily: 'ElMessiri',
      fontSize: 16,
      color: Colors.black.withOpacity(0.4),
    ), 
    titleSmall: TextStyle(
      fontFamily: 'ElMessiri',
      fontSize: 12,
      color: Colors.black.withOpacity(0.4),
    ), 
   
  ),
  fontFamily: 'ElMessiri',
  brightness: Brightness.light ,
  colorScheme:  const ColorScheme.light(
    background: Colors.white , 
    primary: Colors.black,
    secondary: ColorManager.lightGray

  )
);