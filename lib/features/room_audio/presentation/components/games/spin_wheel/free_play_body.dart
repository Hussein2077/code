import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/input_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/spin_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/spin_wheel_game_screen.dart';

class FreePlayBody extends StatefulWidget {
  const FreePlayBody({super.key});

  @override
  State<FreePlayBody> createState() => _FreePlayBodyState();
}

class _FreePlayBodyState extends State<FreePlayBody> {

  late TextEditingController controller;

  @override
  void initState() {
    SpinWheelGameScreen.peoples.clear();
    SpinWheelGameScreen.textFieldWidget = [InputWidget(), InputWidget()];
    SpinWheelGameScreen.textFieldValues.clear();
    SpinWheelGameScreen.textFieldValues.putIfAbsent(0, () => "");
    SpinWheelGameScreen.textFieldValues.putIfAbsent(1, () => "");

    controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    controller.clear();
    super.dispose();
  }

  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: ConfigSize.screenHeight! * 0.61,
          width: ConfigSize.screenWidth,
          color: const Color.fromRGBO(80, 68, 213, 1.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: SpinWheelGameScreen.updateList,
                  builder: (context, edit, _) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return SpinWheelGameScreen.textFieldWidget[index] =
                            InputWidget(
                              index: index,
                              controller: TextEditingController(
                                  text: SpinWheelGameScreen
                                      .textFieldValues[index] ??
                                      ""),
                            );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: ConfigSize.defaultSize! / 2,
                        );
                      },
                      itemCount: SpinWheelGameScreen.textFieldWidget.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(ConfigSize.defaultSize! * 2.5),
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  },
                ),

                SizedBox(height: ConfigSize.defaultSize! * 2,),

                InkWell(
                  onTap: () {
                    SpinWheelGameScreen.textFieldWidget.add(InputWidget());
                    SpinWheelGameScreen.updateList.value += 1;
                    SpinWheelGameScreen.textFieldValues.putIfAbsent(
                        SpinWheelGameScreen.textFieldWidget.length - 1,
                            () => "");
                  },
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(149, 159, 225, 1),
                    radius: ConfigSize.defaultSize! * 2,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(80, 68, 213, 1.0),
                      radius: ConfigSize.defaultSize! * 1.85,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: ConfigSize.defaultSize! * 3.5,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: ConfigSize.defaultSize! * 18,),

              ],
            ),
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
                      width: ConfigSize.screenWidth! * .55,
                      child: Text(
                        StringManager.removeResult.tr(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 17),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 10,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              SpinWheelGameScreen.textFieldValues.forEach((key, value) {
                                SpinWheelGameScreen.peoples.add(value);

                              });
                              if (SpinWheelGameScreen.peoples.length<2){
                                errorToast(context: context, title: StringManager.pleaseAcceptTheRegulations.tr());
                              }else {
                                Navigator.pop(context);

                                bottomDailog(
                                    context: context,
                                    widget: SpinScreen(
                                      list: SpinWheelGameScreen.peoples,
                                      isActive: isActive,
                                      isFree: true,
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
                          Switch(
                            activeColor: ColorManager.mainColor,
                            value: isActive,
                            onChanged: (value) {
                              if (isActive == false) {
                                isActive = true;
                              } else {
                                isActive = false;
                              }
                              setState(() {});
                            },
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
