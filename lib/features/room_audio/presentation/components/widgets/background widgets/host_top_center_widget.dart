// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/show_svga.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/top_room_profile.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';

class HostTopCenterWidget extends StatelessWidget {

  LayoutMode layoutMode;
  UserDataModel? topUser;
  MyDataModel myDataModel;
  EnterRoomModel room;
  HostTopCenterWidget({super.key, required this.layoutMode, this.topUser, required this.myDataModel, required this.room});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ConfigSize.defaultSize! * 10, right: ConfigSize.defaultSize! * 6),
      child: Align(
        alignment: Alignment.topRight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: ConfigSize.defaultSize! * 10,
              height: ConfigSize.defaultSize! * 11,
              child: const Image(
                image: AssetImage(AssetsPath.kingchir),
              ),
            ),
            if (topUser?.id != null)
              Stack(
                alignment: Alignment.center,
                children: [
                  InkWell(
                    onTap: () => bottomDailog(
                      context: context,
                      widget: TopRoomProfile(
                        myData: myDataModel,
                        roomData: room,
                        userId: topUser!.id.toString(),
                        layoutMode: layoutMode,
                      ),
                    ),
                    child: UserImage(
                      image: topUser!.profile!.image!,
                      frame: topUser!.frame,
                      frameId: topUser!.frameId,
                      imageSize: ConfigSize.defaultSize! * 4,
                    ),
                  ),
                  topUser!.frame == ""
                      ? SizedBox(
                    width: ConfigSize.defaultSize! * 6,
                    height: ConfigSize.defaultSize! * 6,
                  )
                      : Positioned(
                    child: SizedBox(
                        width: ConfigSize.defaultSize! * 6,
                        height: ConfigSize.defaultSize! * 6,
                        child: ShowSVGA(
                          imageId: '${topUser!.frameId}$cacheFrameKey',
                          url: topUser!.frame ?? '',
                        )),
                  ),
                ],
              ),
            if (topUser?.id != null)
              Positioned(
                top: ConfigSize.defaultSize! * 9,
                //  bottom: ConfigSize.screenWidth! * 0.08,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ConfigSize.screenWidth! * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: GradientTextVip(
                        text: topUser!.name!,
                        isVip: topUser!.hasColorName ?? false,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            color: Colors.white),
                      )),
                ),
              )
          ],
        ),
      ),
    );
  }
}
