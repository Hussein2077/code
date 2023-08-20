import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';

import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_state.dart';

import 'widgets/my_bag_card.dart';
import 'widgets/my_bag_tab_view.dart';
import 'widgets/my_bag_tabs.dart';

class MyBagScreen extends StatefulWidget {
 final MyDataModel myData ;
  const MyBagScreen({required this.myData ,  super.key});

  @override
  State<MyBagScreen> createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen>
    with TickerProviderStateMixin {
    

  late TabController bagController;
  @override
  void initState() {
MyBagCard.frameUsed = widget.myData.frameId;
MyBagCard.entriesUsed = widget.myData.introId;

MyBagCard.bublesUsed = widget.myData.bubbleId;

    bagController = TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
bagController.dispose();    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
 
    return BlocBuilder<MyBagBloc, MyBagState>(
      builder: (context, state) {
  
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            children: [
              SizedBox(
                height: ConfigSize.defaultSize! * 3,
              ),
              const HeaderWithOnlyTitle(title: StringManager.myBag),
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
                    viewIndex: 0,
                    myBagData: state.framesBackPack,
                    stateRequest: state.framesBackPackRequest,
                  ),
                  MyBagTabView(
                    viewIndex: 1,
                    myBagData: state.entering,
                    stateRequest: state.enteringBackPackRequest,
                  ),
                  MyBagTabView(
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
    );
  }
}
