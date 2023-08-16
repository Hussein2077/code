import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'dart:ui' as ui;
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/voice/widget/add_voice_live_pic.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/voice/widget/room_type_button.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_events.dart';


class EnterPasswordCreatRoom extends StatefulWidget {

  final String name;

  const EnterPasswordCreatRoom({ Key? key,required this.name}) : super(key: key);

  @override
  State<EnterPasswordCreatRoom> createState() =>
      _EnterPasswordRoomDilogeState();
}

class _EnterPasswordRoomDilogeState extends State<EnterPasswordCreatRoom> {
  TextEditingController passwordcontroler = TextEditingController();
  final int _otpPasswordLength = 6;
  final String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ConfigSize.defaultSize!*1.2),
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(
            25
          ),
          color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ConfigSize.defaultSize!*0.8,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!*3.5
              ),
              width: ConfigSize.defaultSize!*10.18,
              height: ConfigSize.defaultSize!*10.18,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AssetsPath.iconApp),
                ),
              ),
            ),
            SizedBox(
              height: AppPadding.p14,
            ),
            Directionality(
              textDirection: ui.TextDirection.ltr,
              child: TextFieldPin(
                  textController: passwordcontroler,
                  autoFocus: true,
                  codeLength: _otpPasswordLength,
                  alignment: MainAxisAlignment.center,
                  defaultBoxSize: ConfigSize.defaultSize! * 3.80,
                  margin: ConfigSize.defaultSize! * 0.44,
                  selectedBoxSize: ConfigSize.defaultSize! * 3.90,
                  textStyle: TextStyle(fontSize: ConfigSize.defaultSize!*2.18,color: Colors.black),
                  defaultDecoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: ColorManager.mainColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  selectedDecoration: BoxDecoration(
                    border:
                    Border.all(width: 2, color: ColorManager.mainColor),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onChange: (value) {


                   setState(() {
                     value  = password;
                   });
                  }),
            ),
            SizedBox(
              height: ConfigSize.defaultSize!*0.14,
            ),
            InkWell(
              onTap: () async {



                // ignore: use_build_context_synchronously

                // ignore: use_build_context_synchronously
                Navigator.pop(context);

                BlocProvider.of<CreateRoomBloc>(context)
                    .add(CreateAudioRoomEvent(
                  password: passwordcontroler.text,
                  roomName: widget.name ,
                  roomCover: File(AddVoiceLivePicState.image!.path),
                  roomIntero: '',
                  roomType: RoomTypeButton.roomType!.id.toString(),
                ));
                // ignore: use_build_context_synchronously

              },
              child: Container(
                height: ConfigSize.defaultSize! * 6.0,
                decoration: (BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.mainColor,
                )),
                child: Center(child: Text(StringManager.done.tr())),
              ),
            ),
            SizedBox(
              height: ConfigSize.defaultSize! * 0.18,
            ),
          ],
        ),
      ),
    );
  }
}
