

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/room_type_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/num_of_vistor.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/enter_room_pass/enter_password_dialog_room.dart';

class AduioLiveRow extends StatelessWidget {
  final int style;
  final RoomModelOfAll room;

  const AduioLiveRow({required this.room, required this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 2,
        ),
        InkWell(
          onTap: () {
            if (room.passwordStatus ?? false) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      insetPadding: EdgeInsets.symmetric(
                          horizontal: ConfigSize.defaultSize! * 5),
                      backgroundColor: Colors.transparent,
                      child: EnterPasswordRoomDialog(
                        myData: MyDataModel.getInstance(),
                        ownerId: room.ownerId.toString(),
                      ),
                    );
                  });
            } else {
              Navigator.pushNamed(context, Routes.roomHandler,
                  arguments: RoomHandlerPramiter(
                      ownerRoomId: room.ownerId.toString(),
                      myDataModel: MyDataModel.getInstance()));
            }
          },
          child: Stack(
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
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize! * 2)),
                margin: EdgeInsetsDirectional.only(
                    bottom: ConfigSize.defaultSize! * 2,
                    start: ConfigSize.defaultSize! * 2.5),
                width: ConfigSize.defaultSize! * 33,
                height: ConfigSize.defaultSize! * 10,
              )),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: ConfigSize.defaultSize! * 1.2),
                    width: ConfigSize.defaultSize! * 8.6,
                    height: ConfigSize.defaultSize! * 7.6,
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
                        image: room.cover != null
                            ? DecorationImage(
                                image: CachedNetworkImageProvider(
                                    ConstentApi().getImage(room.cover)),
                                fit: BoxFit.cover)
                            : const DecorationImage(
                                image: AssetImage(AssetsPath.defaultImage),
                                fit: BoxFit.fill),
                        borderRadius:
                            BorderRadius.circular(ConfigSize.defaultSize! * 2)),
                  ),
                  SizedBox(
                    width: ConfigSize.defaultSize,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: ConfigSize.defaultSize! * 19,
                        child: Text(
                          room.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ConfigSize.defaultSize! * 1.8),
                        ),
                      ),
                      SizedBox(
                        width: ConfigSize.defaultSize! * 19,
                        child: Text(
                          room.roomIntro ?? "",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: ConfigSize.defaultSize! * 1.2,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      SizedBox(
                        height: ConfigSize.defaultSize! * 0.5,
                      ),
                      Row(
                        children: [
                          RoomTypeWidget(
                              style: style, type: room.type!.name),
                          SizedBox(
                            width: ConfigSize.defaultSize,
                          ),
                          room.country== ''
                              ? const SizedBox()
                              : CachedNetworkImage(
                                  imageUrl:
                                      ConstentApi().getImage(room.country!),
                                  width: ConfigSize.defaultSize! * 2.4,
                                  height: ConfigSize.defaultSize! * 2.4,
                                ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: room.passwordStatus!
                            ? ConfigSize.defaultSize! * 2
                            : ConfigSize.defaultSize! * 5,
                        end: ConfigSize.defaultSize! * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (room.passwordStatus!)
                          Image.asset(
                            AssetsPath.lock,
                            color: ColorManager.orang,
                          ),
                        if (room.passwordStatus!)
                          SizedBox(
                            height: ConfigSize.defaultSize,
                          ),
                        NumVistor(
                          numOfVistor: room.visitorsCount.toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}

//
