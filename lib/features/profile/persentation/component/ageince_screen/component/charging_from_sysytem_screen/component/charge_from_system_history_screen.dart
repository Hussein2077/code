import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/withdrawal_screen/component/widget/details_tab_bar.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/withdrawal_screen/component/widget/tab_bar_view.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_coin_system_history/charge_coin_system_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_coin_system_history/charge_coin_system_history_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_coin_system_history/charge_coin_system_history_state.dart';

class ChargeFromSystemHistory extends StatefulWidget {
  const ChargeFromSystemHistory({
    Key? key,
  }) : super(key: key);

  @override
  State<ChargeFromSystemHistory> createState() => _ChargeFromSystemHistoryState();
}

class _ChargeFromSystemHistoryState extends State<ChargeFromSystemHistory>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          StringManager.details.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 0.3,
          ),
          SizedBox(
              height: ConfigSize.defaultSize! * 5.0,
              width: MediaQuery.of(context).size.width,
              child: DetailsScreenTabBar(
                tabController: tabController,
              )),
          BlocProvider(
              create: (context) => getIt<ChargeCoinSystemHistoryBloc>()
                ..add(ChargeSentHistory(sent: "sent"))
                ..add(ChargeRecivedHistory(recived: "received")),
              child: Expanded(
                child: TabBarView(controller: tabController, children: [
                  BlocBuilder<ChargeCoinSystemHistoryBloc, ChargeCoinSystemHistoryState>(
                      builder: (context, state) {
                    switch (state.sentState) {
                      case RequestState.loaded:
                        return TabBarViewDetailsScreen(
                          data: state.sent,
                          flag: "sent",
                          
                        );
              
                      case RequestState.loading:
                        return const LoadingWidget();
                      case RequestState.error:
                        return CustomErrorWidget(message: state.sentMessage);
                    }
                  }),
                   BlocBuilder<ChargeCoinSystemHistoryBloc, ChargeCoinSystemHistoryState>(
                      builder: (context, state) {
                    switch (state.recivedState) {
                      case RequestState.loaded:
                        return TabBarViewDetailsScreen(
                          data: state.recived,
                          flag: "recived",
                        );
              
                      case RequestState.loading:
                        return const LoadingWidget();
                      case RequestState.error:
                        return CustomErrorWidget(message: state.recivedMessage);
                    }
                  })
                ]),
              ))
        ],
      ),
    );
  }
}