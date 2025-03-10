import 'dart:developer';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/profile/data/model/family_member_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/show_family_model.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/widgets/family_member_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_member/bloc/family_member_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_member/bloc/family_member_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_member/bloc/family_member_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_remove_user/bloc/family_remove_user_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_remove_user/bloc/family_remove_user_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_remove_user/bloc/family_remove_user_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_change_user_type/bloc/change_user_type_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_change_user_type/bloc/change_user_type_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_change_user_type/bloc/change_user_type_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';

// ignore: must_be_immutable
class FamilyMemberScreen extends StatefulWidget {
  final MemberFamilyDataModel owner;

  //TODO CHECK PAGENATION
  int page = 1;

  FamilyMemberScreen({required this.owner, super.key});

  @override
  State<FamilyMemberScreen> createState() => _FamilyMemberScreenState();
}

class _FamilyMemberScreenState extends State<FamilyMemberScreen> {
   late  ShowFamilyModel? familydata;

  final ScrollController scrollController = ScrollController();

  List<MemberFamilyDataModel> membersData = [];
  MyDataModel? mydata;
  int? removeUserIndex;

  @override
  void initState() {
    scrollController.addListener(scrollListener);

    BlocProvider.of<FamilyMemberBloc>(context)
        .add(GetFamilyMemberEvent(familyId: widget.owner.familyId.toString()));
    super.initState();
  }

  @override
  void dispose() {
    membersData = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocListener<FamilyRemoveUserBloc, FamilyRemoveUserState>(
          listener: (context, state) {
            if (state is FamilyRemoveUserSucssesState) {
              BlocProvider.of<FamilyMemberBloc>(context).add(
                  GetFamilyMemberEvent(
                      familyId: widget.owner.familyId.toString()));
              BlocProvider.of<ShowFamilyBloc>(context)
                  .add(ShowFamilyEvent(id: widget.owner.familyId.toString()));

              sucssesToast(context: context, title: state.massage);
            }
            else if (state is FamilyRemoveUserErrorState) {
              errorToast(context: context, title: state.error);
            }
          },
          child: BlocListener<ChangeUserTypeBloc, ChangeUserTypeState>(
            listener: (context, state) {
              if (state is ChangeUserTypeSucsessState) {
                BlocProvider.of<FamilyMemberBloc>(context).add(
                    GetFamilyMemberEvent(
                        familyId: widget.owner.familyId.toString()));
                BlocProvider.of<ShowFamilyBloc>(context)
                    .add(ShowFamilyEvent(id: widget.owner.familyId.toString()));
              } else if (state is ChangeUserTypeErorrState) {
                errorToast(context: context, title: state.error);
              }
            },
            child: BlocBuilder<GetMyDataBloc, GetMyDataState>(
              builder: (context, state) {
                if (state is GetMyDataSucssesState) {
                  mydata = state.myDataModel;
                  return BlocBuilder<ShowFamilyBloc, ShowFamilyState>(
                    builder: (context, state) {
                      if (state is ShowFamilySucssesState) {
                        double percent = ((state.data.members!.length + 1) /
                            state.data.maxNumOfMembers!);
                        familydata = state.data;
                        return BlocBuilder<FamilyMemberBloc, FamilyMemberState>(
                          builder: (context, state) {
                            if (state is GetFamilyMemberSucssesState) {
                              membersData = [];
                              membersData.add(widget.owner);
                              membersData +=
                                  state.data!.admin + state.data!.members;
                              return ScreenBackGround(
                                  image: isDarkTheme
                                      ? AssetsPath.familyProfileCoverBlack
                                      : AssetsPath.familyProfileCover,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: ConfigSize.defaultSize! * 3.5,
                                      ),
                                      HeaderWithOnlyTitle(
                                          title:
                                              StringManager.familyMember.tr()),
                                      // SizedBox(height: ConfigSize.defaultSize!*0.8,),
                                      Directionality(
                                        textDirection: ui.TextDirection.ltr,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${(familydata!.members!.length + 1).toString()} ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      ConfigSize.defaultSize! *
                                                          1.2),
                                            ),
                                            LinearPercentIndicator(
                                              barRadius: Radius.circular(
                                                  ConfigSize.defaultSize!),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  230,
                                              lineHeight:
                                                  ConfigSize.defaultSize! * 1.2,
                                              percent: percent,
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.4),
                                              progressColor:
                                                  ColorManager.whiteColor,
                                            ),
                                            Text(
                                              familydata!.maxNumOfMembers
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      ConfigSize.defaultSize! *
                                                          1.2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(height: ConfigSize.defaultSize!*0.8,),
                                      Expanded(
                                        child: GridView.builder(
                                            controller: scrollController,
                                            itemCount: membersData.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    mainAxisSpacing: ConfigSize
                                                            .defaultSize! *
                                                        3,
                                                    childAspectRatio: 1.1),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  removeUserIndex = index;
                                                  if (state.data!.owner.id ==
                                                          mydata!.id &&
                                                      index != 0) {
                                                    bottomDailog(
                                                        context: context,
                                                        widget:
                                                            familyOwnerDilog(
                                                                type: index == 0
                                                                    ? "owner"
                                                                    : index <
                                                                            state.data!.admin.length +
                                                                                1
                                                                        ? "admin"
                                                                        : "member",
                                                                context:
                                                                    context,
                                                                familyId: membersData[
                                                                        0]
                                                                    .familyId
                                                                    .toString()
                                                                    .toString(),
                                                                userId: membersData[
                                                                        index]
                                                                    .id
                                                                    .toString()));
                                                  } else {
                                                    Methods.instance
                                                        .userProfileNvgator(
                                                            context: context,
                                                            userId: membersData[
                                                                    index]
                                                                .id
                                                                .toString());
                                                  }
                                                },
                                                child: FamilyMemberCard(
                                                  id: membersData[index]
                                                      .id
                                                      .toString(),
                                                  image:
                                                      membersData[index].image!,
                                                  frame:
                                                      membersData[index].frame!,
                                                  frameId: membersData[index]
                                                      .frameId!,
                                                  name:
                                                      membersData[index].name!,
                                                  type: index == 0
                                                      ? StringManager.owner.tr()
                                                      : index <
                                                              state.data!.admin
                                                                      .length +
                                                                  1
                                                          ? StringManager.admin
                                                              .tr()
                                                          : StringManager.member
                                                              .tr(),
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ));
                            } else if (state is GetFamilyMemberLoadingState) {
                              return const LoadingWidget();
                            } else if (state is GetFamilyMemberErrorState) {
                              return CustomErrorWidget(
                                  message: state.errorMassage);
                            } else {
                              return CustomErrorWidget(
                                  message:
                                      StringManager.unexcepectedError.tr());
                            }
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ));
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      widget.page++;
      BlocProvider.of<FamilyMemberBloc>(context).add(GetMoreFamilyMemberEvent(
          familyId: widget.owner.familyId.toString(),
          page: widget.page.toString()));
    } else {}
  }
}

Widget familyOwnerDilog({
  required BuildContext context,
  required String userId,
  required String familyId,
  required String type,
}) {
  log(userId);
  log(familyId);
  return Container(
    width: MediaQuery.of(context).size.width,
    height: ConfigSize.defaultSize! * 20,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.background,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        settingsTabs(
            context: context, title: StringManager.showProfile.tr(),
            onTap: () {
              Methods.instance.userProfileNvgator(context: context ,userId: userId);
            }),
        CustomHorizntalDvider(width: MediaQuery.of(context).size.width),
        settingsTabs(
            context: context,
            title: type == "member"
                ? StringManager.addAdmin.tr()
                : StringManager.removeAdmin.tr(),
            onTap: () {
              Navigator.pop(context);
              if (type == "member") {
                BlocProvider.of<ChangeUserTypeBloc>(context).add(
                    ChangeUserTypeEvent(
                        userId: userId, familyId: familyId, type: '1'));
              } else if (type == "admin") {
                BlocProvider.of<ChangeUserTypeBloc>(context).add(
                    ChangeUserTypeEvent(
                        userId: userId, familyId: familyId, type: '0'));
              }
            }),
        CustomHorizntalDvider(width: MediaQuery.of(context).size.width),
        settingsTabs(
            context: context,
            title: StringManager.deleteMember.tr(),
            onTap: () {
              Navigator.pop(context);

              BlocProvider.of<FamilyRemoveUserBloc>(context)
                  .add(RemoverFamilyUser(familyId: familyId, uId: userId));
            }),
      ],
    ),
  );
}

Widget settingsTabs(
    {required BuildContext context, required title, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge,
    ),
  );
}
