import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/show_svga.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_states.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';


class EmojiePageView extends StatefulWidget {
  final String userId;
  final String roomId ;
  const EmojiePageView(
  {required this.numberOfPages, required this.roomId,required this.userId, super.key});
final int numberOfPages;
@override
State<EmojiePageView> createState() => _EmojiePageViewState();
}

class _EmojiePageViewState extends State<EmojiePageView> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) => getIt<OnRoomBloc>()..add(EmojieEvent()),
    child: BlocBuilder<OnRoomBloc, OnRoomStates>(
        builder: (context, state) {
          if (state is GetEmojieErrorState) {
            return Text(state.errorMassage);
          } else if (state is GetEmojieLoadingState) {
            return   TransparentLoadingWidget(
              height: ConfigSize.defaultSize!*2,
              width: ConfigSize.defaultSize!*7.2,
            );
          } else if (state is GetEmojieSucssesState) {
            return Column(
                children: [
                  Container(
                      decoration:  BoxDecoration(color: Colors.black.withOpacity(0.5)),
                      child: CarouselSlider(
                        items: [
                          for (int index = 0; index < 1; index++)
                            GridView.count(
                                crossAxisCount: 3,
                                scrollDirection: Axis.vertical,
                                children: List.generate(
                                  state.data.length,
                                      (index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showingEmojie(
                                            userId:widget.userId,
                                            emojieData: EmojieData(
                                              emojie: state.data[index].emoji,
                                              emojieId: state.data[index].id,
                                              length: state.data[index].tLength,
                                            ),
                                            timeEmojie:state.data[index].tLength) ;

                                        ZegoUIKit().sendInRoomCommand(getMessagaRealTime(
                                            state.data[index].id,
                                            state.data[index].emoji,
                                            state.data[index].tLength,
                                            widget.userId
                                        ) ,[]);

                                      },
                                      child: Column(
                                        children: [
                                          ShowSVGA(
                                            width: ConfigSize.defaultSize!*7,
                                            hieght:ConfigSize.defaultSize!*7 ,
                                            imageId:'${state.data[index].id}$cacheEmojieKey', url: state.data[index].emoji,),
                                          Text(
                                            state.data[index].name,
                                            style: const TextStyle(
                                                color: ColorManager.whiteColor),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ))

                        ],
                        carouselController: _controller,
                        options: CarouselOptions(
                            height: ConfigSize.defaultSize! *26,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(milliseconds: 400),
                            autoPlayCurve: Curves.linear,
                            enlargeCenterPage: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ))]);
          }else{
            return const SizedBox();
          }
        }
    ),
    );
  }

  String getMessagaRealTime( int idEmojie, String emojie, int lenght, String  userId ){
    var mapInformation = {"messageContent":{
      "message":"showEmojie",
      "id":idEmojie,
      "emoji":emojie,
      "t_length":lenght,
      "id_user":userId
    }} ;
    String map = jsonEncode(mapInformation);
    return map ;
  }


}
