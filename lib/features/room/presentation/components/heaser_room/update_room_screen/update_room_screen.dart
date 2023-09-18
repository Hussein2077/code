import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/update_room_screen/widget/update_room_body.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_states.dart';

class UpdateRoomScreen extends StatefulWidget {
  final EnterRoomModel roomDate;

  const UpdateRoomScreen({required this.roomDate, Key? key}) : super(key: key);

  @override
  State<UpdateRoomScreen> createState() => _UpdateRoomScreenState();
}

class _UpdateRoomScreenState extends State<UpdateRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnRoomBloc, OnRoomStates>(
      builder: (context, state) {
        if (state is UpdateRoomSucsseState) {
          return UpdateRoomBody(
            roomDate: widget.roomDate,
            nameHint: state.data.roomName!,
            introHint: state.data.roomIntro!,
          );
        } else {
          return UpdateRoomBody(
            roomDate: widget.roomDate,
            nameHint: widget.roomDate.roomName!,
            introHint: widget.roomDate.roomIntro!,
          );
        }
      },
    );
  }
}
