import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/data/model/invitation_users_model.dart';

class UserDetailsForParent extends StatelessWidget {
final InvitationUsersModel data;
  const UserDetailsForParent({
    super.key,

    required this.data

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*2.0,),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal:  ConfigSize.defaultSize!*2.0
          , vertical: ConfigSize.defaultSize!*1.0,),
        margin: EdgeInsets.symmetric(vertical:  ConfigSize.defaultSize!*1.0,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular( ConfigSize.defaultSize!*1.0,),
            border: Border.all(
                color: ColorManager.mainColor,
                width: 1)),
        child: Column(
          children: [
            SizedBox(
              height:  ConfigSize.defaultSize!*0.10,
            ),

            Text(
              StringManager.profitProcess.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height:  ConfigSize.defaultSize!*0.10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               UserImage(image: data.image),
                Text(
                  data.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(
              height:  ConfigSize.defaultSize!*0.10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringManager.userID.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  data.invitedId.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(
              height:  ConfigSize.defaultSize!*0.10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    StringManager.coinsCharged.tr(),
                    style: Theme.of(context).textTheme.bodyMedium
                ),
                Text(
                  data.userCharge.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(
              height:  ConfigSize.defaultSize!*0.10,
            ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringManager.percentage.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    data.parentPercentage.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
