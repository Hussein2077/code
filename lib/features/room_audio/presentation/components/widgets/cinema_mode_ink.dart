import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/youtube/youtube_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/youtube/youtube_event.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/core_managers.dart';
class CinemaModeInkwell extends StatelessWidget {
  const CinemaModeInkwell({super.key, required this.ownerId});
final String ownerId;
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () async {
        if (RoomScreen.layoutMode == LayoutMode.cinemaMode) {
          await ZegoLiveAudioRoomManagers()
              .seatManager!
              .takeOffAllSeat(isPK: false);
          Future.delayed(const Duration(milliseconds: 50), () {
            BlocProvider.of<OnRoomBloc>(context).add(
                ChangeModeRoomEvent(
                    ownerId: ownerId, roomMode: '0'));
            BlocProvider.of<YoutubeBloc>(context)
                .add(const InitialViewYoutubeVideoEvent());
            BlocProvider.of<YoutubeBloc>(context)
                .add(const DisposeViewYoutubeVideoEvent());
            Navigator.pop(context);
          });
        }
        else {
          RoomScreen.localCinemaModeShow.value=false;
          await ZegoLiveAudioRoomManagers()
              .seatManager!
              .takeOffAllSeat(isPK: false);
          Future.delayed(const Duration(milliseconds: 50), () {
            BlocProvider.of<OnRoomBloc>(context).add(
                ChangeModeRoomEvent(
                    ownerId: ownerId, roomMode: '3'));
            Navigator.pop(context);
          });
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(AssetsPath.cinemaNewIcon,  width: ConfigSize.defaultSize! * 5,
            height: ConfigSize.defaultSize! * 5,),

          Text(StringManager.cinemaMode.tr(),
              style: TextStyle(
                  fontSize: ConfigSize.defaultSize! + 2,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
