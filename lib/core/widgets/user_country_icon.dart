

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class UserCountryIcon extends StatelessWidget {
  final String country ; 
  const UserCountryIcon({required this.country, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 6),
    
      decoration: BoxDecoration(color:Colors.grey.withOpacity(0.5) , borderRadius: BorderRadius.circular(ConfigSize.defaultSize!) ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
       Text(country , style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*0.8),)
      ],),
    );
  }
}