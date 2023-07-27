import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class LiveTabBAR extends StatefulWidget {
  final TabController liveController;
  const LiveTabBAR({required this.liveController, super.key});

  @override
  State<LiveTabBAR> createState() => _LiveTabBARState();
}

class _LiveTabBARState extends State<LiveTabBAR> {
  @override
  void initState() {
    widget.liveController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ConfigSize.defaultSize! * 22,
      child: TabBar(
        
        indicatorColor: ColorManager.whiteColor,
        indicatorPadding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*4),
        controller: widget.liveController, tabs: [
        Row(
          children: [
             Text("${StringManager.live}  " , style: TextStyle(color: ColorManager.whiteColor , fontSize: ConfigSize.defaultSize!*1.7),),
            widget.liveController.index == 0
                ? Image.asset(
                    AssetsPath.videoIcon,
                    scale: 2,
                  )
                : Image.asset(
                    AssetsPath.unslectedVideoIcon,
                    scale: 2,
                  )
          ],
        ),
        Row(
          children: [
             Text("${StringManager.voice} " , style: TextStyle(color: ColorManager.whiteColor , fontSize: ConfigSize.defaultSize!*1.7)),
            widget.liveController.index == 1
                ? Image.asset(
                    AssetsPath.micIcon,
                    scale: 2,
                  )
                : Image.asset(
                    AssetsPath.unslectedMicIcon,
                    scale: 2,
                  )
          ],
        ),
      ]),
    );
  }
}
