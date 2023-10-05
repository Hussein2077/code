import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_bag/widgets/my_bag_tabs.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_buy_manager/mall_buy_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_buy_manager/mall_buy_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_manager/mall_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_manager/mall_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_event.dart';

import 'widget/mall_tab_view.dart';

class MallScreen extends StatefulWidget {
  const MallScreen({super.key});

  @override
  State<MallScreen> createState() => _MallScreenState();
}

class _MallScreenState extends State<MallScreen> with TickerProviderStateMixin {
  late TabController mallController;
  @override
  void initState() {
    mallController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
mallController.dispose();    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MallBuyBloc, MallBuyState>(
      listener: (context, state) {
        if(state is BuyScussesState ){
          
         BlocProvider.of<MyBagBloc>(context)..add(const GetFramesMyBagEvent(type: "4"))
         ..add(const GetFramesMyBagEvent(type: "6"))..add(const GetFramesMyBagEvent(type: "5"));
            
          sucssesToast(context: context, title: state.massage);
        }else if (state is BuyErorrState){
          errorToast(context: context, title: state.massage);
        }
      },
      builder: (context, state) {
        return BlocBuilder<MallBloc, GetDataMallStates>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              body: Column(
                children: [
                  SizedBox(
                    height: ConfigSize.defaultSize! * 3,
                  ),
                   HeaderWithOnlyTitle(title: StringManager.mall.tr()),
                  SizedBox(
                    height: ConfigSize.defaultSize!,
                  ),
                  MyBagScreenTabs(
                    controller: mallController,
                  ),
                  Expanded(
                      child: TabBarView(
                    controller: mallController,
                    children: [
                      MallTabView(
                        dataMall: state.framesMall,
                        dataMallMessage: state.frameMallMessage,
                        stateRequest: state.frameMallRequest, type: 'f',
                      ),
                      MallTabView(
                        type: 'c',
                        dataMall: state.carsMall,
                        dataMallMessage: state.carMallMessage,
                        stateRequest: state.carMallRequest,
                      ),
                      MallTabView(
                        type: 'b',
                        dataMall: state.bubblesMall,
                        dataMallMessage: state.bubbleMallMessage,
                        stateRequest: state.bubbleMallRequest,
                      ),
                    ],
                  ))
                ],
              ),
            );
          },
        );
      },
    );
  }
}
