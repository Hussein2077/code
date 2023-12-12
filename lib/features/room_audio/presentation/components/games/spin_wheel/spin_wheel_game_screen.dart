import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/free_play_body.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/input_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/paid_play_body.dart';

class SpinWheelGameScreen extends StatefulWidget {
  final EnterRoomModel roomData;
  const SpinWheelGameScreen({super.key, required this.roomData});

  @override
  State<SpinWheelGameScreen> createState() => _SpinWheelGameScreenState();
  static ValueNotifier<int> updateList = ValueNotifier(0);
  static List<String> peoples = [];
  static List<int> peoplesId = [];
  static Map<int, String> textFieldValues = {};

  static List<Widget> textFieldWidget = [InputWidget(), InputWidget()];
}

class _SpinWheelGameScreenState extends State<SpinWheelGameScreen> {


  int index = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.screenHeight! * 0.75,
      width: ConfigSize.screenWidth,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: 0,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.asset(
                  AssetsPath.spinWheelGameHeaderImage,
                  scale: .9,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      AssetsPath.spinWheelGameExiteIcon,
                      scale: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),

          if(index == -1) Container(
            height: ConfigSize.screenHeight! * 0.61,
            width: ConfigSize.screenWidth,
            color: const Color.fromRGBO(80, 68, 213, 1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(AssetsPath.spinWheelGameBtnIcon, scale: .8,),
                      Text(
                        StringManager.freePlay.tr(),
                        style: TextStyle(
                            color: const Color.fromRGBO(
                                149, 72, 72, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: ConfigSize.defaultSize! * 2.5),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ConfigSize.defaultSize! * 2,),

                InkWell(
                  onTap: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(AssetsPath.spinWheelGameBtnIcon, scale: .8,),
                      Text(
                        StringManager.PaidPlay.tr(),
                        style: TextStyle(
                            color: const Color.fromRGBO(
                                149, 72, 72, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: ConfigSize.defaultSize! * 2.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if(index == 0) const FreePlayBody(),

          if(index == 1) PaidPlayBody(roomData: widget.roomData),
        ],
      ),
    );
  }
}
