import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/heaser_room/widgets/top_in_room_screen/Widgets/item_rank_inRoom.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/general_room_profile.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_top_inroom/topin_room_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_top_inroom/topin_room_states.dart';


class TopInRoomScreenBody extends StatelessWidget {
  final TabController dateController;
  final int id;
  final EnterRoomModel roomData ;
  final MyDataModel myData ;
  final LayoutMode layoutMode ;
  const TopInRoomScreenBody({required this.id,required this.layoutMode, required this.myData, required this.roomData,
    required this.dateController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: ConfigSize.screenHeight!-430,
        child: TabBarView(controller: dateController, children: [
          BlocBuilder<TobinRoomBloc, GetTopInRoomState>(
              builder: (context, state) {
            switch (state.todayState) {
              case RequestState.loaded:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: state.todayUserTopModel.isEmpty
                      ? SizedBox(
                          width: ConfigSize.defaultSize!*34.7,
                          child: Text(StringManager.noDaimonsNow.tr(),
                              style:const TextStyle(
                                  color: ColorManager.darkBlack,
                                  fontWeight: FontWeight.w700)),
                        )
                      : SizedBox(
                          width: double.maxFinite,
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    state.todayUserTopModel.length, (index) {
                                  return InkWell(
                                    onTap: () {
                                  Navigator.pop(context) ;
                                  bottomDailog(
                                      context: context,
                                      widget: GeneralRoomProfile(
                                      
                                      userId:state.todayUserTopModel[index].userId.toString() ,
                                      myData:myData,
                                      roomData:roomData,
                                     layoutMode:layoutMode
                                      )
                                  );
                                                                                                        Methods().userProfileNvgator(context: context , userId:state.todayUserTopModel[index].userId.toString());


                                   
                          
                                    },
                                    child: ItemRankInRoom(
                                      userTopMode:
                                          state.todayUserTopModel[index],
                                    ),
                                  );
                                })),
                          ),
                        ),
                );
              case RequestState.loading:
                return const LoadingWidget(

                );
              case RequestState.error:
                return Center(
                    child: SizedBox(
                  child: Text(
                    state.todayErrorMassage,
                    style: const TextStyle(
                        color: ColorManager.lightGray,
                        fontWeight: FontWeight.w700),
                  ),
                ));
            }
          }),
          BlocBuilder<TobinRoomBloc, GetTopInRoomState>(
              builder: (context, state) {
            switch (state.totalState) {
              case RequestState.loaded:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: state.totalUserTopModel.isEmpty
                      ? Text(
                    StringManager.noDaimonsNow.tr(),
                          style: const TextStyle(
                              color: ColorManager.darkBlack,
                              fontWeight: FontWeight.w700),
                        )
                      : SizedBox(
                          width: double.maxFinite,
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    state.totalUserTopModel.length, (index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        bottomDailog(
                                            context: context,
                                            widget:const SizedBox()
                                            // GenralProfileDialog(
                                            //     userId:state. totalUserTopModel[index].userId.toString() ,
                                            //   myData: myData,
                                            //   roomData:roomData,
                                            //     layoutMode:layoutMode
                                            // )

                                        );

                          
                                      },
                                      child: ItemRankInRoom(
                                        userTopMode:
                                            state.totalUserTopModel[index],
                                      ));
                                })),
                          ),
                        ),
                );
              case RequestState.loading:
                return const LoadingWidget();
              case RequestState.error:
                return Center(
                    child: SizedBox(
                  child: Text(
                    state.todayErrorMassage,
                    style: const TextStyle(
                        color: ColorManager.lightGray,
                        fontWeight: FontWeight.w700),
                  ),
                ));
            }
          })
        ]));
  }
}
