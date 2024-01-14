import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_events.dart';

import '../../../../../../zego_code_v3/zego_uikit/src/services/services.dart';


class TimeWidget extends StatefulWidget {
  final UserDataModel userData;
  final EnterRoomModel roomData;
  const TimeWidget({super.key, required this.userData, required this.roomData});

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  final List<String> items = [
    StringManager.fiveMin.tr(),
    StringManager.fiftyMin.tr(),
    StringManager.thirtyMin.tr(),
    StringManager.sixtyMin.tr(),
    StringManager.twenyFourMin.tr()
  ];
  String? selectedValue;
  int? selectedindex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ConfigSize.defaultSize! * 20,
      width: ConfigSize.defaultSize! * 20,
      child: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 15,
            width: ConfigSize.defaultSize! * 25,
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    setState(() {
                      selectedValue = items[index];
                      selectedindex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedindex == index ? ColorManager.mainColor : ColorManager.gray,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        items[index],
                        style: TextStyle(
                          fontSize: ConfigSize.defaultSize! * 1.4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          MainButton(
            onTap: () async {
              if (selectedValue == StringManager.fiveMin.tr()) {
                BlocProvider.of<UsersInRoomBloc>(context).add(kickoutUser(
                    ownerId: widget.roomData.ownerId.toString(),
                    userId: widget.userData.id.toString(),
                    minutes: "5"));
              } else if (selectedValue == StringManager.fiftyMin.tr()) {
                BlocProvider.of<UsersInRoomBloc>(context).add(kickoutUser(
                    ownerId: widget.roomData.ownerId.toString(),
                    userId: widget.userData.id.toString(),
                    minutes: "15"));
              } else if (selectedValue == StringManager.thirtyMin.tr()) {
                BlocProvider.of<UsersInRoomBloc>(context).add(kickoutUser(
                    ownerId: widget.roomData.ownerId.toString(),
                    userId: widget.userData.id.toString(),
                    minutes: "30"));
              } else if (selectedValue == StringManager.sixtyMin.tr()) {
                BlocProvider.of<UsersInRoomBloc>(context).add(kickoutUser(
                    ownerId: widget.roomData.ownerId.toString(),
                    userId: widget.userData.id.toString(),
                    minutes: "60"));
              } else if (selectedValue == StringManager.twenyFourMin.tr()) {
                BlocProvider.of<UsersInRoomBloc>(context).add(kickoutUser(
                    ownerId: widget.roomData.ownerId.toString(),
                    userId: widget.userData.id.toString(),
                    minutes: "1440"));
              }
              Navigator.pop(context);
            },
            width: ConfigSize.screenWidth!*0.4,
            height: ConfigSize.defaultSize! * 4,
            title: StringManager.confirm.tr(),
          ),
        ],
      ),
    );
  }
}
