import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'dart:ui' as ui;
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_events.dart';

class SaveRoomPasswordRoomScreen extends StatefulWidget {
  final String ownerId;

  final MyDataModel myData;

  const SaveRoomPasswordRoomScreen(
      {required this.ownerId, required this.myData, Key? key})
      : super(key: key);

  @override
  State<SaveRoomPasswordRoomScreen> createState() =>
      _EnterPasswordRoomScreenState();
}

class _EnterPasswordRoomScreenState extends State<SaveRoomPasswordRoomScreen> {
  TextEditingController passwordcontroler = TextEditingController();
  final  int _passwordength = 6;
  final  String password = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ConfigSize.defaultSize!*1.5),
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
              height: 14.h,
            ),
            Directionality(
              textDirection: ui.TextDirection.ltr,
              child: TextFieldPin(
                  textController: passwordcontroler,
                  autoFocus: true,
                  codeLength: _passwordength,
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
                      value = password;
                    });
                  }),
            ),
            SizedBox(
              height: ConfigSize.defaultSize!*0.14,
            ),
            InkWell(
              onTap: () async {
                Navigator.pop(context);
                BlocProvider.of<OnRoomBloc>(context).add(
                    UpdateRoom(ownerId:widget.ownerId ,
                    roomPass: passwordcontroler.text)) ;


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
