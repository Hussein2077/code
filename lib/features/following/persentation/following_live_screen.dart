import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/empty_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_bloc.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_event.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_state.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/video/video_live_box.dart';
import 'package:tik_chat_v2/features/moment/presentation/moment_screen.dart';

class FollowingLiveScreen extends StatefulWidget {
  const FollowingLiveScreen({super.key});

  @override
  State<FollowingLiveScreen> createState() => _FollowingLiveScreenState();
}

class _FollowingLiveScreenState extends State<FollowingLiveScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this, // Provide a TickerProvider
    );
    // BlocProvider.of<GetMomentBloc>(context).add(GetUserMomentEvent(
    //   userId: MyDataModel.getInstance().id.toString(),
    // ));
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          bottom: TabBar(
            indicatorColor: ColorManager.orang,
            indicatorSize: TabBarIndicatorSize.label,
            padding: EdgeInsets.only(bottom: ConfigSize.defaultSize! * 1.5),
            controller: _tabController,
            tabs: [
              Text(
                StringManager.followingLive.tr(),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                StringManager.momentsTab.tr(),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            BlocBuilder<GetFollwersRoomBloc, GetFollwersRoomState>(
              builder: (context, state) {
                if (state is GetFollwersRoomSucssesState) {
                  return Column(
                    children: [
                      SizedBox(height: ConfigSize.defaultSize!*2,),
                      LiquidPullToRefresh(
                        color: ColorManager.bage,
                        backgroundColor: ColorManager.mainColor,
                        showChildOpacityTransition: false,
                        onRefresh: () async {
                          BlocProvider.of<GetFollwersRoomBloc>(context)
                              .add(const GetFollwersRoomEvent(type: "5"));
                        },
                        child: state.rooms.data!.isEmpty
                            ? const SingleChildScrollView(
                                child: EmptyWidget(
                                message: StringManager.noDataFoundHere,
                              ))
                            : Expanded(
                                child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemCount: state.rooms.data!.length,
                                    itemBuilder: (context, index) {
                                      int style = 0;
                                      if (index == 0 ||
                                          index == 1 ||
                                          index == 2) {
                                        style = index;
                                      } else {
                                        style = index % 3;
                                      }
                                      return VideoLiveBox(
                                        room: state.rooms.data![index],
                                        style: style,
                                      );
                                    }),
                              ),
                      )
                    ],
                  );
                } else if (state is GetFollwersRoomErrorState) {
                  return CustomErrorWidget(
                    message: state.error,
                  );
                } else if (state is GetFollwersRoomLoadingState) {
                  return const LoadingWidget();
                } else {
                  return const CustomErrorWidget(
                      message: StringManager.unexcepectedError);
                }
              },
            ),
            const MomentScreen(),
          ],
        ));
  }
}
