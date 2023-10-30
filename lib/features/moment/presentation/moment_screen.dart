import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/all_moments/all_moments.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/following_moments/following_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/liked_moments/liked_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/my_moments_screen/my_moments_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment_comment/add_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment_comment/add_moment_comment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_comment/delete_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_comment/delete_moment_comment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_moment/delete_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_moment/delete_moment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_make_moment_like/make_moment_like_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_make_moment_like/make_moment_like_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_send_gift/moment_send_gift_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_send_gift/moment_send_gift_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/moment_controller.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/add_moment_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_bottom_bar.dart';

import '../../../core/utils/config_size.dart';

class MomentScreen extends StatefulWidget {
  const MomentScreen({super.key});

  @override
  State<MomentScreen> createState() => MomentScreenState();
}

class MomentScreenState extends State<MomentScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  Map<int,bool> favorites = {};

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      vsync: this, // Provide a TickerProvider
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteMomentCommentBloc, DeleteMomentCommentState>(
      listener: (context, state) {
        if (state is DeleteMomentCommentSucssesState) {
          MomentController.getInstance.commentController(context , "delete");
        } else if (state is DeleteMomentCommentErrorState) {
          errorToast(context: context, title: state.error);
        } else if (state is DeleteMomentCommentLoadingState) {
          loadingToast(context: context);
        }
      },
  child: BlocListener<MakeMomentLikeBloc, MakeMomentLikeStates>(
      listener: (_, state) {
        if (state is MakeMomentLikeSucssesState) {
          MomentController.getInstance.likeController(context);
        }
      },
      child: BlocListener<MomentSendGiftBloc, MomentSendGiftStates>(
        listener: (context, state) {
          if (state is MomentSendGiftSucssesState) {

            MomentController.getInstance.giftController(context);
            sucssesToast(context: context, title: StringManager.sucsses);
          }
          else if (state is MomentSEndGiftErrorState) {

            errorToast(context: context, title: state.errorMessage);
          }
        },
  child: BlocListener<AddMomentCommentBloc, AddMomentCommentState>(
    listener: (context, state) {
      if (state is AddMomentCommentSucssesState) {
        MomentController.getInstance.commentController(context , "add");
          BlocProvider.of<GetMomentCommentBloc>(context)
              .add(GetMomentCommentEvent(
            momentId: MomentBottomBarState.selectedMoment.toString(),
          ));
        }
    },
    child: BlocListener<DeleteMomentBloc, DeleteMomentState>(
      listener:       (context, state) {
        if(state is DeleteMomentSucssesState) {

            sucssesToast(context: context, title: state.message);
          }
        else if(state is DeleteMomentErrorState){
          errorToast(context: context, title: state.error);
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SizedBox(
            width: ConfigSize.screenWidth,
            height: ConfigSize.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: ConfigSize.defaultSize! * 4,
                  width: ConfigSize.screenWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    border: Border.all(color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(
                        ConfigSize.defaultSize! * 1.5),
                  ),
                  child: Center(
                    child: TabBar(
                      indicatorColor: ColorManager.orang,
                      isScrollable: true,
                      controller: _tabController,
                      tabs: [
                        Text(
                          StringManager.trendingTab.tr(),
                          style:
                          Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          StringManager.followingTab.tr(),
                          style:
                              Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          StringManager.myMomentsTab.tr(),
                          style:
                          Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          StringManager.likes.tr(),
                          style:
                              Theme.of(context).textTheme.bodyLarge,
                        ),


                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      AllMomentsScreen(),
                      FollowingScreen(),
                      MyMomentsScreen(),
                      LikedScreen(),

                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: ConfigSize.defaultSize!*3),

            width: ConfigSize.defaultSize! * 5,
            height: ConfigSize.defaultSize! * 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5),
              gradient: const LinearGradient(
                  colors: ColorManager.mainColorList


              ),

            ),
            child: IconButton(
              icon: Icon(Icons.edit, color: Theme
                  .of(context)
                  .colorScheme
                  .background ,),


              onPressed: () {
                bottomDailog(
                    context: context,
                    widget: AddMomentScreen(),
                    color: Theme
                        .of(context)
                        .colorScheme
                        .background);
              },
            ),
          ),
        ),
      ),
),
),
),
),
);
  }
}
