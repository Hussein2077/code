import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class EditFeaturesContainer extends StatelessWidget{
  List<String> roomFeaturesTitles = [
    StringManager.lockChat.tr(),
    StringManager.lockRoom.tr(),
    StringManager.music2.tr(),
    StringManager.addAmin2.tr(),
    StringManager.blockList.tr(),
  ];
  List<String> roomFeaturesIcons = [
    AssetsPath.chatLock,
    AssetsPath.lockRoom,
    AssetsPath.music2,
    AssetsPath.addAdmin,
    AssetsPath.blockedUsers,
  ];



  List<Function()?> roomFeaturesOnTaps = [
    () {},
() {},
() {},
() {},
() {},
];
  @override
  Widget build(BuildContext context) {
 return   SizedBox(
   height: ConfigSize.defaultSize! * 22,
   width: ConfigSize.defaultSize! * 41,
   child: GridView.builder(
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 4, // Number of columns in the grid
       mainAxisSpacing: ConfigSize.defaultSize! * 0.7,
       crossAxisSpacing: ConfigSize.defaultSize! * 0.7,
     ),
     itemCount: 5, // Total number of items in the grid
     itemBuilder: (context, index) {
       return Container(
           width: ConfigSize.defaultSize! * 0.8,
           height: ConfigSize.defaultSize! * 0.8,
           padding:
           EdgeInsets.all(ConfigSize.defaultSize! * 0.5),
           decoration: BoxDecoration(
             borderRadius:
             BorderRadius.circular(ConfigSize.defaultSize!),
             color: Theme.of(context)
                 .colorScheme
                 .primary
                 .withOpacity(0.1),
           ),
           alignment: Alignment.center,
           child: InkWell(
             onTap: roomFeaturesOnTaps[index],
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SizedBox(
                   height: ConfigSize.defaultSize! * 5,
                   width: ConfigSize.defaultSize! * 5,
                   child: Image.asset(
                     roomFeaturesIcons[index],
                     color:
                     Theme.of(context).colorScheme.primary,
                   ),
                 ),
                 SizedBox(
                   height: ConfigSize.defaultSize! * 0.1,
                   width: ConfigSize.defaultSize! * 0.1,
                 ),
                 Text(roomFeaturesTitles[index],
                     style: Theme.of(context)
                         .textTheme
                         .bodyMedium!
                         .copyWith(
                         fontSize:
                         ConfigSize.defaultSize! * 1.5)),
               ],
             ),
           ));
     },
   ),
 );

  }


}