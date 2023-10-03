import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/empty_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment/add_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment/add_moment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_state.dart';

import 'package:tik_chat_v2/features/moment/presentation/widgets/tab_view_body.dart';


class MyMomentsScreen extends StatelessWidget{
  List<MomentModel>? tempData = [];

  MyMomentsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return
      BlocListener<AddMomentBloc,AddMomentState>(

      listener:(context, state) {
        if(state is AddMomentSucssesState){
          BlocProvider.of<GetMomentBloc>(context).add(GetUserMomentEvent(
            userId: MyDataModel.getInstance().id.toString()

          ));
        }
      },
    child:  BlocBuilder<GetMomentBloc, GetMomentUserState>(
      builder: (context, state) {
        if (state is GetMomentUserSucssesState) {
          tempData = state.data;
          return LiquidPullToRefresh(
            color: ColorManager.bage,
            backgroundColor: ColorManager.mainColor,
            showChildOpacityTransition: false,
            onRefresh: () async {
              BlocProvider.of<GetMomentBloc>(context).add(GetUserMomentEvent(
                  userId: MyDataModel.getInstance().id.toString()));
            },
            child: state.data!.isEmpty
                ? const SingleChildScrollView(
                child: EmptyWidget(
                  message: StringManager.noDataFoundHere,
                ))
                : TabViewBody(momentModelList:state.data!),
          );
        }
        else if (state is GetMomentUserErrorState) {
          return CustomErrorWidget(
            message: state.errorMassage,
          );
        }
        else if (state is GetMomentUserLoadingState) {
          if (tempData!.isEmpty) {
            return Container(
                width: ConfigSize.screenWidth,
                height: ConfigSize.screenHeight,

                padding: EdgeInsets.symmetric(
                    horizontal:
                    ConfigSize.defaultSize! *
                        0.2),
                child: const LoadingWidget());
          } else {
            return TabViewBody(momentModelList:tempData!);
          }
        } else {
          return const CustomErrorWidget(
            message: StringManager.noDataFoundHere,
          );
        }
      },
    ),
    );


  }
}