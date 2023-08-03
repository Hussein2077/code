import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_requests/agency_requests_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_requests/agency_requests_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_requests/agency_requests_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_requests_action/agency_requests_action_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_requests_action/agency_requests_action_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_requests_action/agency_requests_action_state.dart';

class AgencyRequestsScreen extends StatefulWidget {
  const AgencyRequestsScreen({  super.key});

  @override
  State<AgencyRequestsScreen> createState() => _AgencyRequestsScreenState();
}

class _AgencyRequestsScreenState extends State<AgencyRequestsScreen> {
    List<OwnerDataModel>? agenceRequests;

  @override
  void initState() {

    BlocProvider.of<AgencyRequestsBloc>(context).add(AgencyRequestsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocListener<AgencyRequestsActionBloc, AgencyRequestsActionState>(
        listener: (context, state) {
          if(state is AgencyRequestsActionSucssesState){
                BlocProvider.of<AgencyRequestsBloc>(context).add((AgencyRequestsEvent()));

            sucssesToast(context: context, title: state.message);
          }else if (state is AgencyRequestsActionErrorState){

            errorToast(context: context, title: state.error);
          }
        },
        child: BlocBuilder<AgencyRequestsBloc, AgencyRequestsState>(
          builder: (context, state) {
            if (state is AgencyRequestSucssesState) {
              agenceRequests = state.data;
              return Column(
                children: [
                  SizedBox(
                    height: ConfigSize.defaultSize! * 3,
                  ),
                  const HeaderWithOnlyTitle(title: StringManager.joinRequests),
                  Expanded(
                      child: ListView.builder(
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!),
                              child: UserInfoRow(
                                underNameWidth: ConfigSize.defaultSize,
                                userData: state.data[index],
                                underName: const SizedBox(),
                                endIcon: Row(
                                  children: [
                                    reqIcon(
                                      icon: AssetsPath.acceptIcon,
                                      onTap: () =>
                                          BlocProvider.of<AgencyRequestsActionBloc>(context)
                                              .add(AgencyRequestsActionEvent(
                                                  userId: state.data[index].id
                                                      .toString(),
                                                  accept: true)),
                                    ),
                                    SizedBox(
                                      width: ConfigSize.defaultSize! ,
                                    ),
                                    reqIcon(
                                      icon: AssetsPath.declineIcon,
                                      onTap: () =>
                                          BlocProvider.of<AgencyRequestsActionBloc>(context)
                                              .add(AgencyRequestsActionEvent(
                                                  userId: state.data[index].id
                                                      .toString(),
                                                  accept: false)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              );
            } else if (state is AgencyRequestsErrorState) {
              return CustoumErrorWidget(
                message: state.error,
              );
            } else if (state is AgencyRequestsLoadingState) {
              if (agenceRequests == null) {
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
                            itemCount: agenceRequests!.length,
                            
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!),
                                child: UserInfoRow(
                                  userData: agenceRequests![index],
                                  underName: const SizedBox(),
                                  underNameWidth: ConfigSize.defaultSize!,
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
                                ),
                              );
                            }))
                  ],
                );
              }
            } else {
              return const CustoumErrorWidget(
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
