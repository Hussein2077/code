import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_member/agnecy_member_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_member/agnecy_member_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_member/agnecy_member_state.dart';

class AgencyMembersScreen extends StatefulWidget {
  const AgencyMembersScreen({super.key});

  @override
  State<AgencyMembersScreen> createState() => _AgencyMembersScreenState();
}

class _AgencyMembersScreenState extends State<AgencyMembersScreen> {
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          const HeaderWithOnlyTitle(title: StringManager.members),
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
                                onTap:()=> Navigator.pushNamed(context, Routes.liveReportScreen , arguments: state.data![index]),
                                  userData: state.data![index],
                                  underName: const SizedBox(),
                                  endIcon:Row(children: [
                                    Text(
                                    "${state.data![index].diamonds.toString()}  ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                  ) , 
                                  Icon(Icons.diamond,color: Colors.blue, size: ConfigSize.defaultSize!*2,)
                                  ],)  ));
                        }));
              } else if (state is AgnecyMemberLoadingState) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: const LoadingWidget());
              } else if (state is AgnecyMemberErrorState) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: CustoumErrorWidget(message: state.error));
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.4,
                  child: const CustoumErrorWidget(
                      message: StringManager.unexcepectedError),
                );
              }
            },
          )
        ],
      ),
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
