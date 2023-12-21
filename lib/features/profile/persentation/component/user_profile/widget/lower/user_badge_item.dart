import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/data/model/user_badges_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/widgets/achievmenet_image.dart';

class UserBadgesItem extends StatelessWidget {
  const UserBadgesItem({
    super.key,
    required this.userBadges,
    this.height,

    this.scale, this.width,
  });

  final UserBadgesModel userBadges;
  final double? height;
  final double? width;
  final double? scale;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? ConfigSize.screenHeight! * .06,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: userBadges.data.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AchievementCachImageWidget(
                width:width?? ConfigSize.screenWidth! * .08,
                url:ConstentApi().getImage(userBadges.data[index].image),
              ),
            );
          }),
    );
  }
}
