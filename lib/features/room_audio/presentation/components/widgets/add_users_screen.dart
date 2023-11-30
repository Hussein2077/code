import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/spin_screen.dart';

class AddUsersScreen extends StatefulWidget {
  const AddUsersScreen({super.key});

  @override
  State<AddUsersScreen> createState() => _AddUsersScreenState();
  static ValueNotifier<int> updateList = ValueNotifier(0);
}

class _AddUsersScreenState extends State<AddUsersScreen> {

  late TextEditingController controller = TextEditingController();
  StreamController<int> selected = StreamController<int>();
  List<String> peoples = [];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.screenHeight! * 0.6,
      width: ConfigSize.screenWidth,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldWidget(
                      onChanged: (v) {},
                      hintColor: Colors.black.withOpacity(0.6),
                      hintText: StringManager.add.tr(),
                      controller: controller),
                )
            ),
          ),

          MainButton(
              onTap: (){
                if(controller.text != ""){
                  peoples.add(controller.text);
                  AddUsersScreen.updateList.value += 1;
                  controller.clear();
                }
              },
              title: "ADD"
          ),

          const SizedBox(height: 20,),

          ValueListenableBuilder<int>(
            valueListenable: AddUsersScreen.updateList,
            builder: (context, edit, _) {
              return ListView.builder(
                shrinkWrap: true,
                  itemCount: peoples.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(peoples[index]),
                    );
                  }
              );
            },
          ),

          MainButton(
              onTap: (){
                Navigator.pop(context);
                  bottomDailog(
                      context: context,
                      widget: SpinScreen(list: peoples,));
              },
              title: "Spin"
          ),
        ],
      ),
    );
  }
}
