import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/home/data/model/user_top_model.dart';

class UserRoomRow extends StatelessWidget {
  final UserTopModel userTopMode;

  final void Function()? onTap;

  const UserRoomRow({this.onTap, required this.userTopMode, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Methods().userProfileNvgator(
                context: context, userId: userTopMode.userId.toString());
          },
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 1.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            UserImage(
              boxFit: BoxFit.cover,
              image: userTopMode.avater!,
              imageSize:  ConfigSize.defaultSize! * 5,
              frame: userTopMode.frame,
              frameId: userTopMode.frameId,

            ),
            SizedBox(
              width: ConfigSize.defaultSize! * 0.5,
            ),
            Text(
              userTopMode.name.toString(),
              style: TextStyle(
                  fontSize: AppPadding.p14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(
              flex: 20,
            ),
            Text(userTopMode.exp.toString(),
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    fontSize: AppPadding.p12),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis),
            SizedBox(
              width: ConfigSize.defaultSize! * 0.5,
            ),
            Icon(
              Icons.diamond,
              size: AppPadding.p20,
              color: Colors.blue,
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
