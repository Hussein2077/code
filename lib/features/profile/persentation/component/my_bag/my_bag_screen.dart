import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';

import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';

import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_state.dart';

import 'widgets/my_bag_card.dart';
import 'widgets/my_bag_tab_view.dart';
import 'widgets/my_bag_tabs.dart';

class MyBagScreen extends StatefulWidget {
  final MyDataModel myDataModel;
  const MyBagScreen({required this.myDataModel, super.key});

  static List <String> isUsed = [] ;


  @override
  State<MyBagScreen> createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen>
    with TickerProviderStateMixin {
  late TabController bagController;
  @override
  void initState() {
    MyBagCard.frameUsed = widget.myDataModel.frameId;
    MyBagCard.entriesUsed = widget.myDataModel.introId;

    MyBagCard.bublesUsed = widget.myDataModel.bubbleId;

    bagController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    MyBagScreen.isUsed=[];

    bagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyBagBloc>()
   ..add(const GetFramesMyBagEvent(type: "4"))
            ..add(const GetEntrieMyBagEvent(type: '6'))
            ..add(const GetBubbleBackPackMyBagEvent(type: "5")),
      child: BlocBuilder<MyBagBloc, MyBagState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(
              children: [
                SizedBox(
                  height: ConfigSize.defaultSize! * 3,
                ),
                HeaderWithOnlyTitle(title: StringManager.myBag.tr()),
                SizedBox(
                  height: ConfigSize.defaultSize!,
                ),
                MyBagScreenTabs(
                  controller: bagController,
                ),
                Expanded(
                    child: TabBarView(
                  controller: bagController,
                  children: [
                    MyBagTabView(
                      message: state.framesBackPackMassage,
                      viewIndex: 0,
                      myBagData: state.framesBackPack,
                      stateRequest: state.framesBackPackRequest,
                    ),
                    MyBagTabView(
                      message: state.enteringBackPackMassage,
                      viewIndex: 1,
                      myBagData: state.entering,
                      stateRequest: state.enteringBackPackRequest,
                    ),
                    MyBagTabView(
                      message: state.bubblesPackBackMassage,
                      viewIndex: 2,
                      myBagData: state.bubblesPackBack,
                      stateRequest: state.bubblesPackBackRequest,
                    ),
                  ],
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
