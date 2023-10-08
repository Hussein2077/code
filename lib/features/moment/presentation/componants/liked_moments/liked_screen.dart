import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/empty_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/tab_view_body.dart';


class LikedScreen extends StatefulWidget {

  const LikedScreen({super.key, });




  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {



  List<MomentModel>? tempData = [];


  @override
  void initState() {

    BlocProvider.of<GetMomentILikeItBloc>(context)
        .add(const GetMomentIliKEitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMomentILikeItBloc, GetMomentILikeItUserState>(
      builder: (context, state) {
        if (state is GetMomentILikeItSucssesState) {
          return LiquidPullToRefresh(
            color: ColorManager.bage,
            backgroundColor: ColorManager.mainColor,
            showChildOpacityTransition : false,
            onRefresh: () async {
              BlocProvider.of<GetMomentILikeItBloc>(context)
                  .add(const GetMomentIliKEitEvent());
            },
            child: state.data!.isEmpty
                ? const SingleChildScrollView(
                child: EmptyWidget(
                  message:
                  StringManager.noDataFoundHere,
                ))
                :TabViewBody(momentModelList:state.data!),
          );
        }
        else if (state is GetMomentILikeItErrorState) {
          return CustomErrorWidget(
            message: state.errorMassage,
          );
        }
        else if (state is GetMomentILikeItLoadingState) {
          if (tempData!.isNotEmpty) {
            return TabViewBody(momentModelList:tempData!);
          } else { return Container(
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
    );
  }
}