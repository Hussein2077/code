

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class ProfileRowItem extends StatelessWidget {
  final String title ; 
  final String image ;
 final void Function()? onTap;

  const ProfileRowItem({this.onTap,  required this.image , required this.title ,  super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Row(children: [
    const Spacer(flex: 1,),
      Image.asset(image , scale: 2.5,) , 
      const Spacer(flex: 1,),
    
      Text(title , style:  Theme.of(context).textTheme.bodyLarge,),
      const Spacer(flex: 20,),
    
      Icon(Icons.arrow_forward_ios , color: Theme.of(context).colorScheme.primary, size: ConfigSize.defaultSize!*1.4,),
    const Spacer(flex: 1,),
    
    
      ],),
    );
  }
}