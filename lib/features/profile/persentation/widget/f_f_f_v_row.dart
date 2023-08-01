import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class FFFVRow extends StatelessWidget {
  final OwnerDataModel userData ; 
  final bool? userProfile;
  const FFFVRow({required this.userData ,  this.userProfile, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        columnInfo(
          context: context,
          num: userData.numberOfFriends.toString(),
          title: StringManager.friends,
          userProfile: userProfile,
          onTap: () => Navigator.pushNamed(context, Routes.fff,
              arguments: StringManager.friends),
        ),
        columnInfo(
            context: context,
            num: userData.numberOfFollowings.toString(),
            title: StringManager.follwoing,
            userProfile: userProfile,
            onTap: () => Navigator.pushNamed(context, Routes.fff,
                arguments: StringManager.follwoing)),
        columnInfo(
            context: context,
            num: userData.numberOfFans.toString(),
            title: StringManager.followers,
            userProfile: userProfile,
            onTap: () => Navigator.pushNamed(context, Routes.fff,
                arguments: StringManager.followers)),
        columnInfo(
            context: context,
            num: userData.profileVisotrs.toString(),
            title: StringManager.vistors,
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
          style: userProfile == null
              ? Theme.of(context).textTheme.bodyLarge
              : TextStyle(
                  fontFamily: 'ElMessiri',
                  fontSize: ConfigSize.defaultSize! * 1.6,
                  color: Colors.white,
                ),
        )
      ],
    ),
  );
}
