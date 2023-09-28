import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class FFFVRow extends StatelessWidget {
  final MyDataModel myDataModel ;
  final bool? userProfile;
  const FFFVRow({required this.myDataModel ,  this.userProfile, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        columnInfo(
          context: context,
          num: myDataModel.numberOfFriends.toString(),
          title: StringManager.friends.tr(),
          userProfile: userProfile,
          onTap: () => Navigator.pushNamed(context, Routes.fff,
              arguments: StringManager.friends.tr()),
        ),
        columnInfo(
            context: context,
            num: myDataModel.numberOfFollowings.toString(),
            title: StringManager.follwoing.tr(),
            userProfile: userProfile,
            onTap: () => Navigator.pushNamed(context, Routes.fff,
                arguments: StringManager.follwoing.tr())),
        columnInfo(
            context: context,
            num: myDataModel.numberOfFans.toString(),
            title: StringManager.followers.tr(),
            userProfile: userProfile,
            onTap: () => Navigator.pushNamed(context, Routes.fff,
                arguments: StringManager.followers.tr())),
        columnInfo(
            context: context,
            num: myDataModel.profileVisotrs.toString(),
            title: StringManager.vistors.tr(),
            userProfile: userProfile,
            onTap: () => Navigator.pushNamed(context, Routes.vistorScreen,
                )),
      ],
    );
  }
}

Widget columnInfo(
    {required String title,
    required String num,
    required BuildContext context,
    bool? userProfile,
    void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'ElMessiri',
            fontSize: ConfigSize.defaultSize! * 1.6,
            color: Colors.grey,
          ),
        ),
        Text(
          num,
          style:

          TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: ConfigSize.defaultSize! * 1.6,
                  color: Colors.white,
                ),
        )
      ],
    ),
  );
}
