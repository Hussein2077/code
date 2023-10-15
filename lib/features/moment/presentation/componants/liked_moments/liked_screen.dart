import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/empty_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_bottom_bar.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/tab_view_body.dart';


class LikedScreen extends StatefulWidget {

  const LikedScreen({super.key, });

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(scrollListner);
    MomentBottomBarState.momentType = MomentType.likedMoment ;
    super.initState();
  }

  List<MomentModel>? tempData = [];

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: ColorManager.bage,
      backgroundColor: ColorManager.mainColor,
      showChildOpacityTransition : false,
      onRefresh: () async {
        BlocProvider.of<GetMomentILikeItBloc>(context)
            .add(const GetMomentIliKEitEvent());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: BlocBuilder<GetMomentILikeItBloc, GetMomentILikeItUserState>(
          builder: (context, state) {
            if (state is GetMomentILikeItSucssesState) {
              tempData=state.data!;
              return state.data!.isEmpty
                  ? const EmptyWidget(
                    message:
                    StringManager.noDataFoundHere,
                  )
                  :TabViewBody(momentModelList:state.data!,scrollController: scrollController);
            } else if (state is GetMomentILikeItErrorState) {
              return CustomErrorWidget(
                message: state.errorMassage,
              );
            } else if (state is GetMomentILikeItLoadingState) {
              if (tempData!.isNotEmpty) {
                return TabViewBody(momentModelList:tempData!,scrollController: scrollController,);
              } else {
                return Container(
                    width: ConfigSize.screenWidth,
                    height: ConfigSize.screenHeight,
                    padding: EdgeInsets.symmetric(
                        horizontal:
                        ConfigSize.defaultSize! *
                            0.2),
                    child: const LoadingWidget());

              }        } else {
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
      BlocProvider.of<GetMomentILikeItBloc>(context)
          .add(const LoadMoreMomentIlikeItEvent());
    }
  }

}