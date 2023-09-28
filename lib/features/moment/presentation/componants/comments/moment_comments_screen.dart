
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_info_row.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/internal/icon_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/widgets/text_icon_button.dart';



class MomentCommentsScreen extends StatefulWidget {
  final MomentModel momentModel;

  const MomentCommentsScreen({
    required this.momentModel,
    super.key,
  });



  @override
  State<MomentCommentsScreen> createState() => _MomentCommentsScreenState();
}

class _MomentCommentsScreenState extends State<MomentCommentsScreen> {

  ValueNotifier<bool> isEmptyNotifier = ValueNotifier(true);

  TextEditingController commentController =TextEditingController();

  @override
  void initState() {
    BlocProvider.of<GetMomentCommentBloc>(context).add(
        GetMomentCommentEvent(
            momentId: widget.momentModel.momentId.toString()));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      width: ConfigSize.screenWidth!,
      height: ConfigSize.defaultSize! * 45,
      child: Column(
        children: [
          Container(
            height: ConfigSize.defaultSize! * 40,
            padding: EdgeInsets.only(
              left: ConfigSize.defaultSize!,
              right: ConfigSize.defaultSize!,
            ),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  height: ConfigSize.defaultSize! * 9.15,
                  padding:
                      EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!),
                  child:  MomentInfoRow(momentModel: widget.momentModel,comment: true),
                );
              },
            ),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: ConfigSize.defaultSize! * 7.8,
                  width: ConfigSize.defaultSize!*35,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    //widget.inputBackgroundColor ?? messageSendBgColor,
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize! * 1.6),
                  ),
                  child: TextField(

                    //enabled: widget.enabled,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    controller: commentController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (message) {},
                    //(message) => send(numPobUp:numPobUp),
                    cursorColor: const Color(0xffA653ff),
                    cursorHeight: ConfigSize.defaultSize! * 3,
                    cursorWidth: ConfigSize.defaultSize! * 0.3,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(


                      fillColor:   Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                      filled: true,
                      hintText: StringManager.addComment,

                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      suffixIcon: InkWell(
                        onTap: () {},
                        child:  Icon(Icons.animation,
                            color: //ZegoInRoomMessageInput.activePobUp.value?
                               Theme.of(context).colorScheme.background,
                            // :AppColor.greyColor,

                            ),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: ConfigSize.defaultSize! * 2,
                        top: ConfigSize.defaultSize! * -0.5,
                        right: ConfigSize.defaultSize! * 2,
                        bottom: ConfigSize.defaultSize! * 1.5,
                      ),
                      // isDense: true,
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),

                      )

                    ),
                  ),
                ),
                Container(
                  width: ConfigSize.defaultSize!*5,
                  height: ConfigSize.defaultSize!*5,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),

                      borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*3),
                    border: Border.all(color: Theme.of(context).colorScheme.secondary)
                  ),
                  child: IconButton(

                    onPressed: (){},
                    icon:Icon( Icons.send,
                    color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ),
              ],
            ),
          )

          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.transparent,
          //     borderRadius: BorderRadius.circular(ConfigSize.defaultSize! *0),
          //   ),
          //   child: TextFormField(
          //     enableIMEPersonalizedLearning: true,
          //     controller: commentController,
          //     decoration: InputDecoration(
          //       filled: true,
          //       fillColor: AppColor.blue,
          //       hintStyle: Theme.of(context).textTheme.titleMedium,
          //
          //        border: OutlineInputBorder(borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2)),
          //
          //       // focusedBorder: InputBorder.none,
          //       // enabledBorder: InputBorder.none,
          //       // errorBorder: InputBorder.none,
          //       // disabledBorder: InputBorder.none,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

// Widget messageInput({required int numPobUp}) {
//   const messageSendBgColor =  Color(0xff3e3e3d);
//   const messageSendCursorColor =
//       Color(0xffA653ff);
//   final messageSendHintStyle = TextStyle(
//     color:  const Color(0xffa4a4a4),
//     fontSize: ConfigSize.defaultSize!*2.8,
//     fontWeight: FontWeight.w400,
//   );
//   final messageSendInputStyle = TextStyle(
//     color:  Colors.white,
//     fontSize: ConfigSize.defaultSize!*2.8,
//     fontWeight: FontWeight.w400,
//   );
//
//
//   return  Expanded(
//     child: Container(
//       height: 78.r,
//       decoration: BoxDecoration(
//         color: widget.inputBackgroundColor ?? messageSendBgColor,
//         borderRadius: BorderRadius.circular(16.r),
//       ),
//       child: TextField(
//         enabled: widget.enabled,
//         keyboardType: TextInputType.multiline,
//         minLines: 1,
//         maxLines: null,
//         autofocus: widget.autofocus,
//         focusNode: focusNode,
//         inputFormatters: <TextInputFormatter>[
//           LengthLimitingTextInputFormatter(ZegoInRoomMessageInput.activePobUp.value ? 40:250)
//         ],
//         controller: textController,
//         onChanged: (String inputMessage) {
//           widget.valueNotifier?.value = inputMessage;
//
//           final valueIsEmpty = inputMessage.isEmpty;
//           if (valueIsEmpty != isEmptyNotifier.value) {
//             isEmptyNotifier.value = valueIsEmpty;
//           }
//         },
//         textInputAction: TextInputAction.send,
//         onSubmitted: (message) => send(numPobUp:numPobUp),
//         cursorColor: messageSendCursorColor,
//         cursorHeight: 30.r,
//         cursorWidth: 3.r,
//         style: messageSendInputStyle,
//         decoration: InputDecoration(
//           hintText:ZegoInRoomMessageInput.activePobUp.value ?
//           numPobUp.toString(): widget.placeHolder,
//           hintStyle: messageSendHintStyle,
//           suffixIcon: InkWell(
//             onTap: (){
//               if(ZegoInRoomMessageInput.activePobUp.value){
//                 setState(() {
//                   ZegoInRoomMessageInput.activePobUp.value= false ;
//                 });
//               }else{
//                 setState(() {
//                   ZegoInRoomMessageInput.activePobUp.value=true ;
//                 });
//               }
//             },
//             child:Icon(Icons.animation,color: ZegoInRoomMessageInput.activePobUp.value?
//             AppColor.primaryColor :AppColor.greyColor,),
//           ),
//           contentPadding: EdgeInsets.only(
//             left: 20.r,
//             top: -5.r,
//             right: 20.r,
//             bottom: 15.r,
//           ),
//           // isDense: true,
//           border: InputBorder.none,
//         ),
//       ),
//     ),
//   ) ;
//
//
//
//
// }
//   void send({required int numPobUp} ) {
//     if (commentController.text.isEmpty) {
//       ZegoLoggerService.logInfo(
//         'message is empty',
//         tag: 'uikit',
//         subTag: 'in room message input',
//       );
//       return;
//     }
//
//
//
//
//   }
  Widget sendButton({required int numPobUp} ) {
    return ValueListenableBuilder<bool>(
      valueListenable: isEmptyNotifier,
      builder: (context, bool isEmpty, Widget? child) {
        return ZegoTextIconButton(
          onPressed: (){},
          icon: ButtonIcon(
            icon: isEmpty
                ? UIKitImage.asset(StyleIconUrls.iconSendDisable)
                : UIKitImage.asset(StyleIconUrls.iconSend),
            backgroundColor: Colors.white,
          ),
          iconSize: Size(
              ConfigSize.defaultSize!*34,
              ConfigSize.defaultSize!*34,
          ),
          buttonSize: Size( ConfigSize.defaultSize!*35,  ConfigSize.defaultSize!*35,),
        );
      },
    );
  }
}
