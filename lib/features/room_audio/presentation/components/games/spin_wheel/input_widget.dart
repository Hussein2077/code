// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/spin_wheel_game_screen.dart';

class InputWidget extends StatefulWidget {
  int index;
  List<int> numberOfInputs;
  InputWidget({super.key, required this.index, required this.numberOfInputs});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(55, 47, 148, .84),
          border: Border.all(color: const Color.fromRGBO(149, 159, 225, 1)),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: ConfigSize.defaultSize! * 3,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                          onChanged: (v) {
                            setState(() {
                            });
                          },
                          onSubmitted: (text){
                            SpinWheelGameScreen.peoples.add(text);
                          },
                          maxLines: 1,
                          hintColor: const Color.fromRGBO(149, 159, 225, 1),
                          hintText: StringManager.add.tr(),
                          controller: controller),
                    ),
                    if(widget.index > 1) Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: (){
                          print(widget.numberOfInputs);
                          widget.numberOfInputs.remove(widget.numberOfInputs[widget.index]);
                          SpinWheelGameScreen.updateList.value += 1;
                          print(widget.numberOfInputs);
                        },
                        child: Image.asset(AssetsPath.spinWheelGameDeleteIcon, scale: .8,),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ConfigSize.defaultSize!,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.edit, color: Color.fromRGBO(149, 159, 225, 1), size: 20,),
                      SizedBox(width: ConfigSize.defaultSize! / 2,),
                      Text(StringManager.chooseContent.tr(), style: const TextStyle(color: Color.fromRGBO(149, 159, 225, 1)),),
                    ],
                  ),

                  Row(
                    children: [
                      Text(controller.text.length.toString(), style: const TextStyle(color: Colors.white),),
                      const Text("/20", style: TextStyle(color: Color.fromRGBO(149, 159, 225, 1)),),
                    ],
                  ),

                ],
              ),
            ],
          ),
        )
    );
  }
}
