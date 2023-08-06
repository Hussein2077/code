import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_history/agency_time_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_history/agency_time_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_time_history/agency_history_time_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_time_history/agency_history_time_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_time_history/agency_history_time_state.dart';

import 'widget/month_button.dart';
import 'widget/years_button.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    BlocProvider.of<AgencyHistoryTimeBloc>(context)
        .add(AgencyHistoryTimeEvent());
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
          const HeaderWithOnlyTitle(title: StringManager.reports),
          BlocBuilder<AgencyHistoryTimeBloc, AgencyHistoryTimeState>(
            builder: (context, state) {
              if (state is AgencyHistoryTimeSucssesState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MounthButton(data: state.data),
                    YearsButton(
                      data: state.data,
                    )
                  ],
                );
              } else if (state is AgencyHistoryTimeLoadingState) {
                return SizedBox(
                  height: ConfigSize.defaultSize! * 4,
                );
              } else if (state is AgencyHistoryTimeErrorState) {
                return Text(state.error,
                    style: Theme.of(context).textTheme.headlineMedium);
              } else {
                return Text(StringManager.unexcepectedError,
                    style: Theme.of(context).textTheme.headlineMedium);
              }
            },
          ),
      
              BlocBuilder<AgencyTimeBloc, AgencyTimeState>(
                builder: (context, state) {
                  if (state is AgencyTimeSucssesState ){
                   return     Expanded(
                     child: Column(
                               children: [
                                SizedBox(height: ConfigSize.defaultSize!,),
                                 Text(
                                   StringManager.totalDaimonds,
                                   style: Theme.of(context).textTheme.headlineMedium,
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text(
                     state.data.sum.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                                     ),
                                     Icon(
                      Icons.diamond,
                      color: Colors.blue,
                      size: ConfigSize.defaultSize! * 2.5,
                                     ),
                                   ],
                                 ),
                       Expanded(
                        child: ListView.builder(
                            itemCount: state.data.users!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: ConfigSize.defaultSize!,
                                  ),
                                  child: UserInfoRow(
                                      // onTap: () => Navigator.pushNamed(
                                      //     context, Routes.liveReportScreen,
                                      //     arguments: state.data![index]),
                                      userData: state.data.users![index],
                                      underName: const SizedBox(),
                                      endIcon: Row(
                                        children: [
                                          Text(
                                            "${state.data.users![index].diamonds.toString()}  ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Icon(
                                            Icons.diamond,
                                            color: Colors.blue,
                                            size: ConfigSize.defaultSize! * 2,
                                          )
                                        ],
                                      )));
                            }))
                               ]),
                   );
                  }else if (state is AgencyTimeLoadingState ){
                    return SizedBox( height: MediaQuery.of(context).size.height/2.7, child: const LoadingWidget(),);
                  }else if (state is AgencyTimeErrorState ) {
                  return  SizedBox( height: MediaQuery.of(context).size.height/2.7, child:  CustoumErrorWidget(message: state.error),);
                  
                  }else {
                         return               const SizedBox();

                  }
               
                },
              ),
        
        ],
      ),
    );
  }
}
