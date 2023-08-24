import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_member/agnecy_member_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_member/agnecy_member_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_member/agnecy_member_state.dart';

class MemberAgencyBody extends StatefulWidget {
  final UserDataModel owner;

  const MemberAgencyBody({required this.owner, super.key});

  @override
  State<MemberAgencyBody> createState() => _MemberAgencyBodyState();
}

class _MemberAgencyBodyState extends State<MemberAgencyBody> {
  int page = 1;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<AgnecyMemberBloc>(context)
        .add(const AgnecyMemberEvent(page: 1));
    scrollController.addListener(scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ownerCard(
            context: context,
            id: widget.owner.uuid!,
            iVip: widget.owner.hasColorName!,
            image: widget.owner.profile!.image!,
            name: widget.owner.name!),
        SizedBox(
          height: ConfigSize.defaultSize,
        ),
        Text(
          StringManager.members.tr(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: ConfigSize.defaultSize,
        ),
        BlocBuilder<AgnecyMemberBloc, AgnecyMemberState>(
          builder: (context, state) {
            if (state is AgnecyMemberSucsessState) {
              return Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: ConfigSize.defaultSize!,
                            ),
                            child: UserInfoRow(
                              userData: state.data![index].convertToUserDataModel(),
                              underName: const SizedBox(),
                              endIcon: Icon(
                                Icons.arrow_forward_ios,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ));
                      }));
            } else if (state is AgnecyMemberLoadingState) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: const LoadingWidget());
            } else if (state is AgnecyMemberErrorState) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: CustomErrorWidget(message: state.error));
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 2.4,
                child:  CustomErrorWidget(
                    message: StringManager.unexcepectedError.tr()),
              );
            }
          },
        )
      ],
    );
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page++;
      BlocProvider.of<AgnecyMemberBloc>(context)
          .add(LoadMoreAgnecyMemberEvent(page: page));
    } else {}
  }
}

Widget ownerCard(
    {required BuildContext context,
    required String image,
    required bool iVip,
    required String name,
    required String id}) {
  return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: ConfigSize.defaultSize!,
          vertical:  ConfigSize.defaultSize!*2.0,
        ),
        width: MediaQuery.of(context).size.width/1.1,
        decoration: BoxDecoration(
          color: ColorManager.bage,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              StringManager.agencyOwner.tr(),
              style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*1.7),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    UserImage(image: image, imageSize: ConfigSize.defaultSize! * 7),

                    Text(
                      "ID : $id",
                      style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*1.7),
                    ),
                  ],
                ),

                GradientTextVip(
                  text:name,
                  textStyle:TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*1.7),

                  isVip: iVip,
                ),
                Text(
                  name,
                  style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*1.7),
                ),

              ],
            ),
          ],
        ),
      ));
}
