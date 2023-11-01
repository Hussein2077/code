

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/dynamic_link.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/warning_dialog.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/lucky_box.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_lucky_boxes/luck_boxes_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_lucky_boxes/luck_boxes_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_pk/pk_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_pk/pk_events.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/core_managers.dart';

class BasicToolDialog extends StatefulWidget {
  final LayoutMode layoutMode;
  final String ownerId;
  final String userId ;
  final bool isOnMic ;
  final EnterRoomModel roomData ;
  const  BasicToolDialog({Key? key,required this.roomData, required this.layoutMode, required this.ownerId, required this.userId, required this.isOnMic}) : super(key: key);

  @override
  State<BasicToolDialog> createState() => _BasicToolDialogState();
}

class _BasicToolDialogState extends State<BasicToolDialog> {
  var voiceChangerSelectedIDNotifier = ValueNotifier<String>("");

  var reverbSelectedIDNotifier = ValueNotifier<String>("");




  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        height: ConfigSize.defaultSize! * 11,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
        topRight: Radius.circular(ConfigSize.defaultSize!-2),
    topLeft: Radius.circular(ConfigSize.defaultSize!-2)),
    color: Colors.white),
    padding: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!+2),
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(flex: 2,),
        InkWell(
          onTap: () {
            Navigator.pop(context);

            BlocProvider.of<LuckyBoxesBloc>(context).add(GetBoxesEvent());




            bottomDailog(
                context: context,
                widget:  LuckyBox(roomData: widget.roomData,));
          },
          child: Column(
            children: [
              Image.asset(AssetsPath.luckyBox,
                width: ConfigSize.defaultSize! * 6,
                height: ConfigSize.defaultSize! * 6,
              ),
              Text(StringManager.luckyBox.tr(),
                  style:  TextStyle(
                      fontSize: ConfigSize.defaultSize!+2,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600))
            ],
          ),
        ),

        const  Spacer(flex: 1,),
        if(widget.isOnMic)
        const  Spacer(flex: 1,),
        if(widget.ownerId == widget.userId)
          ValueListenableBuilder<bool>(
              valueListenable: PKWidget.isStartPK,
              builder: (context,isStartPK,_){
                  return InkWell(
                    onTap: () async{
                      if (widget.layoutMode == LayoutMode.party || widget.layoutMode == LayoutMode.seats12) {
                        showDialog(context: context,
                            builder: (context) {
                             return WarningDialog(buildContext: context,
                                  text: StringManager.cantopen.tr());
                            },);
                      }
                      else if (isStartPK) {
                        showDialog(context: context,
                          builder: (context) {
                            return WarningDialog(buildContext: context,
                                text: StringManager.cantclosepk.tr());
                          },);
                      } else {
                        Navigator.pop(context);
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return const LoadingWidget();
                            });
                        await ZegoLiveAudioRoomManagers().seatManager!
                            .takeOffAllSeat(isPK: true );
                        Navigator.pop(context);
                        activePK();
                        BlocProvider.of<PKBloc>(context)
                            .add(ShowPKEvent(ownerId: widget.ownerId));
                      }
                    },
                    child: Column(
                      children: [
                        Image(
                            width: ConfigSize.defaultSize! * 6,
                            height: ConfigSize.defaultSize! * 6,
                            image:const AssetImage(AssetsPath.pk1)),

                      const  Text(StringManager.pk,
                            style:  TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ) ;
              }),
        if(widget.ownerId == widget.userId)
        const  Spacer(flex: 1,),
        if(widget.ownerId == widget.userId)
        InkWell(
          onTap: () async{
            DynamicLinkProvider().createInvetionRoomLink(
                refCod: widget.roomData.ownerId!,
                password:widget.roomData.roomPassStatus??false,
                ownerImage: widget.roomData.roomCover!)
                .then((value) {
                  Share.share(value);
            });
          },
          child: Column(
            children: [
              Image(
                  width: ConfigSize.defaultSize! * 6,
                  height: ConfigSize.defaultSize! * 6,
                  image: const AssetImage(
                      AssetsPath.iconShare)),
              Text(StringManager.share.tr(),
                  style:  TextStyle(
                      fontSize:ConfigSize.defaultSize!+2,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600))
            ],
          ),
        ),

        const  Spacer(flex: 2,),

      ],
    ) );

  }





}


