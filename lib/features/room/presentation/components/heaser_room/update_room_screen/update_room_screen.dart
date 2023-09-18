import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/voice/widget/room_type_button.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_vip_prev.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/component/privacy_setting/widget/diloge_for_privcy.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_state.dart';
import 'package:tik_chat_v2/features/room/data/model/all_main_classes_model.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/update_room_screen/widget/add_room_live_pic.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/update_room_screen/widget/edit_features_container.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/update_room_screen/widget/edit_textfield.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_events.dart';
import '../../../../../../core/resource_manger/string_manager.dart';

class UpdateRoomScreen extends StatefulWidget {
  final EnterRoomModel roomDate;

  const UpdateRoomScreen({required this.roomDate, Key? key}) : super(key: key);

   //static   AllMainClassesModel?  roomType  ;
  @override
  State<UpdateRoomScreen> createState() => _UpdateRoomScreenState();
}

class _UpdateRoomScreenState extends State<UpdateRoomScreen> {
  TextEditingController roomNameControler = TextEditingController();
  TextEditingController roomIntroControler = TextEditingController();

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
  bool isEnable = false;
  bool isVisible = true;
  String? roomType;

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
          const Spacer(
            flex: 5,
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 70,
            width: ConfigSize.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddRoomLivePic(
                  roomCover: widget.roomDate.roomCover,
                ),
                const Spacer(
                  flex: 1,
                ),
                EditTextField(
                  textFieldControler: roomNameControler,
                  title: StringManager.roomName.tr(),
                  hint: widget.roomDate.roomName ??
                      StringManager.updateRoomName.tr(),
                ),
                const Spacer(
                  flex: 1,
                ),
                EditTextField(
                  textFieldControler: roomIntroControler,
                  title: StringManager.roomIntro.tr(),
                  hint: widget.roomDate.roomIntro ??
                      StringManager.updateYourIntro.tr(),
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
                      child: RoomTypeButton(),
                    ),
                  ],
                ),
                BlocConsumer<PrivacyBloc, PrivacyState>(
                  listener: (context, state) {
                    if (state is SucssesState) {
                      BlocProvider.of<MangerGetVipPrevBloc>(context).add(getVipPrevEvent());
                      sucssesToast(context: context, title: StringManager.sucsses.tr());
                    } else if (state is ErrorState) {
                      errorToast(context: context, title: state.massege.tr());
                    } else if (state is LoadingState) {
                      loadingToast(
                          context: context, title: StringManager.loading.tr());
                    }
                  },
                  builder: (context, state) {
                    return BlocBuilder<MangerGetVipPrevBloc,
                        MangerGetVipPrevState>(
                      builder: (context, state) {
                        if (state is GetVipPrevSucssesState) {
                          GetVipPrevModel reslt = state.data
                              .firstWhere((element) => element.key == "room");
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(StringManager.hideRoom.tr()),
                              Switch(
                                  activeColor: ColorManager.mainColor,
                                  value: reslt.isActive!,
                                  onChanged: (value) {
                                    log(reslt.isActive!.toString());
                                    log(reslt.key!.toString());
                                    if (reslt.isActive == false) {
                                      setState(() {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return DilogForPrivecyScreen(
                                                flag: reslt.isAllowToUser!,
                                                buildContext: context,
                                                confirm: () {
                                                  Navigator.pop(context);

                                                  BlocProvider.of<PrivacyBloc>(
                                                          context)
                                                      .add(AtivePrev(
                                                          type: reslt.key!));
                                                },
                                                text: reslt.isAllowToUser!
                                                    ? StringManager
                                                        .useTheFeatureAndEnjoyit
                                                        .tr()
                                                    : StringManager
                                                        .thisFeatureisNotAvailableForYou
                                                        .tr(),
                                              );
                                            });
                                      });
                                    } else {
                                      BlocProvider.of<PrivacyBloc>(context)
                                          .add(DisposeePrev(type: reslt.key!));
                                    }
                                  })
                            ],
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(StringManager.hideRoom.tr()),
                              Switch(
                                  activeColor: ColorManager.mainColor,
                                  value: MyDataModel.getInstance().isHideRoom!,
                                  onChanged: (value) {
                                    if (!(MyDataModel.getInstance()
                                        .isHideRoom!)) {
                                    } else {}
                                  })
                            ],
                          );
                        }
                      },
                    );
                  },
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

                       // log("jakol ${roomIntroControler.text.toString()}");
                        log("jakol ${roomNameControler.text.toString()}");
                        //log("jakosss ${AddRoomLivePicState.image!.path.toString()}");
                        log("jakosss ${roomType.toString()}");

                        Navigator.pop(context);
                        BlocProvider.of<OnRoomBloc>(context).add(UpdateRoom(
                            roomName: roomNameControler.text,
                            ownerId: widget.roomDate.ownerId.toString(),
                            roomIntro: roomIntroControler.text,
                            roomCover: AddRoomLivePicState.image != null
                                ? File(AddRoomLivePicState.image!.path)
                                : null,
                            roomType: roomType.toString())
                        );

                      },
                      title: StringManager.save.tr(),
                      buttonColor: ColorManager.mainColorList,
                      textColor: ColorManager.whiteColor,
                      width: ConfigSize.defaultSize! * 12,
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
                // const Divider(
                //   height: 1,
                //   thickness: 1,
                //   color: Colors.grey,
                // ),
                // EditFeaturesContainer(),
                // const Spacer(
                //   flex: 2,
                // ),
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
