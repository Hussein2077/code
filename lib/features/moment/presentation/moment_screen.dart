import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/following_moments/following_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/liked_moments/liked_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/my_moments_screen/my_moments_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment_comment/add_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment_comment/add_moment_comment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_moment/delete_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_moment/delete_moment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_make_moment_like/make_moment_like_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_make_moment_like/make_moment_like_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/moment_controller.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/add_moment_screen.dart';
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
      length: 3,
      vsync: this, // Provide a TickerProvider
    );

    BlocProvider.of<GetMomentBloc>(context).add(GetUserMomentEvent(
      userId: MyDataModel.getInstance().id.toString(),
    ));
    BlocProvider.of<GetMomentILikeItBloc>(context)
        .add(const GetMomentIliKEitEvent());
    BlocProvider.of<GetFollowingUserMomentBloc>(context)
        .add(const GetFollowingMomentEvent());

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<MakeMomentLikeBloc, MakeMomentLikeStates>(
      listener: (context, state) {
        if (state is MakeMomentLikeSucssesState) {
          MomentController().likeReverce(
              MomentController.selectedMomentLike);
          MomentController().likecounter(
            MomentController.selectedMomentLike,
          );
        }

      },
  child: BlocListener<GetMomentBloc, GetMomentUserState>(
      listener: (context, state) {
        if (state is GetMomentUserSucssesState) {
          MomentController().fillLikeMaps(state.data!);
          MomentController().fillCommentMap(state.data!);

        }
      },
  child: BlocListener<GetMomentILikeItBloc, GetMomentILikeItUserState>(
      listener: (context, state) {
        if (state is GetMomentILikeItSucssesState) {
          MomentController().fillLikeMaps(state.data!);
          MomentController().fillCommentMap(state.data!);

        }
      },

      child: BlocListener<GetFollowingUserMomentBloc, GetFollowingUserMomentState>(
      listener: (context, state) {
        if (state is GetFollowingUserMomentSucssesState) {
          MomentController().fillLikeMaps(state.data!);
          MomentController().fillCommentMap(state.data!);

        }
      },
  child:  BlocListener<AddMomentCommentBloc, AddMomentCommentState>(
    listener: (context, state) {
      if(state is AddMomentCommentSucssesState){
        MomentController.commentIncrement(MomentController.selectedMomentComment);


      }

    },
  child: BlocListener<DeleteMomentBloc, DeleteMomentState>(
  listener:       (context, state) {
    if(state is DeleteMomentSucssesState){
      MomentController.commentsDecrement(MomentController.selectedMomentComment);

      sucssesToast(context: context, title: state.message);
    }
    else if( state is DeleteMomentLoadingState){
      loadingToast(context: context);
    }
    else if(state is DeleteMomentErrorState){
      errorToast(context: context, title: state.error);
    }
  },
  child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SizedBox(
        width: ConfigSize.screenWidth,
        height: ConfigSize.screenHeight,
        child: Stack(
          children: [
            Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: ConfigSize.defaultSize! * 7,
                  width: ConfigSize.defaultSize! * 41,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    border: Border.all(color: Colors.white),
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize! * 1.5),
                  ),
                  child: TabBar(
                    dividerColor: ColorManager.orang,
                    indicatorColor: Colors.white,
                    indicator: BoxDecoration(
                      color: ColorManager.orang,
                      borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize! * 0.8),
                    ),
                    isScrollable: true,
                    padding: EdgeInsets.all(ConfigSize.defaultSize! * 1.5),
                    controller: _tabController,
                    tabs: [
                      Text(
                        StringManager.followingTab.tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        StringManager.likes.tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        StringManager.myMomentsTab.tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: ConfigSize.screenWidth,
                  height: ConfigSize.screenHeight! * 0.682,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                         FollowingScreen(),
                         const LikedScreen(),
                        MyMomentsScreen(

                        ),
                      ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Container(
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
