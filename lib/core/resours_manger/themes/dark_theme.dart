
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';

ThemeData darkTheme = ThemeData(
  textTheme:  TextTheme(
    headlineLarge: const TextStyle(
      fontFamily: 'ElMessiri',
      fontSize:20,
      color: Colors.white,
    ),
    headlineMedium:  const TextStyle(
      fontFamily: 'ElMessiri',
      fontSize: 18,
      color: Colors.white,
    ),
   bodyLarge: 
    const TextStyle(
      fontFamily: 'ElMessiri',
      fontSize:16,
      color: Colors.white,
    ),
     bodyMedium:const TextStyle(
      fontFamily: 'ElMessiri',
      fontSize: 14,
      color: Colors.white,
    ), 
      bodySmall:const TextStyle(
      fontFamily: 'ElMessiri',
      fontSize: 12,
      color: Colors.white,
    ), 
    titleMedium: TextStyle(
      fontFamily: 'ElMessiri',
      fontSize: 16,
      color: Colors.white.withOpacity(0.4),
    ), 
       titleSmall: TextStyle(
      fontFamily: 'ElMessiri',
      fontSize: 12,
      color: Colors.white.withOpacity(0.4),
    ), 

   
  ),
  fontFamily: 'ElMessiri',
  brightness: Brightness.dark ,
  colorScheme:  const ColorScheme.dark(
    background: Colors.black , 
    primary: ColorManager.whiteColor,
    secondary: Color(0xFF242424),
    
    

  )
);
