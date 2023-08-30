import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/add_profile_pic.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/voice/widget/room_type_button.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/update_room_screen/widget/add_room_live_pic.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/update_room_screen/widget/edit_features_container.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/update_room_screen/widget/edit_textfield.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_events.dart';
import '../../../../../../core/resource_manger/string_manager.dart';

class UpdateRoomScreen extends StatefulWidget {
  final EnterRoomModel roomDate;


  const UpdateRoomScreen(
      {
      required this.roomDate,
      Key? key})
      : super(key: key);

  // static   AllMainClassesModel?  roomType  ;
  @override
  State<UpdateRoomScreen> createState() => _UpdateRoomScreenState();
}

class _UpdateRoomScreenState extends State<UpdateRoomScreen> {
  TextEditingController roomNameControler = TextEditingController();
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
  TextEditingController roomIntroControler = TextEditingController();
  bool isEnable = false;
  bool isVisible = true;
  int? roomTypeId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.defaultSize! * 75,
      width: ConfigSize.screenWidth,
      padding: EdgeInsets.symmetric(
         // vertical: ConfigSize.defaultSize! * 1.5,
          horizontal: ConfigSize.defaultSize! * 2.11),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ConfigSize.defaultSize! * 2),
              topRight: Radius.circular(ConfigSize.defaultSize! * 2)),
          color: Theme.of(context).colorScheme.background),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringManager.roomSetting.tr(),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: ConfigSize.defaultSize! * 2.2,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const  Spacer(flex: 5,),

          SizedBox(
            height: ConfigSize.defaultSize! * 70,
            width: ConfigSize.screenWidth,
            child: Column(
               mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddRoomLivePic(roomCover:widget.roomDate.roomCover ,),
                const Spacer(
                  flex: 1,
                ),
                EditTextField(
                  textFieldControler: roomNameControler,
                  title: StringManager.roomName.tr(),
                  hint: widget.roomDate.roomName?? StringManager.updateRoomName.tr(),
                ),
                const Spacer(
                  flex: 1,
                ),
                EditTextField(
                  textFieldControler: roomIntroControler,
                  title: StringManager.roomIntro.tr(),
                  hint: widget.roomDate.roomIntro?? StringManager.updateYourIntro.tr(),
                ),
                const Spacer(
                  flex: 2,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(StringManager.roomType.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: ConfigSize.defaultSize! * 2,
                              fontWeight: FontWeight.w600,
                            )),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorManager.lightGray,
                        borderRadius:
                            BorderRadius.circular(ConfigSize.defaultSize! * 2),
                      ),
                      child: const RoomTypeButton(),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
                EditFeaturesContainer(),
                const Spacer(
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MainButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: StringManager.cancle.tr(),
                        buttonColornotList: Colors.transparent,
                        textColor: ColorManager.mainColor,
                        width: ConfigSize.defaultSize! * 12),
                    MainButton(
                        onTap: () {
                          Navigator.pop(context);

                              BlocProvider.of<OnRoomBloc>(context).add(
                                  UpdateRoom(
                                      roomName: roomNameControler.text,
                                      ownerId: widget.roomDate.ownerId.toString(),
                                      roomIntro: roomIntroControler.text,
                                      roomCover:AddProFilePic.image !=null?
                                          File(AddProFilePic.image!.path) : null,
                                      roomType: roomTypeId.toString()));

                              log("${ roomIntroControler.text.toString()} room Intro");


                        },
                        title: StringManager.save.tr(),
                        buttonColor: ColorManager.mainColorList,
                        textColor: ColorManager.whiteColor,
                        width: ConfigSize.defaultSize! * 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
