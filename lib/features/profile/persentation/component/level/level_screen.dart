import 'package:flutter/material.dart';

import 'package:tik_chat_v2/features/profile/persentation/component/level/host_level_body.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/level/user_level_body.dart';

import 'widgets/header_with_tabs.dart';


class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen>
    with TickerProviderStateMixin {
  late TabController levelController;
  @override
  void initState() {
    levelController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
                        HeaderWithTabs(levelController: levelController,),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
              controller: levelController,
              children: const [
             UserLevelBody(),
             HostLevelBody()
              ],
            ),
        )
        ],)
        
        );
  }
}
