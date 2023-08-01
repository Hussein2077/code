import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/custom_icon.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/user_country_icon.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/aduio/audio_live_row.dart';
import 'package:tik_chat_v2/features/profile/data/model/show_family_model.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/widgets/family_member_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/widgets/settings_dailog.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';

class FamilyProfileInfo extends StatelessWidget {
  final ShowFamilyModel familyData;
  const FamilyProfileInfo({required this.familyData, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMyDataBloc, GetMyDataState>(
      builder: (context, state) {
        if (state is GetMyDataSucssesState) {
          bool isOwner = (familyData.id == state.userData.familyId&&familyData.amIOwner!);
          bool isAdmin = (familyData.id == state.userData.familyId&&familyData.amIAdmin!);
          bool isMember = (familyData.id == state.userData.familyId);

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
                    endIcon:(isOwner||isAdmin)
                        ? Stack(
                            children: [
                              IconButton(
                                onPressed: () {
                                  bottomDailog(
                                      context: context,
                                      widget: SettingsDailog(
                                        isAdmin: isAdmin,
                                        isMember: isMember,
                                        familyId:familyData.id.toString() ,
                                        isOwner:isOwner,
                                        numOfRequests:
                                            familyData.numOfRequests.toString(),
                                      ));
                                },
                                icon: Icon(
                                  Icons.settings,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: ConfigSize.defaultSize! * 2.5,
                                ),
                              ),
                              if (familyData.numOfRequests != 0)
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: ConfigSize.defaultSize!,
                                        top: ConfigSize.defaultSize!),
                                    child: Container(
                                      width: ConfigSize.defaultSize,
                                      height: ConfigSize.defaultSize,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red),
                                    ))
                            ],
                          )
                        : null),
                familyInfo(
                    image: familyData.img!,
                    context: context,
                    familyId: familyData.id.toString(),
                    familyMemeberNum:
                        (familyData.members!.length + 1).toString(),
                    familyName: familyData.name!),
                SizedBox(
                  height: ConfigSize.defaultSize! * 3.5,
                ),
                familyLevelCard(
                    context: context,
                    percent: familyData.familylevel!.per + 0.0,
                    currentLevel: familyData.familylevel!.levelName!,
                    currentlevelPoint:
                        familyData.familylevel!.levelExp.toString(),
                    endLevelPoint: familyData.familylevel!.nextExp.toString(),
                    nextLevel: familyData.familylevel!.nextName!),
                SizedBox(
                  height: ConfigSize.defaultSize! * 2,
                ),
                //bioooooooooooooo
                Text(
                  StringManager.familyBio,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  familyData.introduce.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                //////////////////////////////////////////////////////////////////////////
                SizedBox(
                  height: ConfigSize.defaultSize! * 4,
                ),
                familyMemeber(
                  owner: familyData.ownerData,
                  maxMemberNum: familyData.maxNumOfMembers.toString(),
                  memberNum: (familyData.members!.length + 1).toString(),
                  members: familyData.members!,
                  context: context,
                  onTap: () => Navigator.pushNamed(
                      context, Routes.familyMembers,
                      arguments: familyData.ownerData),
                ),

                familyRooms()
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

Widget familyLevelCard(
    {required BuildContext context,
    required String currentLevel,
    required String nextLevel,
    required String currentlevelPoint,
    required String endLevelPoint,
    required double percent}) {
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
          percent: percent,
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
    required String image,
    required String familyName,
    required String familyId,
    required String familyMemeberNum}) {
  return Row(
    children: [
      SizedBox(
        width: ConfigSize.defaultSize! * 2,
      ),
      CustoumCachedImage(
          url: image,
          height: ConfigSize.defaultSize! * 7,
          width: ConfigSize.defaultSize! * 7),
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
              const UserCountryIcon(country: ""),
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

Widget familyMemeber(
    {required OwnerDataModel owner,
    required String memberNum,
    required String maxMemberNum,
    required List<OwnerDataModel> members,
    required BuildContext context,
    void Function()? onTap}) {
  return Column(
    children: [
      InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const Spacer(
              flex: 1,
            ),
            Text(
              '${StringManager.familyMember} $memberNum/$maxMemberNum',
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
            itemCount: members.length +1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return FamilyMemberCard(
                  id: owner.id.toString(),
                  image: owner.profile!.image!,
                  name: owner.name!,
                  type: StringManager.owner,
                );
              } else {
                return FamilyMemberCard(
                  id: members[index-1].id.toString(),
                  image: members[index-1].profile!.image!,
                  name: members[index-1].name!,
                  type: members[index-1].isFamilyAdmin!
                      ? StringManager.admin
                      : StringManager.member,
                );
              }
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
        //TODO family rooms
        return AduioLiveRow(
          room: RoomModelOfAll(),
          style: style,
        );
      });
}
