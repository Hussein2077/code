

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/dynamic_link.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
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
  static int selectedMoment = -1;

  static int giftsNum = -1;

  static MomentType momentType = MomentType.myMoment;

  static final Map<int, int> giftsOfMomentsMap = {};


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ConfigSize.defaultSize! * 7,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width-ConfigSize.defaultSize!*5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
              InkWell(
                child: SizedBox(
                  width: ConfigSize.defaultSize! * 7,
                  child: Center(
                    child: Text(widget.momentModel.likeNum.toString() ,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                ),
                onTap: (){
                  bottomDailog(
                      context: context,
                      widget: MomentsLikesScreen(
                        momentId: widget.momentModel.momentId.toString(),
                      ),
                      color: Colors.white);
                },
              ),
              InkWell(
                onTap: (){
                  bottomDailog(
                      context: context,
                      height: ConfigSize.screenHeight! * .7,
                      widget: MomentCommentsScreen(
                        type: widget.type,
                        momentId: widget.momentModel.momentId.toString(),
                      ),
                      color: Theme.of(context).colorScheme.background);
                },
                child: Center(
                  child: Text("${widget.momentModel.commentNum}  ${StringManager.comment.tr()}",
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ),
            ],),
          ),
          SizedBox(height: ConfigSize.defaultSize!*1,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //the likes row
              Row(
                children: [

                  InkWell(
                    onTap: () {
                      MomentBottomBarState.selectedMoment = widget.momentModel.momentId;
                      MomentController.getInstance.likeController(context);

                      BlocProvider.of<MakeMomentLikeBloc>(context).add(
                          MakeMomentLikeEvent(
                              momentId: widget.momentModel.momentId.toString()));
                    },
                    child: Icon( widget.momentModel.isLike?Icons.favorite: Icons.favorite_border_outlined,
                        size: ConfigSize.defaultSize! *2.4,

                        color: widget.momentModel.isLike
                            ? Colors.red
                            : Theme.of(context).colorScheme.primary),
                  ),
                  InkWell(
                    onTap: () {
                      MomentBottomBarState.selectedMoment =
                          widget.momentModel.momentId;
                      MomentController.getInstance.likeController(context);

                      BlocProvider.of<MakeMomentLikeBloc>(context).add(
                          MakeMomentLikeEvent(
                              momentId: widget.momentModel.momentId.toString()));

                    },
                    child:
                    SizedBox(
                      width: ConfigSize.defaultSize! * 6,
                      child: Center(
                        child: Text(StringManager.love.tr(),
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ),


                  ),

                ],
              ),
              InkWell(
                onTap: () {
                  MomentBottomBarState.selectedMoment = widget.momentModel.momentId;
                  bottomDailog(
                      context: context,
                      height: ConfigSize.screenHeight! * .7,
                      widget: MomentCommentsScreen(
                        type: widget.type,
                        momentId: widget.momentModel.momentId.toString(),
                      ),
                      color: Theme.of(context).colorScheme.background);
                },
                child: Row(
                  //comment row
                  children: [

                    Image.asset(AssetsPath.commentIcon,
                        color: Theme.of(context).colorScheme.primary, scale: 1),
                    Center(
                      child: Text("  ${StringManager.comments.tr()}",
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      bottomDailog(
                          context: context,
                          widget: MommentSentGiftScreen(
                            momentId: widget.momentModel.momentId.toString(),
                          ),
                          color: Theme.of(context).colorScheme.background);
                    },
                    child: SizedBox(
                      width: ConfigSize.defaultSize! * 4,
                      child: Center(
                        child: Text(widget.momentModel.giftsCount.toString(),
                            style: Theme.of(context).textTheme.bodySmall),
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
                    child: Image.asset(AssetsPath.giftMoment, scale: 1),
                  ),
                ],
              ),
              //share row
              InkWell(
                onTap: () {
                  DynamicLinkProvider()
                      .showMomentLink(
                    momentId: widget.momentModel.momentId.toString(),
                    momentImage: (widget.momentModel.momentImage.toString()=='')?'tik-logo.png':widget.momentModel.momentImage.toString(),
                  )
                      .then((value) {
                    Share.share(value);
                  });
                },
                child: Row(
                  children: [
                    Image.asset(AssetsPath.shareMomentIcon,
                        color: Theme.of(context).colorScheme.primary, scale: 22),
                    Center(
                      child: Text(StringManager.share.tr(),
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
