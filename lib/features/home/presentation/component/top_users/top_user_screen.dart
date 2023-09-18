import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/screen_color_back_ground.dart';
import 'package:tik_chat_v2/features/home/presentation/component/top_users/widget/top_users_type_body.dart';
import 'package:tik_chat_v2/features/home/presentation/component/top_users/widget/type_tabs.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manager_top_rank/top_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manager_top_rank/top_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manager_top_rank/top_states.dart';

class TopUsersScreen extends StatefulWidget {
  const TopUsersScreen({super.key});

  @override
  State<TopUsersScreen> createState() => _TopUsersScreenState();
}

class _TopUsersScreenState extends State<TopUsersScreen>
    with TickerProviderStateMixin {
  late TabController typeController;
  late TabController userTimeController;
  late TabController hostTimeController;

  @override
  void initState() {
    typeController = TabController(length: 2, vsync: this);
    userTimeController = TabController(length: 4, vsync: this);
    hostTimeController = TabController(length: 4, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TobBloc>()
        ..add(GetDiamondsDayEvent(sendOrReceiver: '1', date: '1', isHome: '0'))
        ..add(GetDiamondsHourEvent(sendOrReceiver: "1", date: "0", isHome: "0"))
        ..add(GetDiamondsWeeklyEvent(sendOrReceiver: '1', date: '2', isHome: '0'))
        ..add(GetDiamondsMonthlyEvent(sendOrReceiver: '1', date: '3', isHome: '0'))
        ..add(GetCoinsHourEvent(sendOrReceiver: '2', date: '0', isHome: '0'))
        ..add(GetCoinsDayEvent(sendOrReceiver: '2', date: '1', isHome: '0'))
        ..add(GetCoinsWeeklyEvent(sendOrReceiver: '2', date: '2', isHome: '0'))
        ..add(GetCoinsMonthlyEvent(sendOrReceiver: '2', date: '3', isHome: '0')),
      child: BlocBuilder<TobBloc, TopStates>(
        builder: (context, state) {
          return Scaffold(
            body: ScreenColorBackGround(
                color: ColorManager.mainColorList,
                child: Column(
                  children: [
                    SizedBox(
                      height: ConfigSize.defaultSize! * 3,
                    ),
                     HeaderWithOnlyTitle(title: StringManager.rank.tr()),
                    TypeTabs(
                      typeController: typeController,
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 3,
                    ),
                    Expanded(
                      child: TabBarView(controller: typeController, children: [
                        TopUsersTypeBody(
                          dError: state.cDError,
                          dState: state.cDState,
                          usersRankD: state.usersRankCD,
                          wError: state.cWError,
                          wState: state.cWState,
                          usersRankW: state.usersRankCW,
                          mError: state.cMError,
                          mState: state.cMState,
                          usersRankM: state.usersRankCM,
                          timeController: hostTimeController,
                          hError: state.dhError,
                          hState: state.dhState,
                          usersRankH: state.usersRankDh,
                        ),
                        TopUsersTypeBody(
                          dError: state.dDError,
                          dState: state.dDState,
                          usersRankD: state.usersRankDD,
                          wError: state.dWError,
                          wState: state.dWState,
                          usersRankW: state.usersRankDW,
                          mError: state.dMError,
                          mState: state.dMState,
                          usersRankM: state.usersRankDM,
                          timeController: userTimeController,
                                    hError: state.chError,
                          hState: state.chState,
                          usersRankH: state.usersRankCh,
                        )
                      ]),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
