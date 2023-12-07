import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/id_with_copy_icon.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/male_female_icon.dart';
import 'package:tik_chat_v2/core/widgets/shimmer_id.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_buy_send_vip/bloc/buy_or_send_vip_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_buy_send_vip/bloc/buy_or_send_vip_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_send/bloc/send_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_send/bloc/send_event.dart';

import 'user_country_icon.dart';
import 'user_image.dart';

class UserInfoRow extends StatelessWidget {
  final UserDataModel userData;

  final double? imageSize;

  final Widget? underName;

  final Widget? endIcon;

  final double? underNameWidth;
  final Widget? idOrNot;

  final String? flag;
  final String? itemId;

  final void Function()? onTap;

  const UserInfoRow(
      {this.underNameWidth,
      this.onTap,
      required this.userData,
      this.endIcon,
      this.underName,
      this.imageSize,
      this.idOrNot,
      this.flag,
      this.itemId,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Methods.instance.userProfileNvgator(
                context: context, userId: userData.id.toString());
          },
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 1.1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            UserImage(
              frame: userData.frame,
              frameId: userData.frameId,
              imageSize: imageSize,
              boxFit: BoxFit.cover,
              image: userData.profile!.image!,
            ),
            SizedBox(
              width: ConfigSize.defaultSize! * 0.2,
            ),
            const Spacer(
              flex: 4,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientTextVip(
                  typeUser: userData.userType??0,
                  text: userData.name ?? "",
                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: ConfigSize.defaultSize! * 1.6,
                      ),
                  isVip: userData.hasColorName!,
                ),
                underName ??
                    Row(
                      children: [
                        MaleFemaleIcon(
                          width: ConfigSize.defaultSize! * 4,
                          height: ConfigSize.defaultSize! * 1.5,
                          maleOrFeamle: userData.profile!.gender,
                          age: userData.profile!.age,
                        ),
                        SizedBox(width: ConfigSize.defaultSize! * 0.2),
                        if (!userData.isCountryHiden!
                            )
                          UserCountryIcon(
                              width: ConfigSize.defaultSize! * 3.5,
                              height: ConfigSize.defaultSize! * 1.5,
                              fontSize: ConfigSize.defaultSize! * 1.5,
                              country: userData.country?.flag??""),
                        SizedBox(width: ConfigSize.defaultSize! * 0.2),
                        if (userData.level!.senderImage != '')
                          LevelContainer(
                            fit: BoxFit.fill,
                            width: ConfigSize.defaultSize! * 4,
                            height: ConfigSize.defaultSize! * 1.5,
                            image: userData.level!.senderImage
                            !,
                          ),
                        if (userData.vip1!.level != 0)
                          AristocracyLevel(
                            level: userData.vip1!.level!,
                          ),
                        SizedBox(
                          width: ConfigSize.defaultSize! * .2,
                        ),
                        idOrNot != null
                            ? idOrNot!
                            :IdWithCopyIcon(userData: userData,)
                      ],
                    )
              ],
            ),
            const Spacer(
              flex: 20,
            ),
            if(flag == null)
            endIcon ??
                Image.asset(
                  AssetsPath.chatWithUserIcon,
                  scale: 2.5,
                ),
            const Spacer(
              flex: 1,
            ),
            if(flag != null)
              InkWell(
                onTap: () {
                  if(flag == 'vip'){
                    BlocProvider.of<BuyOrSendVipBloc>(
                        context)
                        .add(BuyOrSendVipEvent(
                        type: "1",
                        vipId: itemId!,
                        toUId:
                        userData.uuid!));

                    Navigator.pop(context);
                  }else if(flag == 'myLook'){

                    BlocProvider.of<SendBloc>(context)
                        .add(sendItemEvent(
                        packId: itemId!,
                        touId: userData.uuid!));
                    log('myLook');
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: ConfigSize.defaultSize! * 8.1,
                  height: ConfigSize.defaultSize! * 3.1,
                  decoration: BoxDecoration(
                      gradient:
                      const LinearGradient(colors: ColorManager.mainColorList),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      StringManager.send.tr(),
                      style: const TextStyle(color: ColorManager.whiteColor),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
