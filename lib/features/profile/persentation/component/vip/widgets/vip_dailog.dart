

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';

class VipDailog extends StatelessWidget {
    final String headerText;
  final String image;
  final String title ; 
  const VipDailog({required this.title ,  required this.headerText , required this.image ,   super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
        height: ConfigSize.defaultSize!*28,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
           colors: ColorManager.bageGriedinet
          ),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
        ),
        child: Column(
          children: [
const Spacer(flex: 1,),
            Text(headerText , style: Theme.of(context).textTheme.bodyLarge,),
       const Spacer(flex: 1,),

     CustoumCachedImage(url: image, height: ConfigSize.defaultSize!*12, width: ConfigSize.defaultSize!*12),
       const Spacer(flex: 1,),
            Text(title , style: Theme.of(context).textTheme.bodyMedium,),

       
            const Spacer(flex: 3,),

       InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Text(StringManager.done , style: Theme.of(context).textTheme.bodyMedium,)
                ),
            const Spacer(flex: 1,),


          ],
        ),
      ),
    );
  }
}