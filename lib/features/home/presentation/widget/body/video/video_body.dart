

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/cursel_bloc/cursel_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/cursel_bloc/cursel_state.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/country_icon.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/page_view.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/video/video_live_box.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/country_dilog.dart';

class VideoBody extends StatelessWidget {
  const VideoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return    Container(

      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
    top: ConfigSize.defaultSize! * 2,
      ),
      decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(ConfigSize.defaultSize! * 4),
          topLeft: Radius.circular(ConfigSize.defaultSize! * 4))),
      child: SingleChildScrollView(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      BlocBuilder<CarouselBloc, CarouselStates>(
        builder: (context, state) {
          if (state is GetCarouselSuccesState) {


            return PageViewWidget(
              carouselsList: state.carouselsList,
            );
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              height: ConfigSize.defaultSize! * 15,
              child: const LoadingWidget(),
            );
          }
        },
      ),

      InkWell(
          onTap: () {
            bottomDailog(
                context: context, widget: const CountryDialog());
          },
          child: ValueListenableBuilder(
            valueListenable: CountryDialog.selectedCountry,
            builder: (context, value, Widget? widget) {
              return CountryIcon(
                flag: CountryDialog.flag,
                name: CountryDialog.name,

              );
            },
          )),

      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 0,
          itemBuilder: (context, index) {
            int style = 0 ; 
            if(index==0 || index==1 ||index==2){
              style = index ; 
            }else {
              style = index % 3 ;
            }
            return VideoLiveBox(style: style, room: RoomModelOfAll() ,);
          })
    ],
      )),
    );
  }
}