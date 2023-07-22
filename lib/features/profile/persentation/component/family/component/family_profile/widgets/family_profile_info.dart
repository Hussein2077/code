import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/custom_icon.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/user_country_icon.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/aduio/audio_live_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/widgets/family_member_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/widgets/settings_dailog.dart';

class FamilyProfileInfo extends StatelessWidget {
  const FamilyProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          HeaderWithOnlyTitle(
              title: "",
              endIcon: IconButton(
                onPressed: (){
                  bottomDailog(context: context, widget: const SettingsDailog());
                },
                icon: Icon( Icons.settings,
                color: Theme.of(context).colorScheme.primary,
                size: ConfigSize.defaultSize! * 2.5,),
               
              )),
          familyInfo(
              context: context,
              familyId: "23123",
              familyMemeberNum: "12",
              familyName: "عائلة الحمودي"),
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          familyLevelCard(
              context: context,
              currentLevel: "dimond",
              currentlevelPoint: "120.000",
              endLevelPoint: "200.000",
              nextLevel: "diomndII"),
          SizedBox(
            height: ConfigSize.defaultSize! * 2,
          ),
          //bioooooooooooooo
          Text(
            StringManager.familyBio,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            "عيلة العايق الفايق الي عمره ما يضايق",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          //////////////////////////////////////////////////////////////////////////
          SizedBox(
            height: ConfigSize.defaultSize! * 4,
          ),
          familyMemeber(context: context , onTap: () => Navigator.pushNamed(context, Routes.familyMembers),),

          familyRooms()
        ],
      ),
    );
  }
}

Widget familyLevelCard({
  required BuildContext context,
  required String currentLevel,
  required String nextLevel,
  required String currentlevelPoint,
  required String endLevelPoint,
}) {
  return Container(
    margin: EdgeInsets.only(left: ConfigSize.defaultSize!),
    padding: EdgeInsets.only(left: ConfigSize.defaultSize! * 2),
    width: MediaQuery.of(context).size.width - 50,
    height: ConfigSize.defaultSize! * 12,
    decoration: BoxDecoration(
        color: ColorManager.deepPurble,
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentLevel,
          style: TextStyle(
              color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.8),
        ),
        Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: '$currentlevelPoint / ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ConfigSize.defaultSize! * 1.6)),
                  TextSpan(
                      text: endLevelPoint,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: ConfigSize.defaultSize! * 1.6)),
                ],
              ),
            ),
            const Spacer(),
            Text(
              nextLevel,
              style: TextStyle(
                  color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.6),
            ),
            SizedBox(
              width: ConfigSize.defaultSize! * 4,
            )
          ],
        ),
        LinearPercentIndicator(
          barRadius: Radius.circular(ConfigSize.defaultSize!),
          width: MediaQuery.of(context).size.width - 100,
          lineHeight: ConfigSize.defaultSize!,
          percent: 0.2,
          backgroundColor: Colors.white.withOpacity(0.4),
          progressColor: ColorManager.whiteColor,
        ),
        SizedBox(
          height: ConfigSize.defaultSize! * 2,
        )
      ],
    ),
  );
}

Widget familyInfo(
    {required BuildContext context,
    required String familyName,
    required String familyId,
    required String familyMemeberNum}) {
  return Row(
    children: [
      SizedBox(
        width: ConfigSize.defaultSize! * 2,
      ),
      Container(
        width: ConfigSize.defaultSize! * 7,
        height: ConfigSize.defaultSize! * 7,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(AssetsPath.testImage), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
      ),
      SizedBox(
        width: ConfigSize.defaultSize!,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            familyName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            "ID : $familyId",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            children: [
              const UserCountryIcon(),
              SizedBox(
                width: ConfigSize.defaultSize!,
              ),
              CustomIcon(
                color: ColorManager.deepBlue,
                icon: AssetsPath.groupIcon,
                title: familyMemeberNum,
              )
            ],
          )
        ],
      )
    ],
  );
}

Widget familyMemeber({required BuildContext context , void Function()? onTap}) {
  return Column(
    children: [
      InkWell(
onTap:onTap ,
        child: Row(
          children: [
            const Spacer(
              flex: 1,
            ),
            Text(
              '${StringManager.familyMember} 4/120',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(
              flex: 15,
            ),
            Text(
              "${StringManager.more} >",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
      SizedBox(
        height: ConfigSize.defaultSize,
      ),
      SizedBox(
        height: ConfigSize.defaultSize! * 12,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const FamilyMemberCard();
            }),
      )
    ],
  );
}

Widget familyRooms() {
  return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        int style = 0;
        if (index == 0 || index == 1 || index == 2) {
          style = index;
        } else {
          style = index % 3;
        }
        return AduioLiveRow(
          style: style,
        );
      });
}
