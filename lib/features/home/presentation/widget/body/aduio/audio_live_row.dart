

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/room_type_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/num_of_vistor.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/components/enter_room_pass/enter_password_dialog_room.dart';

class AduioLiveRow extends StatelessWidget {
  final int style;
  final RoomModelOfAll room ; 
  const AduioLiveRow({required this.room , required this.style, super.key});



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        log("passsord room"+room.passwordStatus.toString());
        if(room.passwordStatus??false){
          showDialog(context: context,
              builder:(context){
            return Dialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal:  ConfigSize.defaultSize! * 5
              ),

              backgroundColor: Colors.transparent,
              child: EnterPasswordRoomDialog(
                myData: MyDataModel.getInstance(),
                ownerId: room.ownerId.toString(),
              ),
            );

          });

        }else {
          Navigator.pushNamed(context, Routes.roomHandler,
           arguments: RoomHandlerPramiter(ownerRoomId: room.ownerId.toString(),
               myDataModel:MyDataModel.getInstance() ))  ;
        }
      },
      child:Stack(
        children: [
          Center(
              child: Container(
                decoration: BoxDecoration(
                    image: style == 0
                        ? const DecorationImage(
                        image: AssetImage(AssetsPath.blueBackGround))
                        : style == 1
                        ? const DecorationImage(
                        image: AssetImage(AssetsPath.yellowBackGround))
                        : const DecorationImage(
                        image: AssetImage(AssetsPath.pinkBackGround)),
                    borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
                margin:
                EdgeInsets.only(bottom: 20, left: ConfigSize.defaultSize! * 2.5),
                width: MediaQuery.of(context).size.width - 90,
                height: ConfigSize.defaultSize!*10,
              )),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: ConfigSize.defaultSize! * 2.3,
                    top: ConfigSize.defaultSize! * 1.2),
                width: ConfigSize.defaultSize!*8.6,
                height: ConfigSize.defaultSize!*7.6,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: style == 0
                              ? ColorManager.blue.withOpacity(0.6)
                              : style == 1
                              ? ColorManager.orang.withOpacity(0.6)
                              : ColorManager.pink.withOpacity(0.6),
                          spreadRadius: 1,
                          blurRadius: 20),
                    ],
                    image:  DecorationImage(image:  CachedNetworkImageProvider(

                        ConstentApi().getImage(room.cover)) , fit: BoxFit.fill),
                    borderRadius:
                    BorderRadius.circular(ConfigSize.defaultSize! * 2)),
                child:  Align(
                    alignment: Alignment.bottomLeft,
                    child: NumVistor(numOfVistor: room.visitorsCount.toString(),)),
              ),
              SizedBox(
                width: ConfigSize.defaultSize,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name??"",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ConfigSize.defaultSize! * 1.8),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-200,
                    child: Text(
                      room.roomIntro??"",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: ConfigSize.defaultSize! * 1.2,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      RoomTypeWidget(style: style,type: room.type!.name??""),
                      SizedBox(
                        width: ConfigSize.defaultSize,
                      ),
                      CachedNetworkImage(
                        imageUrl: ConstentApi().getImage(room.country!.flag),
                        width: ConfigSize.defaultSize! * 2.4,
                        height: ConfigSize.defaultSize! * 2.4,
                      ),
                    ],
                  )
                ],
              ),
            ],
          )
        ],
      ) ,
    );


  }
}
