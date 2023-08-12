import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/data/model/family_requests_model.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_take_action/bloc/take_action_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_take_action/bloc/take_action_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_take_action/bloc/take_action_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_requests/bloc/family_request_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_requests/bloc/family_request_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_requests/bloc/family_request_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_event.dart';

class FamilyRequestsScreen extends StatefulWidget {
  final String familyId  ; 
  const FamilyRequestsScreen({required this.familyId ,  super.key});

  @override
  State<FamilyRequestsScreen> createState() => _FamilyRequestsScreenState();
}

class _FamilyRequestsScreenState extends State<FamilyRequestsScreen> {
  List<FamilyRequest>? familyRequests;
  @override
  void initState() {
    BlocProvider.of<FamilyRequestBloc>(context).add(GetFamilyRequestEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocListener<TakeActionBloc, TakeActionState>(
        listener: (context, state) {
          if(state is FamilyTakeActionSucssesState){
                BlocProvider.of<FamilyRequestBloc>(context).add(GetFamilyRequestEvent());
    BlocProvider.of<ShowFamilyBloc>(context).add(ShowFamilyEvent(id: widget.familyId));

            sucssesToast(context: context, title: state.massage);
          }else if (state is FamilyTakeActionErrorState){
                            BlocProvider.of<FamilyRequestBloc>(context).add(GetFamilyRequestEvent());

            errorToast(context: context, title: state.error);
          }
        },
        child: BlocBuilder<FamilyRequestBloc, FamilyRequestState>(
          builder: (context, state) {
            if (state is FamilyRequestSUcsessState) {
              familyRequests = state.data.data;
              return Column(
                children: [
                  SizedBox(
                    height: ConfigSize.defaultSize! * 3,
                  ),
                  const HeaderWithOnlyTitle(title: StringManager.joinRequests),
                  Expanded(
                      child: ListView.builder(
                          itemCount: state.data.data.length,
                          itemExtent: 70,
                          itemBuilder: (context, index) {
                            return UserInfoRow(
                              userData: state.data.data[index].user,
                              endIcon: Row(
                                children: [
                                  reqIcon(
                                    icon: AssetsPath.acceptIcon,
                                    onTap: () =>
                                        BlocProvider.of<TakeActionBloc>(context)
                                            .add(FamilyTakeActionEvent(
                                                reqId: state.data.data[index].id
                                                    .toString(),
                                                status: '1')),
                                  ),
                                  SizedBox(
                                    width: ConfigSize.defaultSize! * 2,
                                  ),
                                  reqIcon(
                                    icon: AssetsPath.declineIcon,
                                    onTap: () =>
                                        BlocProvider.of<TakeActionBloc>(context)
                                            .add(FamilyTakeActionEvent(
                                                reqId: state.data.data[index].id
                                                    .toString(),
                                                status: '2')),
                                  ),
                                ],
                              ),
                            );
                          }))
                ],
              );
            } else if (state is FamilyRequestErrorState) {
              return CustomErrorWidget(
                message: state.error,
              );
            } else if (state is FamilyRequestLoadingState) {
              if (familyRequests == null) {
                return const LoadingWidget();
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: ConfigSize.defaultSize! * 3,
                    ),
                    const HeaderWithOnlyTitle(
                        title: StringManager.joinRequests),
                    Expanded(
                        child: ListView.builder(
                            itemCount: familyRequests!.length,
                            itemExtent: 70,
                            itemBuilder: (context, index) {
                              return UserInfoRow(
                                userData: familyRequests![index].user,
                                endIcon: Row(
                                  children: [
                                    reqIcon(
                                      icon: AssetsPath.acceptIcon,
                                    ),
                                    SizedBox(
                                      width: ConfigSize.defaultSize! * 2,
                                    ),
                                    reqIcon(
                                      icon: AssetsPath.declineIcon,
                                    ),
                                  ],
                                ),
                              );
                            }))
                  ],
                );
              }
            } else {
              return const CustomErrorWidget(
                  message: StringManager.unexcepectedError);
            }
          },
        ),
      ),
    );
  }
}

Widget reqIcon({required String icon, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Image.asset(
      icon,
      scale: 2.8,
    ),
  );
}
