
import 'package:easy_localization/easy_localization.dart';
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
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_trending/get_moment_all_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_trending/get_moment_all_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_trending/get_moment_all_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_bottom_bar.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/tab_view_body.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/splash.dart';

class AllMomentsScreen extends StatefulWidget {
  const AllMomentsScreen({super.key});

  @override
  State<AllMomentsScreen> createState() => _AllMomentsScreenState();
}

class _AllMomentsScreenState extends State<AllMomentsScreen> {
  List<MomentModel>? tempData = [];

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    if (SplashScreen.initPage == 4) {
      BlocProvider.of<GetMomentallBloc>(context)
          .add( GetMomentAllEvent(momentId:MainScreen.momentId ));    }
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
        BlocProvider.of<GetMomentallBloc>(context)
            .add( GetMomentAllEvent());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),

        child: BlocBuilder<GetMomentallBloc, GetMomentAllState>(
          builder: (context, state) {
            if (state is GetMomentAllSucssesState) {
              tempData = state.data;

              return state.data!.isNotEmpty
                  ? TabViewBody(momentModelList:state.data!,scrollController:scrollController , )
                  :
              EmptyWidget(
                message: StringManager.nooneIsAwake.tr(),
                backgrpundColor: Colors.transparent,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge,
              );
            }
            else if (state is GetMomentAllErrorState) {
              return CustomErrorWidget(
                message: state.errorMassage,
              );
            }
            else if (state is GetMomentAllLoadingState) {
              if (tempData!.isNotEmpty) {
                return  TabViewBody(momentModelList:tempData!,scrollController: scrollController, );
              } else {
                return Container(
                    width: ConfigSize.screenWidth,
                    height: ConfigSize.screenHeight,
                    padding: EdgeInsets.symmetric(
                        horizontal:
                        ConfigSize.defaultSize! *
                            0.2),
                    child: const LoadingWidget());

              }          }
            else {
              return

                const CustomErrorWidget(
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
      BlocProvider.of<GetMomentallBloc>(context)
          .add(const LoadMoreMomentAllEvent());
    }
  }

}
