import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/number_of_visitor/visitors_room_screen/Widgets/Header_Of_Visitor_Room.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_room_vistor/room_vistor_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_room_vistor/room_vistor_event.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_room_vistor/room_vistor_state.dart';
import 'package:tik_chat_v2/features/room/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';
class VisitorsRoomScreen extends StatefulWidget {
  const  VisitorsRoomScreen(
      {required this.roomData,
      required this.myDataModel,
      required this.numberOfVistor,
        required this.layoutMode,
      Key? key})
      : super(key: key);
 final MyDataModel myDataModel;
 final EnterRoomModel roomData;
  final int numberOfVistor;
  final LayoutMode layoutMode ;

  @override
  State<VisitorsRoomScreen> createState() => _VisitorsRoomScreenState();
}

class _VisitorsRoomScreenState extends State<VisitorsRoomScreen> {
    final ScrollController scrollController = ScrollController();
 @override
  void initState() {
    scrollController.addListener(scrollListener);
    BlocProvider.of<RoomVistorBloc>(context).add(GetAllRoomUserEvents(
        ownerId: widget.roomData.ownerId.toString(),
        usersIds: splitUsersInRoom(orginalList: ZegoUIKit().getAllUsers())));
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

   return BlocBuilder<RoomVistorBloc,RoomVistorState>(
    builder: (context, state) {
   if (state is GetRoomVistorSucssesState){
         return Container(
      height: ConfigSize.screenHeight! / 1.5,
      color: Theme.of(context).colorScheme.background,
      child: Column(children: [
        HeaderofVisitorRoom( numberOfVistor:widget.numberOfVistor),
        // Expanded(
        //     child: SingleChildScrollView(
        //       controller: scrollController,
        //       physics: const AlwaysScrollableScrollPhysics(),
        //         child: VisitorsScreenRoomBody(
        //           data: state.getRoomUsersEntite,
        //           roomData: roomData,
        //           myDataModel: myDataModel,
        //           layoutMode: layoutMode,
        //         ))
        //         )
      ]),
    );
    }else if (state is GetRoomVistorLoadinglState ){
      return const TransparentLoadingWidget();

    }
    
    else if (state is GetRoomVistorErrorState){
      return CustomErrorWidget(message: state.errorMassage,);
   }else{
               return CustomErrorWidget(message: StringManager.unexcepectedError.tr());

      }
    });
  }
  
  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<RoomVistorBloc>(context).add(
          GetMoreRoomUserEvents(ownerId: widget.roomData.ownerId.toString()));
    }
  }
}
