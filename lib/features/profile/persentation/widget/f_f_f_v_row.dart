import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class FFFVRow extends StatelessWidget {
  final bool? userProfile;
  const FFFVRow({this.userProfile, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        columnInfo(
          context: context,
          num: "10",
          title: StringManager.friends,
          userProfile: userProfile,
          onTap: () => Navigator.pushNamed(context, Routes.fffv,
              arguments: StringManager.friends),
        ),
        columnInfo(
            context: context,
            num: "20",
            title: StringManager.follwoing,
            userProfile: userProfile,
            onTap: () => Navigator.pushNamed(context, Routes.fffv,
                arguments: StringManager.follwoing)),
        columnInfo(
            context: context,
            num: "46",
            title: StringManager.followers,
            userProfile: userProfile,
            onTap: () => Navigator.pushNamed(context, Routes.fffv,
                arguments: StringManager.followers)),
        columnInfo(
            context: context,
            num: "22",
            title: StringManager.vistors,
            userProfile: userProfile,
            onTap: () => Navigator.pushNamed(context, Routes.fffv,
                arguments: StringManager.vistors)),
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
