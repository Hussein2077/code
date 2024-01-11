
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';

ThemeData darkTheme = ThemeData(
  textTheme:

  TextTheme(
    headlineLarge: const TextStyle(
      fontFamily: 'GothamMedium',
      fontSize:20,
      color: Colors.white,
            overflow: TextOverflow.ellipsis

    ),
    headlineMedium:  const TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 18,
      color: Colors.white,
            overflow: TextOverflow.ellipsis

    ),
   bodyLarge: 
    const TextStyle(
      fontFamily: 'GothamMedium',
      fontSize:16,
      color: Colors.white,
            overflow: TextOverflow.ellipsis

    ),
     bodyMedium:const TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 14,
      color: Colors.white,
            overflow: TextOverflow.ellipsis

    ), 
      bodySmall:const TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 12,
      color: Colors.white,
            overflow: TextOverflow.ellipsis

    ), 
    titleMedium: TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 16,
      color: Colors.white.withOpacity(0.4),
            overflow: TextOverflow.ellipsis

    ), 
       titleSmall: TextStyle(
      fontFamily: 'GothamMedium',
      fontSize: 12,
      color: Colors.white.withOpacity(0.4),
            overflow: TextOverflow.ellipsis

    ), 

   
  ),
  fontFamily: 'GothamMedium',
  brightness: Brightness.dark ,
  colorScheme:  const ColorScheme.dark(
    background: Colors.black , 
    primary:Colors.white,
    secondary: Color(0xFF242424),
    
    

  )
);
