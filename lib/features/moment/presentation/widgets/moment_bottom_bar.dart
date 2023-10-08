
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/comments/moment_comments_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/moment_giftbox_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/moment_sent_gifts_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/likes/moment_likes_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_make_moment_like/make_moment_like_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_make_moment_like/make_moment_like_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/moment_controller.dart';


class MomentBottomBar extends StatefulWidget {
  final MomentModel momentModel;
  final String? type;
  const MomentBottomBar({
    required this.momentModel,
     this.type,
    super.key,
  });

  @override
  State<MomentBottomBar> createState() => MomentBottomBarState();
}

class MomentBottomBarState extends State<MomentBottomBar> {
  static ValueNotifier<int> commentsCounter = ValueNotifier<int>(0);
  static ValueNotifier<int> likeNotifierCounter = ValueNotifier<int>(0);
  static ValueNotifier<int> giftsNotifierCounter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ConfigSize.defaultSize! * 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //the likes row
          Row(
            children: [
              InkWell(
                onTap: () {
                  bottomDailog(
                      context: context,
                      widget: MomentsLikesScreen(
                        momentId: widget.momentModel.momentId.toString(),
                      ),
                      color: Colors.white);
                },
                child: SizedBox(
                  width: ConfigSize.defaultSize! * 6,
                  child: Center(
                    child: ValueListenableBuilder(
                      valueListenable: likeNotifierCounter,
                      builder:
                          (BuildContext context, int value, Widget? child) {
                        return Text(
                            MomentController
                                .favoritesCount[widget.momentModel.momentId]
                                .toString(),
                            style: Theme.of(context).textTheme.bodyLarge);
                      },
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder<int>(
                valueListenable: likeNotifierCounter,
                builder: (context, likeCount, child) {
                  return InkWell(
                    onTap: () {
                      MomentController.selectedMomentLike =
                          widget.momentModel.momentId;
                      BlocProvider.of<MakeMomentLikeBloc>(context).add(
                          MakeMomentLikeEvent(
                              momentId:
                                  widget.momentModel.momentId.toString()));
                    },
                    child: Image.asset(
                      AssetsPath.likeIcon,
                      color:
                      MomentController.favorites[widget.momentModel.momentId]!
                              ? ColorManager.orang
                              : Theme.of(context).colorScheme.primary,
                      scale: 0.1,
                    ),
                  );
                },
              )
            ],
          ),
          InkWell(
            onTap: () {
              MomentController.selectedMomentComment=widget.momentModel.momentId;

              bottomDailog(
                  context: context,
                  widget: MomentCommentsScreen(
                      type:widget.type,
                    momentId: widget.momentModel.momentId.toString(),
                  ),
                  color: Theme.of(context).colorScheme.background);
            },
            child: Row(
              //comment row
              children: [
                ValueListenableBuilder(
                  valueListenable: commentsCounter,
                  builder: (BuildContext context, int value, Widget? child) {
                    return SizedBox(
                      width: ConfigSize.defaultSize! * 5,
                      child: Center(
                        child: Text(
                            MomentController.commentsOfMomentsMap[
                                    widget.momentModel.momentId]
                                .toString(),
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                    );
                  },
                ),
                Image.asset(AssetsPath.commentIcon,
                    color: Theme.of(context).colorScheme.primary,
                    scale: 0.1),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {

                  bottomDailog(
                      context: context,
                      widget: MommentSentGiftScreen(momentId: widget.momentModel.momentId.toString(),),
                      color: Theme.of(context).colorScheme.background);
                },
                child: SizedBox(
                  width: ConfigSize.defaultSize! * 6,
                  child: Center(
                    child: ValueListenableBuilder(
                      valueListenable: giftsNotifierCounter,
                      builder:
                          (BuildContext context, int value, Widget? child) {
                        return Text(widget.momentModel.giftsCount.toString(),
                            style: Theme.of(context).textTheme.bodyLarge);
                      },
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  bottomDailog(
                      context: context,
                      widget: MomentGiftboxScreen(
                        myDataModel: MyDataModel(),
                        momentId: widget.momentModel.momentId.toString(),
                      ),
                      color: Theme.of(context).colorScheme.background);
                },
                child: Image.asset(AssetsPath.giftMoment, scale: 0.1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
