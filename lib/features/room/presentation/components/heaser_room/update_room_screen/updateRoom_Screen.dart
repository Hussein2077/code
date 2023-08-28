import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/dialoge_for_privcy.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/add_profile_pic.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_state.dart';
import 'package:tik_chat_v2/features/room/data/model/all_main_classes_model.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_states.dart';

class UpdateRoomScreen extends StatefulWidget {
  final List<AllMainClassesModel>? data;
  final bool? isUpdate;
  final EnterRoomModel? roomDate;
  final String? roomIntro;

  final MyDataModel myDataModel;

  const UpdateRoomScreen(
      {this.isUpdate,
      this.roomDate,
      this.roomIntro,
      this.data,
      required this.myDataModel,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreatRoomScreenState();
}

Map<String, bool> flag = {};

List keys = flag.keys.toList();

class _CreatRoomScreenState extends State<UpdateRoomScreen> {
  TextEditingController roomNameControler = TextEditingController();

  TextEditingController roomIntroControler = TextEditingController();
  bool isEnable = false;
  bool isVisible = true;
  int? roomTypeId;

  @override
  void initState() {
    BlocProvider.of<MangerGetVipPrevBloc>(context).add(getVipPrevEvent());
    roomIntroControler.text = widget.roomDate!.roomIntro!;
    roomNameControler.text = widget.roomDate!.roomName!;

    for (int i = 0; i < widget.data!.length; i++) {
      flag.putIfAbsent(widget.data![i].name, () => false);
    }
    keys = flag.keys.toList();
    super.initState();
    selectCategory(widget.roomDate!.roomType!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnRoomBloc, OnRoomStates>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            height: ConfigSize.defaultSize! * 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppPadding.p8),
                    topLeft: Radius.circular(AppPadding.p8)),
                color: Colors.white),
            padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ConfigSize.defaultSize! * 2.11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.clear)),
                        AddProFilePic(
                          myImage: widget.roomDate!.roomCover!,
                          quality: 70,
                        )
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ConfigSize.defaultSize! * 2.11),
                      decoration: BoxDecoration(
                          color: ColorManager.lightGray,
                          borderRadius: BorderRadius.circular(AppPadding.p10)),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: roomNameControler,
                        cursorColor: ColorManager.mainColor,
                        decoration: InputDecoration(
                          hintText: StringManager.updateYourIntro.tr(),
                          hintStyle:
                              const TextStyle(color: ColorManager.lightGray),
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    //live title
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ConfigSize.defaultSize! * 2.11),
                      decoration: BoxDecoration(
                          color: ColorManager.lightGray,
                          borderRadius: BorderRadius.circular(AppPadding.p10)),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: roomIntroControler,
                        cursorColor: ColorManager.mainColor,
                        decoration: InputDecoration(
                          hintText: StringManager.updateYourIntro.tr(),
                          hintStyle:
                              const TextStyle(color: ColorManager.lightGray),
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    //live catagory
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Text(StringManager.roomType.tr()),
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 22.5,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, childAspectRatio: 3),
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  selectCategory(keys[index]);
                                });
                                roomTypeId = widget.data?[index].id;
                              },
                              child: const SizedBox()
                              //TODO make advenced  ui
                              // LiveCategory(
                              //   i: flag[keys[index]],
                              //   text: widget.data?[index].name ?? 'any thing',
                              // ),
                              );
                        },
                        itemCount: widget.data?.length ?? 0,
                      ),
                    ),

                    BlocBuilder<MangerGetVipPrevBloc, MangerGetVipPrevState>(
                      builder: (context, state) {
                        if (state is GetVipPrevSucssesState) {
                                             var element = state.data.firstWhere((item) => item.key == 'room');

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(StringManager.hideRoom.tr()),
                              Switch(
                                  activeColor: ColorManager.mainColor,
                                  value:element.isActive!,
                                  onChanged: (value) {
                                    if (element.isActive == false) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialogForPrivecyScreen(
                                              flag: element.isAllowToUser!,
                                              buildContext: context,
                                              confirm: () {
                                                Navigator.pop(context);
                                                BlocProvider.of<OnRoomBloc>(
                                                        context)
                                                    .add(const HideRoomEvent());
                                              },
                                              text: StringManager.privilegeVip6
                                                  .tr(),
                                            );
                                          });
                                    } else {
                                      BlocProvider.of<OnRoomBloc>(context)
                                          .add(const DisposeHideRoomEvent());
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
                                  value: widget.myDataModel.isHideRoom!,
                                  onChanged: (value) {
                                    if (!(widget.myDataModel.isHideRoom ??
                                        false)) {
                                    } else {}
                                  })
                            ],
                          );
                        }
                      },
                    ),

                    /// save button
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);

                        if (roomIntroControler.text.isEmpty) {
                          BlocProvider.of<OnRoomBloc>(context).add(UpdateRoom(
                              roomName: roomNameControler.text,
                              ownerId: widget.roomDate!.ownerId.toString(),
                              roomCover: File(AddProFilePic.image!.path),
                              roomType: roomTypeId.toString()));
                        } else {
                          if (roomTypeId == null) {
                            BlocProvider.of<OnRoomBloc>(context).add(UpdateRoom(
                              roomName: roomNameControler.text,
                              ownerId: widget.roomDate!.id.toString(),
                              roomIntro: roomIntroControler.text,
                              roomCover: File(AddProFilePic.image!.path),
                              //   roomType: roomTypeId.toString()
                            ));
                          } else {
                            BlocProvider.of<OnRoomBloc>(context).add(UpdateRoom(
                                roomName: roomNameControler.text,
                                ownerId: widget.roomDate!.id.toString(),
                                roomIntro: roomIntroControler.text,
                                roomCover: File(AddProFilePic.image!.path),
                                roomType: roomTypeId.toString()));
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorManager.mainColor,
                            borderRadius: BorderRadius.circular(10)),
                        width: ConfigSize.screenWidth! -
                            ConfigSize.defaultSize! * 2,
                        height: ConfigSize.defaultSize! * 5,
                        child: Center(
                            child: Text(
                          StringManager.update.tr(),
                          style:
                              const TextStyle(color: ColorManager.whiteColor),
                        )),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is UpdateRoomSucsseState) {
          Navigator.pop(context);
          sucssesToast(
              context: context, title: StringManager.updateScssfuly.tr());
        }
        else if (state is HideRoomSuccessState) {
          BlocProvider.of<MangerGetVipPrevBloc>(context).add(getVipPrevEvent());
        }
        else if (state is DisposeHideRoomSuccessState) {
          BlocProvider.of<MangerGetVipPrevBloc>(context).add(getVipPrevEvent());
        }
        else if (state is HideRoomErrorState) {
          errorToast(context: context, title: state.errorMassage);
        } else if (state is DisposeHideRoomErrorState) {
          errorToast(context: context, title: state.errorMassage);
        }
        else if (state is HideRoomLoadingState) {
          loadingToast(context: context, title: '');
        }
      },
    );
  }

  void selectCategory(String key) {
    for (int i = 0; i < keys.length; i++) {
      if (key == keys[i]) {
        flag[keys[i]] = true;
      } else {
        flag[keys[i]] = false;
      }
    }
  }
}
