
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';

class InvitationToMicDialog extends StatelessWidget {
  final Function onClick;
  const InvitationToMicDialog({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*1.25),
      ),
      child: Container(
        height: ConfigSize.defaultSize!*15.50,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [
                Color(0xffEFFFDB),
                Color(0xffFFF1CC),
              ]
          ),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*1.25),
        ),
        child: Column(
          children: [

            SizedBox(height: ConfigSize.defaultSize!*1.90,),
            Text(StringManager.invitation.tr(),style: Theme.of(context).textTheme.bodyLarge,),

            SizedBox(height: ConfigSize.defaultSize!*1.9,),
            SizedBox(
                height: ConfigSize.defaultSize!*4.25,
                child: Text(StringManager.youHaveInvitiontoMic.tr(),
                  style:   Theme.of(context).textTheme.bodyLarge,)
            ),
            Divider(
              color: Colors.black.withOpacity(0.12),
            ),
            SizedBox(height: ConfigSize.defaultSize!*0.2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    RoomScreen.isInviteToMic = false;
                    Navigator.pop(context);
                  },
                  child:Text(StringManager.cancle.tr(),style:Theme.of(context).textTheme.bodyLarge  ,)
                ),
                SizedBox(
                  height:ConfigSize.defaultSize!*2.0,
                  child: const VerticalDivider(
                    color: Color(0xffB5B5B5),
                    width: 1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    onClick();
                    RoomScreen.isInviteToMic = false;
                  },
                  child: Text(StringManager.cancle.tr(),
                    style:Theme.of(context).textTheme.bodyLarge!.copyWith(color: const Color(0xff008751))  ,)

                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
