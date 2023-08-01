import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/screen_color_back_ground.dart';
import 'package:tik_chat_v2/features/home/presentation/component/top_users/widget/top_users_type_body.dart';
import 'package:tik_chat_v2/features/home/presentation/component/top_users/widget/type_tabs.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manager_top_rank/top_bloc.dart';
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
    userTimeController = TabController(length: 3, vsync: this);
    hostTimeController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TobBloc, TopStates>(
      builder: (context, state) {
        return Scaffold(
          body: ScreenColorBackGround(
              color: ColorManager.mainColorList,
              child: Column(
                children: [
                  SizedBox(
                    height: ConfigSize.defaultSize! * 3,
                  ),
                  const HeaderWithOnlyTitle(title: StringManager.rank),
                  TypeTabs(
                    typeController: typeController,
                  ),
                  SizedBox(
                    height: ConfigSize.defaultSize! * 3,
                  ),
                  Expanded(
                    child: TabBarView(controller: typeController, children: [
                      TopUsersTypeBody(
                        
                        timeController: hostTimeController,
                      ),
                      TopUsersTypeBody(
                        timeController: userTimeController,
                      )
                    ]),
                  )
                ],
              )),
        );
      },
    );
  }
}
