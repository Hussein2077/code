import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/live_audio_room.dart';

import '../../../../../../../core/widgets/dialog.dart';

class ChooseModeRoom extends StatefulWidget {
  final String ownerId;
  final int modeRoom;
  const ChooseModeRoom({required this.modeRoom, required this.ownerId, Key? key})
      : super(key: key);

  @override
  ChooseModeRoomState createState() => ChooseModeRoomState();
}

class ChooseModeRoomState extends State<ChooseModeRoom> {
  late bool selectedParty;
  late bool selectHost;
  late bool selectMidParty ;

  @override
  void initState() {
    if (widget.modeRoom==0) {
      selectedParty = false;
      selectHost = true;
      selectMidParty = false;
    }
    else if(widget.modeRoom==1) {
      selectedParty = true;
      selectHost = false;
      selectMidParty =false;
    }
    else if(widget.modeRoom==2){
      selectedParty = false;
      selectHost = false;
      selectMidParty =true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.screenHeight! / 2,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: ColorManager.deepBlue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: ConfigSize.defaultSize! * 4.6,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors:ColorManager.mainColorList, // red to yellow
                )),
            child: Center(
              child: Text(
                StringManager.roomMode.tr(),
                style:  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: AppPadding.p18),
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: ()async {
              await    ZegoUIKitPrebuiltLiveAudioRoomState.seatManager!
                      .takeOffAllSeat(isPK: false);
                  BlocProvider.of<OnRoomBloc>(context).add(ChangeModeRoomEvent(
                      ownerId: widget.ownerId, roomMode: '0'));

                  if (selectHost) {
                    setState(() {
                      selectHost = false;
                      selectedParty = false;
                      selectMidParty =false ;
                    });
                  } else {
                    setState(() {
                      selectHost = true;
                      selectedParty = false;
                      selectMidParty =false ;
                    });
                  }
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: ConfigSize.defaultSize! * 11.5,
                          height: ConfigSize.defaultSize! * 13.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage(AssetsPath.topCenterImg),
                            ),
                            border: Border.all(
                              width: selectHost ? 1 : 0,
                              color: selectHost
                                  ? ColorManager.mainColor
                                  : Colors.transparent, // red as border color
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          StringManager.hostMode.tr(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ConfigSize.defaultSize!+4,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: ()async {
                  if(!RoomScreen.isPK.value){
                 await   ZegoUIKitPrebuiltLiveAudioRoomState.seatManager!
                        .takeOffAllSeat(isPK: false);
                    BlocProvider.of<OnRoomBloc>(context).add(ChangeModeRoomEvent(
                        ownerId: widget.ownerId, roomMode: '1'));

                    if (selectedParty) {
                      setState(() {
                        selectHost = false;
                        selectedParty = false;
                        selectMidParty =false ;
                      });
                    }
                    else {
                      setState(() {
                        selectHost = false;
                        selectedParty = true;
                        selectMidParty =false ;
                      });
                    }

                    Navigator.pop(context);
                  }else{
                    showDialog(
                        context: context,
                        builder: (context) {
                          return  DialogScreen(buildContext: context, text: StringManager.youshould.tr(),);

                        });
                  }

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: ConfigSize.defaultSize! * 11.5,
                          height: ConfigSize.defaultSize! * 13.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage(AssetsPath.partyImg),
                              //   fit: BoxFit.fill
                            ),
                            border: Border.all(
                              width: selectedParty ? 1 : 0,
                              color: selectedParty
                                  ? ColorManager.mainColor
                                  : Colors.transparent, // red as border color
                            ),
                          )),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          StringManager.partyMode.tr(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:ConfigSize.defaultSize!+2,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: ()async {
                  if(!RoomScreen.isPK.value){
                 await   ZegoUIKitPrebuiltLiveAudioRoomState.seatManager!
                        .takeOffAllSeat(isPK: false);
                    BlocProvider.of<OnRoomBloc>(context).add(ChangeModeRoomEvent(
                        ownerId: widget.ownerId, roomMode: '2'));

                    if (selectMidParty) {
                      setState(() {
                        selectHost = false;
                        selectedParty = false;
                        selectMidParty =false ;
                      });
                    }
                    else {
                      setState(() {
                        selectHost = false;
                        selectedParty = false;
                        selectMidParty =true ;
                      });
                    }
                    Navigator.pop(context);
                  }else{
                    //todo creat dialog you should close pk

                    showDialog(
                        context: context,
                        builder: (context) {
                          return  DialogScreen(buildContext: context, text: StringManager.youshould.tr(),);

                        });
                    // QuickAlert.show(
                    //   barrierDismissible: true,
                    //   width: 20,
                    //   context: context,
                    //   type: QuickAlertType.error,
                    //   text: StringManager.youShoudClosePK.tr(),
                    //   confirmBtnColor: Colors.white,
                    //   backgroundColor: ColorManager.secondColor,
                    //   confirmBtnTextStyle: const TextStyle(
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    //   barrierColor: Colors.white,
                    //   titleColor: Colors.white,
                    //   textColor: Colors.white,
                    // );
                  }

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: ConfigSize.defaultSize! * 11.5,
                          height: ConfigSize.defaultSize! * 13.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage(AssetsPath.midPartyMode),
                            ),
                            border: Border.all(
                              width: selectMidParty ? 1 : 0,
                              color: selectMidParty
                                  ? ColorManager.mainColor
                                  : Colors.transparent, // red as border color
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          StringManager.midePartyMode.tr(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:ConfigSize.defaultSize!+2,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
