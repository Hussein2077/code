import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_state.dart';

import 'widgets/chose_topic_dailog.dart';
import 'widgets/upload_video.dart';

class UploadReelsScreen extends StatefulWidget {
  const UploadReelsScreen({super.key});

  @override
  State<UploadReelsScreen> createState() => UploadReelsScreenState();
}

class UploadReelsScreenState extends State<UploadReelsScreen> {
  late TextEditingController reelsNameController;
  static List<int> selectedIntrest = [];
  @override
  void initState() {
    selectedIntrest = [];
    reelsNameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: ConfigSize.defaultSize!,
          ),
          const HeaderWithOnlyTitle(title: StringManager.newReel),
          shareYourMoment(context: context),
          const UploadVideo(),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(ConfigSize.defaultSize! * 2),
                border: Border.all(color: ColorManager.lightGray)),
            width: MediaQuery.of(context).size.width - 50,
            child: TextFieldWidget(
                textColor: Theme.of(context).colorScheme.primary,
                controller: reelsNameController,
                hintText: StringManager.reelName),
          ),
          CustomHorizntalDvider(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),

          // reelRowWidget(
          //     context: context,
          //     icon: AssetsPath.mentionIcon,
          //     title: StringManager.mentionYourFriends,
          //     widget: const MentionDailog()),
          reelRowWidget(
              context: context,
              icon: AssetsPath.hashTagIcon,
              title: StringManager.chooseTheTopic,
              widget: const ChooseTopicDailog()),
          BlocBuilder<UploadReelsBloc, UploadReelsState>(
            builder: (context, state) {
              if (state is UploadReelsLoadingState){
          return MainButton(
                  onTap: () {

              errorToast(context: context, title: StringManager.pleaseWaitReel.tr());
                  },
                  title: StringManager.loading.tr());
              }else {
                  return MainButton(
                  onTap: () {

                    if (UploadVideoState.video != null) {
                      BlocProvider.of<UploadReelsBloc>(context).add(
                          UploadReelsEvent(
                              categories: selectedIntrest,
                              description: reelsNameController.text,
                              reel: File(UploadVideoState.video!)));
                              Navigator.pop(context);
                    } else {
                      errorToast(
                          context: context,
                          title: StringManager.pleaseChosseVideo.tr());
                    }
                  },
                  title: StringManager.postTheVideo);
              }
            
            },
          )
        ],
      ),
    );
  }
}

Widget shareYourMoment({required BuildContext context}) {
  return Column(
    children: [
      Row(
        children: [
          SizedBox(
            width: ConfigSize.defaultSize,
          ),
          Image.asset(
            AssetsPath.reelVideoIcon,
            scale: 2,
          ),
          SizedBox(
            width: ConfigSize.defaultSize,
          ),
          Text(
            StringManager.shareYourMoment,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
      Text(
        StringManager.yourVideoWillPublished,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    ],
  );
}

Widget reelRowWidget(
    {required BuildContext context,
    required String icon,
    required String title,
    required Widget widget}) {
  return InkWell(
    onTap: () {
      bottomDailog(context: context, widget: widget);
    },
    child: Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        Image.asset(
          icon,
          scale: 2.5,
        ),
        const Spacer(
          flex: 1,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Spacer(
          flex: 15,
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.primary,
          size: ConfigSize.defaultSize! * 1.6,
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    ),
  );
}
