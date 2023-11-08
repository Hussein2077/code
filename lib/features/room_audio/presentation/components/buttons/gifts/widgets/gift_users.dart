
import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';




class GiftUser extends StatefulWidget {
 // final List<ZegoUIKitUser>  listUsers;
  final List<ZegoUIKitUser> listAllUsers ;
  final String ownerId ;
  const GiftUser({
  required this.listAllUsers , required this.ownerId, super.key});
  static Map<int,SelecteObject>  userSelected = {};
  static ValueNotifier<Map<int, ZegoUIKitUser>> userOnMicsForGifts =
  ValueNotifier<Map<int, ZegoUIKitUser>>({});
  @override
  GiftUserState createState() => GiftUserState();
}


class GiftUserState extends State<GiftUser> {
  int selectUserIndex =-1 ;
  String? selectedValue;
  final List<String> type = [
    'ألكل علي المقاعد',
    'ألكل في الغرفة  ',
  ];
  final List<int> seatsIndex =[];
  @override
  void initState() {
   if( RoomScreen.userOnMics.value.isEmpty){
     GiftUser.userSelected.clear();
   }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  SizedBox(
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: ConfigSize.defaultSize!),
              height: ConfigSize.defaultSize! * 7,
              child:
              ValueListenableBuilder<Map<int, ZegoUIKitUser>>(
                valueListenable: GiftUser.userOnMicsForGifts,
                builder: (context, users, _) {
                  seatsIndex.clear();
                  GiftUser.userOnMicsForGifts.value.forEach((key, value) {
                    if(!seatsIndex.contains(key) ){
                      seatsIndex.add(key);
                    }
                  });
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:seatsIndex.length,
                      itemBuilder: (context, index) {
                        if(users[seatsIndex[index]]?.name
                            == StringManager.mysteriousPerson.tr()){
                          return const  SizedBox();
                        }else{
                          return InkWell(
                            onTap: (){
                              setState(() {
                                if( GiftUser.userSelected.containsKey(seatsIndex[index])){
                                  GiftUser.userSelected.remove(seatsIndex[index]);
                                }else{
                                  GiftUser.userSelected.putIfAbsent(index,
                                          () => SelecteObject(userId:users[index]?.id??'',
                                          selected: true)) ;
                                }
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(3),
                                    width: ConfigSize.defaultSize! * 4,
                                    height: ConfigSize.defaultSize! *4,
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*1.5),
                                      border: Border.all(
                                        width: GiftUser.userSelected.containsKey(index) ?1.5:0,
                                        color: GiftUser.userSelected.containsKey(index) ?
                                        ColorManager.mainColor: Colors.transparent,  // red as border color
                                      ),
                                      //  shape: BoxShape.circle,
                                    ),
                                    child: CustoumCachedImage(
                                      radius: ConfigSize.defaultSize!*2,
                                      width: ConfigSize.defaultSize! *3,
                                      url: users[seatsIndex[index]]?.inRoomAttributes.value['img']??"",
                                      height: ConfigSize.defaultSize! *3,)
                                ),
                                if(RoomScreen.adminsInRoom.containsKey(users[seatsIndex[index]]?.id.toString()))
                                  Positioned(
                                    top: ConfigSize.defaultSize! * 3,
                                    left: ConfigSize.defaultSize! * 1.3,
                                    child: SizedBox(
                                        width: ConfigSize.defaultSize! * 2,
                                        height: ConfigSize.defaultSize! * 1.5,
                                        child: Image.asset(AssetsPath.adminMark)),
                                  ),
                                if(users[seatsIndex[index]]?.id.toString() == widget.ownerId.toString())
                                  Positioned(
                                    top: ConfigSize.defaultSize! * 3,
                                    left: ConfigSize.defaultSize! * 1.3,
                                    child: SizedBox(
                                        width: ConfigSize.defaultSize! * 2,
                                        height: ConfigSize.defaultSize! * 1.5,
                                        child:Image.asset(AssetsPath.hostMark)
                                    ),
                                  ),
                                if(users[seatsIndex[index]]?.id.toString() != widget.ownerId.toString()
                                    &&!RoomScreen.adminsInRoom.containsKey(users[index]?.id.toString()))
                                  Positioned(
                                    top: ConfigSize.defaultSize! * 3,
                                    left: ConfigSize.defaultSize! * 1.3,
                                    child: Container(
                                        width: ConfigSize.defaultSize! * 2,
                                        height: ConfigSize.defaultSize! * 1.5,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorManager.whiteColor),
                                        child:Center(
                                          child: Text(
                                            "${index + 1}",
                                            style:  TextStyle(fontSize: AppPadding.p8),
                                          ),
                                        )
                                    ),
                                  )
                              ],
                            ),
                          );
                        }

                      }) ;
                }
              ),
            ),
           DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: type
                      .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Column(
                        mainAxisAlignment: item ==type[0] ? MainAxisAlignment.center :MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment:  CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: AppPadding.p14,
                                height: AppPadding.p14,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedValue == item ? ColorManager.mainColor :Colors.black87,
                                    border: Border.all(color:ColorManager.mainColor )
                                ),
                              ),
                              Text(item,style:  TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: AppPadding.p10),),

                            ],),
                          if(item ==type[0])
                            Divider(
                              indent: 0,
                              endIndent: 0,
                              thickness: 1,
                              height:ConfigSize.defaultSize ,
                              color: ColorManager.mainColor,
                            ),

                        ],
                      )
                  ))
                      .toList(),
               //   value: selectedValue,
                  onChanged: (value) {
                    if(value == type[0]){
                      GiftUser.userSelected.clear();
                      for(int i =0 ; i<RoomScreen.userOnMics.value.length;i++){
                        GiftUser.userSelected.putIfAbsent(i,
                                () => SelecteObject(
                                    userId:RoomScreen.userOnMics.value[i]?.id??'',
                                    selected: true)) ;
                      }


                    }
                    else{
                             GiftUser.userSelected.clear();
                             for(int i =0 ; i<widget.listAllUsers.length;i++){
                               GiftUser.userSelected.putIfAbsent(i,
                                       () => SelecteObject(userId: widget.listAllUsers[i].id, selected: true)) ;
                             }
                    }

                    setState(() {
                      selectedValue = value as String;
                    });

                  },

                  iconSize: AppPadding.p24,
                  iconEnabledColor: ColorManager.mainColor,
                  iconDisabledColor: Colors.grey,
                  buttonHeight: AppPadding.p30,
                  buttonWidth: AppPadding.p45,
                  buttonPadding: const  EdgeInsets.only(left: 10, right: 10),
                  buttonDecoration: const BoxDecoration(
                    color: Colors.transparent,

                  ),
                  itemHeight: 35,
                 itemPadding: EdgeInsets.zero,
                  dropdownMaxHeight: ConfigSize.defaultSize!*6.9,
                  dropdownWidth: ConfigSize.defaultSize!*14,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black87,
                    border: Border.all(color: ColorManager.mainColor)
                  ),
                  scrollbarRadius: const Radius.circular(40),
                 scrollbarThickness: 0,
                 scrollbarAlwaysShow: false,
                  offset:  Offset(ConfigSize.defaultSize!*9.3, 0),
                  dropdownPadding: EdgeInsets.zero,
                ),
              ),
          ],
        ),
      ) ,
    );
  }
}


class SelecteObject {
  final String userId ;
  final bool selected ;

 const SelecteObject({required this.userId, required this.selected});
}


