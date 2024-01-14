
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';






//todo pass var here
ThemeData lightTheme = ThemeData(
    textTheme:  TextTheme(
    headlineLarge: const TextStyle(
      fontFamily: 'GothamMedium',
      fontSize:20,
      color: Colors.black,
      overflow: TextOverflow.ellipsis
    ),
    headlineMedium:  const TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 18,
      color: Colors.black,
            overflow: TextOverflow.ellipsis

    ),
    
    bodyLarge: const TextStyle(
      fontFamily: 'GothamMedium',
      fontSize:16,
      color: Colors.black,
            overflow: TextOverflow.ellipsis

    ),
     bodyMedium:const TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 14,
      color: Colors.black,
            overflow: TextOverflow.ellipsis

    ), 
      bodySmall:const TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 12,
      color: Colors.black,
            overflow: TextOverflow.ellipsis

    ), 

titleMedium: TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 16,
      color: Colors.black.withOpacity(0.4),
            overflow: TextOverflow.ellipsis

    ), 
 titleSmall: TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 12,
      color: Colors.black.withOpacity(0.4),
            overflow: TextOverflow.ellipsis

    ), 
   
  ),
  fontFamily: 'GothamMedium',
  brightness: Brightness.light ,
  colorScheme:  const ColorScheme.light(
    background: Colors.white , 
    primary: Colors.black,
    secondary: ColorManager.lightGray

  )
);



