import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/reels/component/upload_reels/widgets/mention_dailog.dart';

import 'widgets/chose_topic_dailog.dart';

class UploadReelsScreen extends StatefulWidget {
  const UploadReelsScreen({super.key});

  @override
  State<UploadReelsScreen> createState() => _UploadReelsScreenState();
}

class _UploadReelsScreenState extends State<UploadReelsScreen> {
  late TextEditingController reelsNameController;
  @override
  void initState() {
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
          videoPic(context: context),
          Container(
            padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
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
          shareYourMoment(context: context),
          reelRowWidget(
              context: context,
              icon: AssetsPath.mentionIcon,
              title: StringManager.mentionYourFriends,
              widget: const MentionDailog()),
          reelRowWidget(
              context: context,
              icon: AssetsPath.hashTagIcon,
              title: StringManager.chooseTheTopic,
              widget: const ChooseTopicDailog()),
          MainButton(onTap: () {}, title: StringManager.postTheVideo)
        ],
      ),
    );
  }
}

Widget videoPic({required BuildContext context}) {
  return Container(
    width: MediaQuery.of(context).size.width / 2,
    height: ConfigSize.defaultSize! * 30,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
        image: const DecorationImage(
            image: AssetImage(
              AssetsPath.testImage,
            ),
            fit: BoxFit.fill)),
  );
}

Widget shareYourMoment({required BuildContext context}) {
  return Column(
    children: [
      Row(
        children: [
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
