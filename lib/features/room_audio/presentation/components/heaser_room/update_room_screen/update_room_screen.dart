import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/update_room_screen/widget/update_room_body.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_states.dart';

class UpdateRoomScreen extends StatefulWidget {
  final EnterRoomModel roomDate;
  final EnterRoomModel room;
  final MyDataModel myDataModel;

  const UpdateRoomScreen({required this.roomDate, Key? key, required this.room, required this.myDataModel}) : super(key: key);

  @override
  State<UpdateRoomScreen> createState() => _UpdateRoomScreenState();
}

class _UpdateRoomScreenState extends State<UpdateRoomScreen> {
  late LayoutMode layoutMode;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    RoomScreen.isGiftEntroAnimating=false ;
    if (widget.room.mode == 1)
    {
      layoutMode = LayoutMode.party;
    } else if (widget.room.mode == 0)
    {
      layoutMode = LayoutMode.hostTopCenter;
    }else if (widget.room.mode == 2) {
      layoutMode = LayoutMode.seats12;
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnRoomBloc, OnRoomStates>(
      builder: (context, state) {
        if (state is UpdateRoomSucsseState) {
          return UpdateRoomBody(
            roomDate: widget.roomDate,
            nameHint: state.data.roomName!,
            introHint: state.data.roomIntro!,
            room: widget.room,
            myDataModel: widget.myDataModel,
            roomMode: layoutMode == LayoutMode.hostTopCenter?0:layoutMode == LayoutMode.party?1:2,
          );
        } else {
          return UpdateRoomBody(
            roomDate: widget.roomDate,
            nameHint: widget.roomDate.roomName!,
            introHint: widget.roomDate.roomIntro!,
            room: widget.room,
            myDataModel: widget.myDataModel,
            roomMode: layoutMode == LayoutMode.hostTopCenter?0:layoutMode == LayoutMode.party?1:2,

          );
        }
      },
    );
  }
}
