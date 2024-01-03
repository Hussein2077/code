import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/voice/widget/room_type_button.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_vip_prev.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/component/privacy_setting/widget/diloge_for_privcy.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_state.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/update_room_screen/widget/add_room_live_pic.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/update_room_screen/widget/edit_textfield.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';

import 'edit_features_container.dart';

class UpdateRoomBody extends StatefulWidget {
  final EnterRoomModel roomDate;
  final String nameHint;
  final String introHint;
  final EnterRoomModel room;
  final MyDataModel myDataModel;
  final int roomMode;

  const UpdateRoomBody({required this.roomDate,
    required this.nameHint,
    required this.introHint,
    Key? key, required this.room, required this.myDataModel, required this.roomMode}) : super(key: key);

  //static   AllMainClassesModel?  roomType  ;
  @override
  State<UpdateRoomBody> createState() => _UpdateRoomBodyState();
}

class _UpdateRoomBodyState extends State<UpdateRoomBody> {
  @override
  void initState() {
    BlocProvider.of<MangerGetVipPrevBloc>(context).add(getVipPrevEvent());
    super.initState();
  }

  TextEditingController roomNameControler = TextEditingController();
  TextEditingController roomIntroControler = TextEditingController();


  bool isEnable = false;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PrivacyBloc, PrivacyState>(
      listener: (context, state){
        if (state is SucssesState) {
          BlocProvider.of<MangerGetVipPrevBloc>(context).add(getVipPrevEvent());
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
        } else if (state is ErrorState) {
          errorToast(context: context, title: state.massege.tr());
        } else if (state is LoadingState) {
          loadingToast(context: context, title: StringManager.loading.tr());
        }
      },
      child: Container(
        height: ConfigSize.defaultSize! * 75,
        width: ConfigSize.screenWidth,
        padding: EdgeInsets.symmetric(
            horizontal: ConfigSize.defaultSize! * 2.11),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ConfigSize.defaultSize! * 2),
                topRight: Radius.circular(ConfigSize.defaultSize! * 2)),
            color: Theme.of(context).colorScheme.background),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 5,
            ),
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
                    hint: widget.nameHint


                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  EditTextField(
                    textFieldControler: roomIntroControler,
                    title: StringManager.roomIntro.tr(),
                    hint: widget.introHint


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
                    flex: 2,
                  ),
              BlocBuilder<MangerGetVipPrevBloc,
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
                              if (reslt.isActive == false) {
                                setState(() {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DilogForPrivecyScreen(
                                          myData: widget.myDataModel,
                                          minPrice: reslt.minPrice!,
                                          flag: reslt.isAllowToUser!,
                                          buildContext: context,
                                          refuse: (){
                                            if(reslt.minPrice!>widget.myDataModel.myStore!.coins){
                                              Navigator.pushNamed(context, Routes.coins,arguments: 'gold');

                                            }else{
                                              Navigator.pushNamed(context, Routes.vip,arguments: reslt.mine!-1);

                                            }
                                          },
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
                                              .thisFeatureisNotAvailableForYou(vip: reslt.mine.toString())
                                              .tr(),
                                        );
                                      });
                                });
                              } else {
                                BlocProvider.of<PrivacyBloc>(context).add(DisposeePrev(type: reslt.key!));
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
                              if (!(MyDataModel.getInstance().isHideRoom!)) {
                              } else {}
                            })
                      ],
                    );
                  }
                },
              ),
                  const Spacer(
                    flex: 10,
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
                          BlocProvider.of<OnRoomBloc>(context).add(UpdateRoom(
                              roomName: roomNameControler.text,
                              ownerId: widget.roomDate.ownerId.toString(),
                              roomIntro: roomIntroControler.text,
                              roomCover: AddRoomLivePicState.image != null
                                  ? File(AddRoomLivePicState.image!.path)
                                  : null,
                              roomType: RoomTypeButton.roomType?.id.toString()));
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

                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  EditFeaturesContainer(
                    roomId: widget.room.id!,
                    ownerId: widget.room.ownerId.toString(),
                    passwordStatus: widget.room.roomPassStatus!,
                    modeRoom:widget. roomMode,
                    userId: widget.myDataModel.id.toString(),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
