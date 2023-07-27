import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ProfileBottomBar extends StatelessWidget {
  const ProfileBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ConfigSize.defaultSize!*6,
      decoration:  BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        bottomBarColumn(context: context , icon: AssetsPath.chatIconProfile),
                bottomBarColumn(context: context , icon: AssetsPath.sendGiftIconProfile , title: StringManager.sendGift),

        bottomBarColumn(context: context , icon: AssetsPath.friendRequestIconProfile ,title: StringManager.addFriend),

        bottomBarColumn(context: context , icon: AssetsPath.followIcon ,title: StringManager.follow),

    

      ],),
    );
  }
}


Widget bottomBarColumn ({required BuildContext context ,  required String icon , String?title }){
  return Column(children: [
    title!=null?
   Image.asset(icon , scale: 2.5,):Container(
    padding: EdgeInsets.only(left: ConfigSize.defaultSize!*6 , top: ConfigSize.defaultSize!*1.2),
    width: ConfigSize.defaultSize!*11, 
   height: ConfigSize.defaultSize!*5,
    decoration: BoxDecoration(image:DecorationImage(image:  AssetImage(icon ,)) ),
   child: Text(StringManager.chat , style: TextStyle(color: Colors.white, fontSize: ConfigSize.defaultSize!*1.5),),),
   if(title!=null)
   Text(title , style: Theme.of(context).textTheme.bodySmall,)

  ],);

}

