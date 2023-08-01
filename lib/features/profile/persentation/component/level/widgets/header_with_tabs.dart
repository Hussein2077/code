import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';

class HeaderWithTabs extends StatefulWidget {
  final TabController levelController;
  const HeaderWithTabs({required this.levelController, super.key});

  @override
  State<HeaderWithTabs> createState() => _HeaderWithTabsState();
}

class _HeaderWithTabsState extends State<HeaderWithTabs> {
  @override
  void initState() {
    widget.levelController.addListener(() {
   setState(() {
     
   });

     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: widget.levelController.index==0? ColorManager.mainColorList:ColorManager.bageGriedinet)),
        child: Column(
          children: [
            SizedBox(
              height: ConfigSize.defaultSize! * 3.5,
            ),
            const HeaderWithOnlyTitle(
                title: StringManager.level, titleColor: Colors.white),
            TabBar(
                labelStyle: TextStyle(fontSize: ConfigSize.defaultSize!*2),
                unselectedLabelStyle: TextStyle(fontSize: ConfigSize.defaultSize!*1.7),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withOpacity(0.8),
                indicatorPadding: EdgeInsets.symmetric(
                    horizontal: ConfigSize.defaultSize! * 8),
                indicatorColor: Colors.white,
                controller: widget.levelController,
                tabs:const [
                  Text(StringManager.user ),
                  Text(StringManager.host),
                ]),
          ],
        ));
  }
}
