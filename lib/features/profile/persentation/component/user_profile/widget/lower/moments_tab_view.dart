import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/empty_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_user_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_user_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_user_moment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_bottom_bar.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/tab_view_body.dart';

class MomentsTabBarView extends StatefulWidget {
  final String userId;

  const MomentsTabBarView({
     required this.userId,
    super.key,
  });

  @override
  State<MomentsTabBarView> createState() => _MomentsTabBarViewState();
}

class _MomentsTabBarViewState extends State<MomentsTabBarView> {
  ScrollController scrollController = ScrollController();

  List<MomentModel>? tempUserData = [];

  @override
  void initState() {
    MomentBottomBarState.momentType = MomentType.userMoment;

      BlocProvider.of<GetOtherUserMomentBloc>(context).add(
          GetOtherUserMomentEvent(userId: widget.userId.toString())

      );

    scrollController.addListener(scrollListner);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: ColorManager.bage,
      backgroundColor: ColorManager.mainColor,
      showChildOpacityTransition: false,
      onRefresh: () async {
        BlocProvider.of<GetOtherUserMomentBloc>(context).add(GetOtherUserMomentEvent(
            userId: MyDataModel
                .getInstance()
                .id
                .toString()));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocBuilder<GetOtherUserMomentBloc, GetMomentOtherUserState>(
          builder: (context, state) {
            if (state is GetMomentOtherUserSucssesState) {
              tempUserData = state.data;
              return state.data!.isEmpty
                  ? EmptyWidget(
                message: StringManager.youDontHaveMoments.tr(),
                backgrpundColor: Colors.transparent,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge,
              )
                  : TabViewBody(
                momentModelList: state.data!,
                scrollController: scrollController,
                isFromUserProfile: true,
              );
            }
            else if (state is GetMomentOtherUserErrorState) {
              return CustomErrorWidget(
                message: state.errorMassage,
              );
            } else if (state is GetMomentOtherUserLoadingState) {

              return const LoadingWidget();


            } else {
              return const CustomErrorWidget(
                message: StringManager.noDataFoundHere,
              );
            }
          },
        ),
      ),
    );
  }

  void scrollListner() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<GetOtherUserMomentBloc>(context).add(LoadMoreOtherUserMomentEvent(
          userId: MyDataModel
              .getInstance()
              .id
              .toString()));
    }
  }
}
