// ignore_for_file: depend_on_referenced_packages, must_be_immutable
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/spin_wheel_game_screen.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class SpinScreen extends StatefulWidget {
  List<dynamic> list;
  bool isActive;
  bool isFree;
  int? winner;
  SpinScreen({super.key, required this.list, required this.isActive, required this.isFree, this.winner});

  @override
  State<SpinScreen> createState() => _SpinScreenState();
}

class _SpinScreenState extends State<SpinScreen> {

  final _wheelNotifier = BehaviorSubject<int>();
  bool _isSpinning = false;
  String selectedItem = "";

  @override
  void initState() {
    if(!widget.isFree){
      _isSpinning = true;
      _wheelNotifier.add(widget.winner!);
    }
    super.initState();
  }

  @override
  void dispose() {
    _wheelNotifier.close();
    SpinWheelGameScreen.peoples.clear();
    SpinWheelGameScreen.updateList.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: ConfigSize.screenHeight! * 0.6,
            width: ConfigSize.screenWidth,
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  bottom: 0,
                    child: Image.asset(AssetsPath.spinWheelGameFrameBgIcon, scale: .9,)),
                Positioned(
                  bottom: ConfigSize.defaultSize! * 12,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: ConfigSize.screenWidth! * .82,
                        height: ConfigSize.screenHeight! * .4,
                        child: FortuneWheel(
                          selected: _wheelNotifier.stream,
                          animateFirst: false,
                          indicators: [
                            FortuneIndicator(
                                child: SizedBox(
                                  height: ConfigSize.defaultSize! * 14,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(top: 0,child: Image.asset(AssetsPath.spinWheelGameIndicatorIcon1, scale: 1.2,)),
                                      Image.asset(AssetsPath.spinWheelGameIndicatorIcon2, scale: 1),
                                    ],
                                  ),
                                ),
                            ),
                          ],
                          onAnimationEnd: () {
                            if (_isSpinning) {
                              _isSpinning = false;
                            }
                            if(widget.isActive && widget.list.length > 2){
                              setState(() {
                                widget.list.remove(widget.list[_wheelNotifier.value]);
                              });
                            }
                            if(!widget.isFree){
                              Navigator.pop(context);
                            }
                          },
                          items: [
                            for (var id in widget.list) FortuneItem(child: Text(ZegoUIKit().getUser(id).name), style: FortuneItemStyle(color: _getFillColor(ColorManager.mainColorList, widget.list.indexOf(id), widget.list.length))),
                          ],
                        ),
                      ),
                      Image.asset(AssetsPath.spinWheelGameFrameIcon, scale: .9,),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Image.asset(AssetsPath.spinWheelGameExiteIcon, scale: 1,),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(!_isSpinning){
                      _isSpinning = true;
                      if(widget.isFree){
                        int winner = Fortune.randomInt(0, widget.list.length);
                        _wheelNotifier.add(winner);
                        ZegoUIKit.instance.sendInRoomCommand(getMessagaRealTime(
                            MyDataModel.getInstance().id.toString(),
                            winner,
                            widget.list
                        ), []);
                      }
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(AssetsPath.spinWheelGameBtnIcon, scale: .8,),
                      Text(StringManager.spin.tr(), style: TextStyle(color: const Color.fromRGBO(149, 72, 72, 1), fontWeight: FontWeight.w600, fontSize: ConfigSize.defaultSize! * 2),),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 18,
                        child: Text(StringManager.end.tr(), style: const TextStyle(color: Color.fromRGBO(80, 68, 213, 1.0)),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

  String getMessagaRealTime(String ownerId, int winner, List<dynamic> items){
    var mapInformation = {"messageContent":{
      "message": "freeSpinGame",
      "ownerId": ownerId,
      "winner": winner,
      "items": items,
    }};
    String map = jsonEncode(mapInformation);
    return map ;
  }
}
