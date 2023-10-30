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
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_bloc.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_event.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_state.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/video/video_live_box.dart';

class FollowingLiveScreen extends StatefulWidget {
  const FollowingLiveScreen({super.key});

  @override
  State<FollowingLiveScreen> createState() => _FollowingLiveScreenState();
}

class _FollowingLiveScreenState extends State<FollowingLiveScreen>
      {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 2,
          ),
          Text(StringManager.follwoing.tr(),
              style: Theme.of(context).textTheme.headlineLarge),
          SizedBox(
            height: ConfigSize.defaultSize! * 2,
          ),
          LiquidPullToRefresh(
            color: ColorManager.bage,
            backgroundColor: ColorManager.loadingColor,
            showChildOpacityTransition: false,
            onRefresh: () async {
              BlocProvider.of<GetFollwersRoomBloc>(context)
                  .add(const GetFollwersRoomEvent(type: "5"));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: ConfigSize.defaultSize! * 0.5,
                  ),
                  BlocBuilder<GetFollwersRoomBloc, GetFollwersRoomState>(
                    builder: (context, state) {
                      if (state is GetFollwersRoomSucssesState) {
                        return state.rooms.data!.isEmpty
                            ? EmptyWidget(
                                message: StringManager.nooneIsAwake.tr(),
                                backgrpundColor: Colors.transparent,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge,
                              )
                            : SizedBox(
                                width: ConfigSize.screenWidth,
                                height: ConfigSize.screenHeight! * 0.79,
                                child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemCount: state.rooms.data!.length,
                                    itemBuilder: (context, index) {
                                      return VideoLiveBox(
                                        room: state.rooms.data![index],
                                      );
                                    }),
                              );
                      } else if (state is GetFollwersRoomErrorState) {
                        return CustomErrorWidget(
                          message: state.error,
                        );
                      } else if (state is GetFollwersRoomLoadingState) {
                        return const LoadingWidget();
                      } else {
                        return CustomErrorWidget(
                            message: StringManager.unexcepectedError.tr());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
