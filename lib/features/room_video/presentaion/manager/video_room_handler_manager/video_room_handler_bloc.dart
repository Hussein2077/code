import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/features/room_video/presentaion/manager/video_room_handler_manager/video_room_handler_events.dart';
import 'package:tik_chat_v2/features/room_video/presentaion/manager/video_room_handler_manager/video_room_handler_states.dart';

class VideoRoomHandlerBloc extends Bloc<VideoRoomHandlerEvents,VideoRoomHandlerStates>{

  VideoRoomHandlerBloc():super(InitialHandlerVideoRoomStates()){

  }

}