import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/voice/widget/creat_password_diloge.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_states.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'widget/add_voice_live_pic.dart';
import 'widget/public_privite_button.dart';
import 'widget/room_type_button.dart';

class CreateVoiceLiveBody extends StatefulWidget {
  const CreateVoiceLiveBody({super.key});

  static bool isFirst = true;

  @override
  State<CreateVoiceLiveBody> createState() => _CreateVoiceLiveBodyState();
}

class _CreateVoiceLiveBodyState extends State<CreateVoiceLiveBody> {
  late TextEditingController voicNameController;

  @override
  void initState() {
    CreateVoiceLiveBody.isFirst = true;
    voicNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackGround(
        image: AssetsPath.createVoicBackGround,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ConfigSize.defaultSize! * 4,
              ),
              header(context: context),
              SizedBox(
                height: ConfigSize.defaultSize! * 4,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: ConfigSize.defaultSize! * 10,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize! * 1.2),
                    color: Colors.white.withOpacity(0.2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const AddVoiceLivePic(),
                    SizedBox(
                        width: ConfigSize.defaultSize! * 20,
                        child: TextFieldWidget(
                          textColor: Colors.white,
                          controller: voicNameController,
                          hintText: StringManager.roomName.tr(),
                        )),
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: ConfigSize.defaultSize! * 2,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [PublicPriveteButton(), RoomTypeButton()],
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 4,
              ),
              Image.asset(AssetsPath.seatsImage),
              SizedBox(
                height: ConfigSize.defaultSize! * 10,
              ),
              BlocConsumer<CreateRoomBloc, CreateRoomStates>(
                builder: (context, state) {
                  return MainButton(
                    onTap: () {
                      if (CreateVoiceLiveBody.isFirst) {
                        setState(() {
                          CreateVoiceLiveBody.isFirst = false;
                        });
                        if (checkRoomData(
                            roomName: voicNameController.text,
                            context: context)) {
                          createRoom(
                              context: context,
                              roomName: voicNameController.text);
                        }
                      }
                    },
                    title: StringManager.createRoom.tr(),
                  );
                },
                listener: (context, state) {
                  switch (state.createRoomState) {
                    case RequestState.loaded:
                      Navigator.pop(context);
                      BlocProvider.of<GetMyDataBloc>(context)
                          .add(GetMyDataEvent());
                      Navigator.pushNamed(context, Routes.roomHandler,
                          arguments: RoomHandlerPramiter(
                              ownerRoomId:
                                  MyDataModel.getInstance().id.toString(),
                              myDataModel: MyDataModel.getInstance()));
                      break;
                    case RequestState.loading:
                      loadingToast(
                          context: context, title: StringManager.loading.tr());
                      break;
                    case RequestState.error:
                      setState(() {
                        CreateVoiceLiveBody.isFirst = true;
                      });
                      errorToast(
                          context: context,
                          title: state.createRoomErrorMessage);
                      break;
                  }
                },
              )
            ],
          ),
        ));
  }

  bool checkRoomData(
      {required String roomName, required BuildContext context}) {
    if (roomName.isEmpty) {
      setState(() {
        CreateVoiceLiveBody.isFirst = true;
      });
      errorToast(context: context, title: StringManager.enterYourRoomName.tr());
      return false;
    } else if (AddVoiceLivePicState.image == null) {
      setState(() {
        CreateVoiceLiveBody.isFirst = true;
      });
      errorToast(
          context: context, title: StringManager.enterYourRoomImage.tr());
      return false;
    } else if (RoomTypeButton.roomType == null) {
      setState(() {
        CreateVoiceLiveBody.isFirst = true;
      });
      errorToast(context: context, title: StringManager.enterYourRoomType.tr());
      return false;
    } else if (roomName.isEmpty &&
        AddVoiceLivePicState.image == null &&
        RoomTypeButton.roomType == null) {
      setState(() {
        CreateVoiceLiveBody.isFirst = true;
      });
      errorToast(context: context, title: StringManager.enterYourRoomData.tr());
      return false;
    } else {
      return true;
    }
  }
}

Widget header({required BuildContext context}) {
  return Row(
    children: [
      SizedBox(
        width: ConfigSize.defaultSize,
      ),
      Container(
        padding: EdgeInsets.all(ConfigSize.defaultSize! - 3),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.white.withOpacity(0.5)),
        child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: ConfigSize.defaultSize! * 2,
            )),
      ),
      SizedBox(
        width: ConfigSize.defaultSize!,
      ),
      Text(
        StringManager.createVoice.tr(),
        style: TextStyle(
            color: Colors.white, fontSize: ConfigSize.defaultSize! * 2),
      )
    ],
  );
}

void createRoom({required BuildContext context, required String roomName}) {
  if (PublicPriveteButton.lockedOrUn == StringManager.public) {
    BlocProvider.of<CreateRoomBloc>(context).add(CreateAudioRoomEvent(
      password: '',
      roomName: roomName,
      roomCover: File(AddVoiceLivePicState.image!.path),
      roomIntero: '',
      roomType: RoomTypeButton.roomType!.id.toString(),
    ));
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding:
                EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 0.8),
            backgroundColor: Colors.transparent,
            content: EnterPasswordCreatRoom(
              name: roomName,
            ),
          );
        });
  }
}
