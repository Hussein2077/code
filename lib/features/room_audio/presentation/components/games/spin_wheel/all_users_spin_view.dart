import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class AllUsersSpinView extends StatefulWidget {
  List<dynamic> list;
  int winner;
  AllUsersSpinView({super.key, required this.list, required this.winner});

  @override
  State<AllUsersSpinView> createState() => _AllUsersSpinViewState();
}

class _AllUsersSpinViewState extends State<AllUsersSpinView> {

  final _wheelNotifier = BehaviorSubject<int>();

  @override
  void initState() {
    _wheelNotifier.add(widget.winner!);
    super.initState();
  }

  @override
  void dispose() {
    _wheelNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: ConfigSize.defaultSize! * 20,
          child: FortuneWheel(
            selected: _wheelNotifier.stream,
            animateFirst: false,
            indicators: [
              FortuneIndicator(
                child: SizedBox(
                  height: ConfigSize.defaultSize! * 10,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(top: 0,child: Image.asset(AssetsPath.spinWheelGameIndicatorIcon1, scale: 1.3,)),
                      Image.asset(AssetsPath.spinWheelGameIndicatorIcon2, scale: 1.3),
                    ],
                  ),
                ),
              ),
            ],
            onAnimationEnd: () {
              Navigator.pop(context);
            },
            items: [
              for (var id in widget.list) FortuneItem(child: Text(ZegoUIKit().getUser(id.toString()).name), style: FortuneItemStyle(color: _getFillColor(ColorManager.mainColorList, widget.list.indexOf(id), widget.list.length))),
            ],
          ),
        ),
        Image.asset(AssetsPath.spinWheelGameFrameIcon, scale: 1.45,),
      ],
    );
  }
  Color _getFillColor(List<Color> theme, int index, int itemCount) {
    final color = theme[0];
    final background = theme[1];
    final opacity = itemCount % 2 == 1 && index == 0
        ? 0.7
        : index % 2 == 0
        ? 0.5
        : 1.0;

    return Color.alphaBlend(
      color.withOpacity(opacity),
      background,
    );
  }
}
