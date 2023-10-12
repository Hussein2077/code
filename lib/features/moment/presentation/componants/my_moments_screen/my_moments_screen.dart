import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/empty_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_bottom_bar.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/tab_view_body.dart';


class MyMomentsScreen extends StatefulWidget{

  const MyMomentsScreen({
    super.key,
  });

  @override
  State<MyMomentsScreen> createState() => _MyMomentsScreenState();
}

class _MyMomentsScreenState extends State<MyMomentsScreen> {
   ScrollController scrollController=ScrollController();

  List<MomentModel>? tempData = [];
   @override
   void initState() {
     MomentBottomBarState.momentType = MomentType.myMoment ;

     scrollController.addListener(scrollListner);
     super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return
      LiquidPullToRefresh(
        color: ColorManager.bage,
        backgroundColor: ColorManager.mainColor,
        showChildOpacityTransition: false,
        onRefresh: () async {
          BlocProvider.of<GetMomentBloc>(context).add(GetUserMomentEvent(
              userId: MyDataModel.getInstance().id.toString()));
        },
        child: SingleChildScrollView(

          physics: const AlwaysScrollableScrollPhysics(),
          child: BlocBuilder<GetMomentBloc, GetMomentUserState>(
            builder: (context, state) {
              if (state is GetMomentUserSucssesState) {
                tempData = state.data;
                return state.data!.isEmpty
                    ? const EmptyWidget(
                      message: StringManager.noDataFoundHere,
                    )
                    : TabViewBody(momentModelList:state.data!,
                scrollController: scrollController,


                );
              }
              else if (state is GetMomentUserErrorState) {
                return CustomErrorWidget(
                  message: state.errorMassage,
                );
              }
              else if (state is GetMomentUserLoadingState) {
                if (tempData!.isNotEmpty) {
                  return TabViewBody(momentModelList:tempData!,
                  scrollController: scrollController,);

                } else {
                  return Container(
                      width: ConfigSize.screenWidth,
                      height: ConfigSize.screenHeight,
                      padding: EdgeInsets.symmetric(
                          horizontal:
                          ConfigSize.defaultSize! *
                              0.2),
                      child: const LoadingWidget());
                }
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
       BlocProvider.of<GetMomentBloc>(context).add(LoadMoreUserMomentEvent(
           userId: MyDataModel.getInstance().id.toString()));
     }
   }
}