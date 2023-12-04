import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/f_f_f_v_screens/logic_follow_unfollow.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/vistors_manager/vistors_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/vistors_manager/vistors_state.dart';

import '../../manager/vistors_manager/vistors_bloc.dart';

// ignore: must_be_immutable
class VistorScreen extends StatefulWidget {
  int page = 1;

  VistorScreen({super.key});

  @override
  State<VistorScreen> createState() => _VistorScreenState();
}

class _VistorScreenState extends State<VistorScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    LogicFollowUnfollow.theFollowedUsersMap.clear();
    scrollController.addListener(scrollListener);
    BlocProvider.of<VistorsBloc>(context).add(GetVistors());
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return BlocListener<FollowBloc, FollowState>(
      listener: (context, state) {
        if (state is FollowSucssesState) {
          LogicFollowUnfollow.followUnfollowController(
              LogicFollowUnfollow.userId,
              LogicFollowUnfollow
                  .theFollowedUsersMap[LogicFollowUnfollow.userId]!);
        } else if (state is FollowErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackBar(context, state.error));
        } else if (state is UnFollowSucssesState) {
          LogicFollowUnfollow.followUnfollowController(
              LogicFollowUnfollow.userId,
              LogicFollowUnfollow
                  .theFollowedUsersMap[LogicFollowUnfollow.userId]!);
        } else if (state is UnFollowErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackBar(context, state.error));
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: ConfigSize.defaultSize! * 0.8,
            ),
            HeaderWithOnlyTitle(title: StringManager.vistors.tr()),
            BlocBuilder<VistorsBloc, VistorsState>(
              builder: (context, state) {
                if (state is GetVistorsSucssesState) {
                  return Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: state.data!.length,
                        itemExtent: 80,
                        itemBuilder: (context, index) {
                          LogicFollowUnfollow.theFollowedUsersMap.putIfAbsent(
                              state.data![index].id!,
                                  () => state.data![index].isFollow!);
                          return UserInfoRow(
                            idOrNot: SizedBox(
                              width: ConfigSize.defaultSize!*10,

                              child: Text(
                                " ${Methods.instance.formatDateTime(dateTime: state.data![index].visitTime ?? '', locale: context.locale.languageCode)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 10,overflow: TextOverflow.fade),
                              ),
                            ),
                            userData: state.data![index],
                            endIcon: ValueListenableBuilder(
                              valueListenable:
                                  LogicFollowUnfollow.followUnfollowNotifier,
                              builder: (context, value, child) {
                                return MainButton(
                                  title:
                                      LogicFollowUnfollow.theFollowedUsersMap[
                                              state.data![index].id]!
                                          ? StringManager.unFollow.tr()
                                          : StringManager.follow.tr(),
                                  titleSize: ConfigSize.defaultSize! * 1.2,
                                  width: ConfigSize.defaultSize! * 8,
                                  height: ConfigSize.defaultSize! * 4,
                                  onTap: () {
                                    LogicFollowUnfollow.userId =
                                        state.data![index].id!;

                                    LogicFollowUnfollow
                                        .followUnfollowControllerEvents(
                                            context,
                                            state.data![index].id!,
                                            LogicFollowUnfollow
                                                    .theFollowedUsersMap[
                                                state.data![index].id]!);
                                  },
                                );
                              },
                            ),
                          );
                        }),
                  );
                } else if (state is GetVistorsLoadingState) {
                  return const LoadingWidget();
                } else if (state is GetVistorsErrorState) {
                  return CustomErrorWidget(
                    message: state.errorMassage,
                  );
                } else {
                  return const CustomErrorWidget(
                    message: StringManager.unexcepectedError,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      widget.page++;
      BlocProvider.of<VistorsBloc>(context)
          .add(GetMoreVistors(page: widget.page.toString()));
    } else {}
  }
}
