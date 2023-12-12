import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/spin_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/spin_wheel_game_screen.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class PaidPlayBody extends StatefulWidget {
  const PaidPlayBody({super.key});

  @override
  State<PaidPlayBody> createState() => _PaidPlayBodyState();
}

class _PaidPlayBodyState extends State<PaidPlayBody> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: ConfigSize.screenHeight! * 0.61,
          width: ConfigSize.screenWidth,
          color: const Color.fromRGBO(80, 68, 213, 1.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  StringManager.pleseSelectUser.tr(),
                  style: TextStyle(
                      color: const Color.fromRGBO(149, 159, 225, 1),
                      fontSize: ConfigSize.defaultSize! * 2,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),

              SizedBox(
                height: ConfigSize.screenHeight! * 0.34,
                width: ConfigSize.screenWidth,
                child: ListView.builder(
                    itemCount: ZegoUIKit().getAllUsers().length,
                    itemBuilder: (context, index){
                      if(ZegoUIKit().getAllUsers()[index].id.toString() != MyDataModel.getInstance().id.toString()) {
                        return InkWell(
                          onTap: (){
                            setState(() {
                              if(SpinWheelGameScreen.peoples.contains(ZegoUIKit().getAllUsers()[index].id)){
                                SpinWheelGameScreen.peoples.remove(ZegoUIKit().getAllUsers()[index].id);
                              }else {
                                SpinWheelGameScreen.peoples.add(ZegoUIKit().getAllUsers()[index].id);
                              }
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 2),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: SpinWheelGameScreen.peoples.contains(ZegoUIKit().getAllUsers()[index].id) ? const Color.fromRGBO(149, 159, 225, 1) : Colors.transparent ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    UserImage(
                                      boxFit: BoxFit.cover,
                                      image: ZegoUIKit().getAllUsers()[index].inRoomAttributes.value['img']?? "",
                                    ),
                                    SizedBox(
                                      width: ConfigSize.defaultSize! * 2.5,
                                    ),
                                    Text(
                                      ZegoUIKit().getAllUsers()[index].name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ConfigSize.defaultSize! * 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }else{
                        return const SizedBox();
                      }
                    }
                ),
              ),
            ],
          ),
        ),

        Positioned(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: ConfigSize.screenWidth,
                height: ConfigSize.defaultSize! * 11,
              ),
              Container(
                width: ConfigSize.screenWidth,
                height: ConfigSize.defaultSize! * 9,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetsPath.spinWheelGameBottonImage),
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: ConfigSize.defaultSize! * 10,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if(SpinWheelGameScreen.peoples.length >= 2){
                                Navigator.pop(context);
                                bottomDailog(
                                    context: context,
                                    widget: SpinScreen(
                                      list: SpinWheelGameScreen.peoples,
                                      isActive: false,
                                      isFree: false,
                                    ));
                              }
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(AssetsPath.spinWheelGameBtnIcon),
                                Text(
                                  StringManager.save.tr(),
                                  style: TextStyle(
                                      color: const Color.fromRGBO(
                                          149, 72, 72, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: ConfigSize.defaultSize! * 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
