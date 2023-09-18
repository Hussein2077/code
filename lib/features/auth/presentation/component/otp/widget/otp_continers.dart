
import 'package:flutter/material.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class OtpContiners extends StatefulWidget {
  static  String code = "";
  const OtpContiners({super.key});

  @override
  State<OtpContiners> createState() => _OtpContinersState();
}

class _OtpContinersState extends State<OtpContiners> {
  final int _otpCodeLength = 6;
  TextEditingController textEditingController = TextEditingController(text: "");
 

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextFieldPin(
          textController: textEditingController,
          
          autoFocus: false,
          codeLength: _otpCodeLength,
          alignment: MainAxisAlignment.center,
          defaultBoxSize: ConfigSize.defaultSize! * 4.44,
          margin: ConfigSize.defaultSize! * 0.37,
          selectedBoxSize: ConfigSize.defaultSize! * 4.5,
          textStyle: TextStyle(fontSize: ConfigSize.defaultSize! * 1.9),
          defaultDecoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorManager.mainColor),
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.6),
          ),
          selectedDecoration: BoxDecoration(
            border: Border.all(width: 2, color: ColorManager.mainColor),
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.6),
          ),
          onChange: (value) {
            setState(() {
              OtpContiners.code = value;

            });
          }),
    );
  }
}
