import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/main.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'dart:ui' as ui;
import '../../../../../../core/model/my_data_model.dart';
import '../../../../../../core/utils/config_size.dart';

class EnterPasswordRoomDialog extends StatefulWidget {
  final String ownerId;
  final MyDataModel myData;
  final bool? isInRoom ;

  const EnterPasswordRoomDialog(
      {required this.ownerId, required this.myData,this.isInRoom, Key? key})
      : super(key: key);

  @override
  State<EnterPasswordRoomDialog> createState() =>
      _EnterPasswordRoomDilogeState();
}

class _EnterPasswordRoomDilogeState extends State<EnterPasswordRoomDialog> {
  TextEditingController passwordcontroler = TextEditingController();
 final int _otpPasswordLength = 6;
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  ConfigSize.defaultSize! *40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(StringManager.passwordProtected.tr() ,style: Theme.of(context).textTheme.bodyMedium,),
          Padding(padding:EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!) , child: Text(StringManager.youCanOptanPassword.tr() , style: Theme.of(context).textTheme.bodySmall ,overflow: TextOverflow.fade,)),
          Container(
            width: ConfigSize.defaultSize!*10.18,
            height: ConfigSize.defaultSize!*10.18,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AssetsPath.iconApp),
              ),
            ),
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
                    password = value;
                  });
                }),
          ),
          InkWell(
            onTap: () async {
              if((widget.isInRoom??false)){
                MainScreen.iskeepInRoom.value = true;
              }
              Navigator.pushReplacementNamed(
                  context, Routes.roomHandler,
                  arguments: RoomHandlerPramiter(
                    myDataModel:widget.myData,
                      passwordRoom: password,
                    ownerRoomId: widget.ownerId,
                      ));
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal:  ConfigSize.defaultSize! * 2.0,
              ),
              height: ConfigSize.defaultSize! * 5.0,
              decoration: (BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorManager.mainColor,
              )),
              child: Center(child: Text(StringManager.done.tr())),
            ),
          ),
        ],
      ),
    );
  }
}
