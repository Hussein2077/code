import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/chat/user_chat/Logics/functions.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_controller.dart';
import 'dart:ui' as ui;
class ProfileBottomBar extends StatefulWidget {
  final UserDataModel userData;
  const ProfileBottomBar({required this.userData, super.key});

  @override
  State<ProfileBottomBar> createState() => _ProfileBottomBarState();
}

class _ProfileBottomBarState extends State<ProfileBottomBar> {
  bool isFollow = false;
  @override
  void initState() {
    isFollow = widget.userData.isFollow!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FollowBloc, FollowState>(
      listener: (context, state) {

        if (state is FollowSucssesState) {
          isFollow = !isFollow;
          ReelsController.followingMap[widget.userData.id.toString()]=true;
          ReelsController.follow.value = !ReelsController.follow.value;


          setState(() {});
        } else if (state is UnFollowSucssesState) {
          ReelsController.follow.value = !ReelsController.follow.value;
          ReelsController.followingMap[widget.userData.id.toString()]=false;
          isFollow = !isFollow;
          setState(() {});
        }else if (state is  FollowLoadingState){
          loadingToast(context: context, title: StringManager.loading);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: ConfigSize.screenHeight! * .1,
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.background),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            bottomBarColumn(context: context, icon: AssetsPath.chatIconProfile ,onTap:  () async {
              if (widget.userData.isFriend!) {
                Functions.addFireBaseId();
                Navigator.pushNamed(context, Routes.chatPageBody,
                    arguments: ChatPageBodyPramiter(
                        unReadMessages: 0,
                        chatId: widget.userData.chatId!,
                        name: widget.userData.name!,
                        yayaId: widget.userData.id.toString(),
                        image: widget.userData.profile!.image!,
                        notificationId: widget.userData.notificationId!,
                        myName: MyDataModel.getInstance().name!));
              } else {
                errorToast(context: context, title: StringManager.friends);

              }
            },),
            // bottomBarColumn(
            //     context: context,
            //     icon: AssetsPath.sendGiftIconProfile,
            //     title: StringManager.sendGift),

            // bottomBarColumn(context: context , icon: AssetsPath.friendRequestIconProfile ,title: StringManager.addFriend),

            bottomBarColumn(
              context: context,
              icon: isFollow ? AssetsPath.unfollowIcon : AssetsPath.followIcon,
              title: isFollow ? StringManager.unFollow.tr() : StringManager.follow.tr(),
              onTap: () => isFollow
                  ? BlocProvider.of<FollowBloc>(context)
                      .add(UnFollowEvent(userId: widget.userData.id.toString()))
                  : BlocProvider.of<FollowBloc>(context)
                      .add(FollowEvent(userId: widget.userData.id.toString())),
            ),
          ],
        ),
      ),
    );
  }
}

Widget bottomBarColumn(
    {required BuildContext context,
    required String icon,
    String? title,
    void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        title != null
            ? Image.asset(
                icon,
                scale: 2.5,
              )
            : Container(
                padding: EdgeInsets.only(
                    left: ConfigSize.defaultSize! * 6,
                    top: ConfigSize.defaultSize! * 1.2),
                width: ConfigSize.defaultSize! * 11,
                height: ConfigSize.defaultSize! * 5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                  icon,
                ))),
                child: Directionality(
                  textDirection: ui.TextDirection.ltr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringManager.chatWithDifferentTranslation.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ConfigSize.defaultSize! * 1.5),
                      ),
                    ],
                  ),
                ),
              ),
        if (title != null)
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          )
      ],
    ),
  );
}
