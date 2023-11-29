// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class SpinScreen extends StatefulWidget {
  List<String> list;
  SpinScreen({super.key, required this.list});

  @override
  State<SpinScreen> createState() => _SpinScreenState();
}

class _SpinScreenState extends State<SpinScreen> {

  final _wheelNotifier = BehaviorSubject<int>();
  bool _isSpinning = false;
  String selectedItem = "";

  @override
  void dispose() {
    _wheelNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.screenHeight! * 0.6,
      width: ConfigSize.screenWidth,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FortuneWheel(
              selected: _wheelNotifier.stream,
              animateFirst: false, //start animation when open screen
              onAnimationEnd: () {
                if (_isSpinning) {
                  _isSpinning = false;
                }
                ZegoUIKit.instance.sendInRoomMessage("انضم للغرفة", false);
                print(widget.list[_wheelNotifier.value]);
              },
              items: [
                for (var it in widget.list) FortuneItem(child: Text(it), style: FortuneItemStyle(color: _getFillColor(ColorManager.mainColorList, widget.list.indexOf(it), widget.list.length))),
              ],
            ),
          ),

          MainButton(
              onTap: (){
                if(!_isSpinning){
                  _wheelNotifier.add(Fortune.randomInt(0, widget.list.length));
                }
              },
              title: "Spin"
          ),
        ],
      ),
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
