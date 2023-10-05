
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/room_video/presentaion/manager/video_room_handler_manager/video_room_handler_bloc.dart';
import 'package:tik_chat_v2/features/room_video/presentaion/manager/video_room_handler_manager/video_room_handler_states.dart';


class VideoHandlerRoomScreen extends StatefulWidget {
  const VideoHandlerRoomScreen({super.key});

  @override
  HandlerRoomScreenState createState() => HandlerRoomScreenState();
}

class HandlerRoomScreenState extends State<VideoHandlerRoomScreen>  with SingleTickerProviderStateMixin{

  @override
  void initState() {


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoRoomHandlerBloc, VideoRoomHandlerStates>(
        builder: (context,state){

          return const  LoadingWidget() ;

        },
        listener: (context,state )async{

        }
    );
  }
}




