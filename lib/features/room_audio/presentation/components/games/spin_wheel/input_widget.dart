// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/spin_wheel_game_screen.dart';

class InputWidget extends StatefulWidget {
  int? index;
  TextEditingController? controller ;
  InputWidget({super.key,  this.index, this.controller });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
        height: ConfigSize.defaultSize!*8,
        margin: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize! * 0.5),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(55, 47, 148, .84),
          border: Border.all(color: const Color.fromRGBO(149, 159, 225, 1)),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.3),
        ),
        child: Padding(
          padding: EdgeInsets.only(top:ConfigSize.defaultSize!*0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: ConfigSize.screenWidth! * 0.75,
                height: ConfigSize.screenHeight! * 0.05,
                child: TextFieldWidget(
                    suffixIcon: widget.index! > 1
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () {
                                SpinWheelGameScreen.textFieldWidget.removeAt(widget.index!);
                                SpinWheelGameScreen.textFieldValues = removeFromMap<String>(SpinWheelGameScreen.textFieldValues, widget.index!);
                                SpinWheelGameScreen.updateList.value += 1;
                              },
                              child: Image.asset(
                                AssetsPath.spinWheelGameDeleteIcon,
                                scale: .8,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    prefixIcon: const Icon(Icons.edit,
                        color: Color.fromRGBO(149, 159, 225, 1)),
                    maxLength: 20,
                    onChanged: (v) {
                      SpinWheelGameScreen.textFieldValues
                          .putIfAbsent(widget.index!, () => v);

                      SpinWheelGameScreen.textFieldValues
                          .update(widget.index!, (value) => v);
                      setState(() {});
                    },
                    onSubmitted: (text) {
                      SpinWheelGameScreen.peoples.add(text);
                    },
                    maxLines: 1,
                    hintColor: const Color.fromRGBO(149, 159, 225, 1),
                    hintText: StringManager.chooseContent.tr(),
                    controller: widget.controller!),
              ),

            ],
          ),
        )
    );
  }


  Map<int, T> removeFromMap<T>(Map<int, T> map, int index) {
    var list = map.entries.map((e) => e.value).toList();
    list.removeAt(index);
    var newIndex = 0;


    return Map.fromIterable(list,
        key: (item) => newIndex++, value: (item) => item);
  }
}
