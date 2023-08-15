// Flutter imports:

import 'package:dio/dio.dart';
import 'package:flutter_social_textfield/flutter_social_textfield.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_config_key_model.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_events.dart';


// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/internal/icon_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/widgets/text_icon_button.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/logger_service.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';


class ZegoInRoomMessageInput extends StatefulWidget {
  static ValueNotifier<bool> activePobUp = ValueNotifier<bool>(false);
  static int    senderPobUpId = -1 ;
  static String messagePonUp='';
  final EnterRoomModel roomData ;
  final MyDataModel myData ;
   ZegoInRoomMessageInput({
    this.mention,
    Key? key,
    this.placeHolder = 'Say something...',
    this.backgroundColor,
    required  this.roomData,
    required this.myData,
    this.inputBackgroundColor,
    this.textColor,
    this.textHintColor,
    this.cursorColor,
    this.buttonColor,
    this.borderRadius,
    this.enabled = true,
    this.autofocus = true,
    this.onSubmit,
    this.valueNotifier,
    this.focusNotifier,
  }) : super(key: key);

  final String placeHolder;
  final Color? backgroundColor;
  final Color? inputBackgroundColor;
  final Color? textColor;
  final Color? textHintColor;
  final Color? cursorColor;
  final Color? buttonColor;
  final double? borderRadius;
  final bool enabled;
  final bool autofocus;
  final VoidCallback? onSubmit;
  final ValueNotifier<String>? valueNotifier;
  final ValueNotifier<bool>? focusNotifier;
  String? mention ; 

  @override
  State<ZegoInRoomMessageInput> createState() => _ZegoInRoomMessageInputState();
}

class _ZegoInRoomMessageInputState extends State<ZegoInRoomMessageInput> {
  late SocialTextEditingController textController ;
  ValueNotifier<bool> isEmptyNotifier = ValueNotifier(true);
  var focusNode = FocusNode();


  @override
  void initState() {
    super.initState();
  
  
    textController = SocialTextEditingController()
      ..setTextStyle(DetectedType.mention,
          TextStyle(color: ColorManager.gold,
              backgroundColor: ColorManager.gold1.withAlpha(50)))
      ..setRegexp(DetectedType.url, RegExp("your_own_regex_fr_this_type"));
    focusNode.addListener(onFocusChange);
      if (widget.mention!=null){
  textController.text = widget.mention!;
    }

    if (widget.valueNotifier != null) {
      textController.text = widget.valueNotifier!.value;

      isEmptyNotifier.value = textController.text.isEmpty;
    }
  }

  @override
  void dispose() {
    super.dispose();

    focusNode
      ..removeListener(onFocusChange)
      ..dispose();
  }

  void onFocusChange() {
    widget.focusNotifier?.value = focusNode.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<int>(
        future: getUserPopUp(widget.myData.id.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return Container (
            padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 15.r),
            color: widget.backgroundColor ?? const Color(0xff222222).withOpacity(0.8),
            child: ConstrainedBox(
            constraints: BoxConstraints(
            minHeight: 90.r,
            ),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SizedBox(width: 10.r),
            messageInput(numPobUp: snapshot.data),
            SizedBox(width: 10.r),
            sendButton(numPobUp: snapshot.data),
            SizedBox(width: 10.r),
    ],
    ),
    ),
    );
                  }else{
            return  Container(
            padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 15.r),
            color: widget.backgroundColor ?? const Color(0xff222222).withOpacity(0.8),
            child: ConstrainedBox(
            constraints: BoxConstraints(
            minHeight: 90.r,
            ),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SizedBox(width: 10.r),
            messageInput(numPobUp: 0),
            SizedBox(width: 10.r),
            sendButton(numPobUp: 0),
            SizedBox(width: 10.r),
    ],
    ),
    ),
    );
    }

    });
  }

  Widget messageInput({required int numPobUp}) {
    final messageSendBgColor = widget.buttonColor ?? const Color(0xff3e3e3d);
    final messageSendCursorColor =
        widget.cursorColor ?? const Color(0xffA653ff);
    final messageSendHintStyle = TextStyle(
      color: widget.textHintColor ?? const Color(0xffa4a4a4),
      fontSize: 28.r,
      fontWeight: FontWeight.w400,
    );
    final messageSendInputStyle = TextStyle(
      color: widget.textColor ?? Colors.white,
      fontSize: 28.r,
      fontWeight: FontWeight.w400,
    );

   
            return  Expanded(
              child: Container(
                height: 78.r,
                decoration: BoxDecoration(
                  color: widget.inputBackgroundColor ?? messageSendBgColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: TextField(
                  enabled: widget.enabled,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                  autofocus: widget.autofocus,
                  focusNode: focusNode,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(ZegoInRoomMessageInput.activePobUp.value ? 40:250)
                  ],
                  controller: textController,
                  onChanged: (String inputMessage) {
                    widget.valueNotifier?.value = inputMessage;

                    final valueIsEmpty = inputMessage.isEmpty;
                    if (valueIsEmpty != isEmptyNotifier.value) {
                      isEmptyNotifier.value = valueIsEmpty;
                    }
                  },
                  textInputAction: TextInputAction.send,
                  onSubmitted: (message) => send(numPobUp:numPobUp),
                  cursorColor: messageSendCursorColor,
                  cursorHeight: 30.r,
                  cursorWidth: 3.r,
                  style: messageSendInputStyle,
                  decoration: InputDecoration(
                    hintText:ZegoInRoomMessageInput.activePobUp.value ?
                    numPobUp.toString(): widget.placeHolder,
                    hintStyle: messageSendHintStyle,
                    suffixIcon: InkWell(
                      onTap: (){
                        if(ZegoInRoomMessageInput.activePobUp.value){
                          setState(() {
                            ZegoInRoomMessageInput.activePobUp.value= false ;
                          });
                        }else{
                          setState(() {
                            ZegoInRoomMessageInput.activePobUp.value=true ;
                          });
                        }
                      },
                      child:Icon(Icons.animation,color: ZegoInRoomMessageInput.activePobUp.value?
                      ColorManager.mainColor :ColorManager.deepPurble,),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 20.r,
                      top: -5.r,
                      right: 20.r,
                      bottom: 15.r,
                    ),
                    // isDense: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ) ;

          
        

  }

  Widget sendButton({required int numPobUp} ) {
    return ValueListenableBuilder<bool>(
      valueListenable: isEmptyNotifier,
      builder: (context, bool isEmpty, Widget? child) {
        return ZegoTextIconButton(
          onPressed: () {
            if (!isEmpty) send(numPobUp: numPobUp);
          },
          icon: ButtonIcon(
            icon: isEmpty
                ? UIKitImage.asset(StyleIconUrls.iconSendDisable)
                : UIKitImage.asset(StyleIconUrls.iconSend),
            backgroundColor: widget.buttonColor,
          ),
          iconSize: Size(68.r, 68.r),
          buttonSize: Size(72.r, 72.r),
        );
      },
    );
  }

  void send({required int numPobUp} ) {
    if (textController.text.isEmpty) {
      ZegoLoggerService.logInfo(
        'message is empty',
        tag: 'uikit',
        subTag: 'in room message input',
      );
      return;
    }
    if(ZegoInRoomMessageInput.activePobUp.value && numPobUp>0){
      BlocProvider.of<OnRoomBloc>(context).add(
          SendPobUpEvent(ownerId: widget.roomData.ownerId.toString(),
          message: textController.text)) ;
    }


    ZegoUIKit().sendInRoomMessage(textController.text);
    textController.clear();

    widget.valueNotifier?.value = '';

    widget.onSubmit?.call();
  }


  Future<int> getUserPopUp(String userId) async {
    if(ZegoInRoomMessageInput.activePobUp.value){
    Map<String, String> headers = await DioHelper().header();
 final   body = {
   'keys': [],
   "enable-special" : 1


 };
    final response = await Dio().post(ConstentApi.getConfigKey,
        options: Options(
          headers: headers,
        ),
        data: body);

    final result =GetConfigKeyModel.fromJson(response.data['data']);
   return result.wapelNum??0 ;

  }else{
      return 0 ;
    }
  }

}