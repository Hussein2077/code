import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/cursel_bloc/cursel_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/cursel_bloc/cursel_state.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_states.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/aduio/audio_live_row.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/country_icon.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/page_view.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/country_dilog.dart';

import '../../../../../../core/resource_manger/routs_manger.dart';

class AduioBody extends StatefulWidget {
  static String type = StringManager.popular;
  static int? countryId;
  const AduioBody({super.key});

  @override
  State<AduioBody> createState() => _AduioBodyState();
}

class _AduioBodyState extends State<AduioBody> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        top: ConfigSize.defaultSize! * 2,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(ConfigSize.defaultSize! * 4),
              topLeft: Radius.circular(ConfigSize.defaultSize! * 4))),
      child: LiquidPullToRefresh(
          color: ColorManager.bage,
        backgroundColor: ColorManager.loadingColor,
        showChildOpacityTransition: false,
        onRefresh: () async {
          BlocProvider.of<GetRoomsBloc>(context).add(GetRoomsEvent(
              typeGetRooms:
                  // ignore: unnecessary_null_comparison
                  AduioBody.type == null ? null : TypeGetRooms.popular,
              countryId: AduioBody.countryId));
        },
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
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
                Padding(
                  padding:  EdgeInsets.only(
                    bottom: ConfigSize.defaultSize!*3,
                    left: ConfigSize.defaultSize!*2.5,
                    right: ConfigSize.defaultSize!*2.5
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      topRankIcon(context: context)
                    ],
                  ),
                ),

                BlocBuilder<GetRoomsBloc, GetRoomsStates>(
                  builder: (context, state) {
                    switch (state.getRoomsState) {
                      case RequestState.loaded:
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.rooms.length,
                            itemBuilder: (context, index) {
                              int style = 0;
                              if (index == 0 || index == 1 || index == 2) {
                                style = index;
                              } else {
                                style = index % 3;
                              }
                              return AduioLiveRow(
                                room: state.rooms[index],
                                style: style,
                              );
                            });
                      case RequestState.loading:
                        return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            child: const LoadingWidget());
                      case RequestState.error:
                        return CustomErrorWidget(
                          message: state.errorMessage,
                        );
                    }
                  },
                )
              ],
            )),
      ),
    );
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<GetRoomsBloc>(context).add(LoadMoreRoomsEvent(
          // ignore: unnecessary_null_comparison
          typeGetRooms: AduioBody.type == null ? null : TypeGetRooms.popular,
          countryId: AduioBody.countryId));
    } else {}
  }
}

Widget topRankIcon({
  required BuildContext context,
}) {
  return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.topUsersScreen);
      },
      child: Container(
        margin: EdgeInsets.only(right: ConfigSize.defaultSize!),
        width: ConfigSize.defaultSize! * 15,
        height: ConfigSize.defaultSize! * 4.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
            gradient: const LinearGradient(colors: ColorManager.mainColorList)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Text(StringManager.rank.tr(),style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontSize: ConfigSize.defaultSize! * 1.8,
          )),
          Image.asset(
          AssetsPath.topUserIcon,
          scale: 2,
        ),],)
      ));
}
