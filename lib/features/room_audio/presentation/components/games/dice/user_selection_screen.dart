// ignore_for_file: non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/invite_to_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_manager/game_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_manager/game_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_manager/game_states.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class UserSelectionDiceScreen extends StatefulWidget {
  final EnterRoomModel roomData;
  const UserSelectionDiceScreen({super.key, required this.roomData});

  @override
  State<UserSelectionDiceScreen> createState() => _UserSelectionScreenDiceState();
}

class _UserSelectionScreenDiceState extends State<UserSelectionDiceScreen> {

  String selected_user_id = "";
  late TextEditingController controller ;
  bool send = false;

  @override
  void initState() {
    controller = TextEditingController();
    selected_user_id = "";
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (BuildContext context, GameState state) {
        if(state is InviteToGameErrorState){
          send = false;
          errorToast(context: context, title: state.error);
        }
      },
      child: Container(
        height: ConfigSize.screenHeight! * 0.7,
        width: ConfigSize.screenWidth,
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: ConfigSize.screenHeight! * 0.62,
              width: ConfigSize.screenWidth,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: ColorManager.bageGriedinet),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, color: Colors.white, size: ConfigSize.defaultSize! * 3,),
                      ),
                    ],
                  ),

                  Text(
                    StringManager.numberOfCoins.tr(),
                    style: TextStyle(
                        color: const Color.fromRGBO(149, 159, 225, 1),
                        fontSize: ConfigSize.defaultSize! * 2,
                        fontWeight: FontWeight.w600
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: StringManager.numberOfCoins.tr(),
                        hintStyle: TextStyle(
                            color: const Color.fromRGBO(149, 159, 225, 1),
                            fontSize: ConfigSize.defaultSize! * 1.5,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      onChanged: (text){
                        setState(() {

                        });
                      },
                      onSubmitted: (text){
                        setState(() {

                        });
                      },
                    ),
                  ),

                  Text(
                    StringManager.pleseSelectUser.tr(),
                    style: TextStyle(
                        color: const Color.fromRGBO(149, 159, 225, 1),
                        fontSize: ConfigSize.defaultSize! * 2,
                        fontWeight: FontWeight.w600
                    ),
                  ),

                  SizedBox(
                    height: ConfigSize.screenHeight! * 0.34,
                    width: ConfigSize.screenWidth,
                    child: ListView.builder(
                        itemCount: ZegoUIKit().getAllUsers().length,
                        itemBuilder: (context, index){
                          if(ZegoUIKit().getAllUsers()[index].id.toString() != MyDataModel.getInstance().id.toString()&& !(ZegoUIKit().getAllUsers()[index].id.toString().startsWith('-1'))) {
                            return InkWell(
                            onTap: (){
                              setState(() {
                                selected_user_id = ZegoUIKit().getAllUsers()[index].id;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 2),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: selected_user_id == ZegoUIKit().getAllUsers()[index].id ? const Color.fromRGBO(149, 159, 225, 1) : Colors.transparent ),
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
              top: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetsPath.diceIcon, scale: .7,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  if(selected_user_id != "" && controller.text != "" && !send){
                    send = true;
                    BlocProvider.of<GameBloc>(context).add(InviteToGame(inviteToGamePramiter: InviteToGamePramiter(
                      ownerId: widget.roomData.ownerId.toString(),
                      userId: selected_user_id,
                      coins: controller.text,
                      game_id: "2",
                    )));
                  }else{

                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    selected_user_id != "" && controller.text != ""? Image.asset(AssetsPath.spinWheelGameBtnIcon, scale: .8,) : Image.asset(AssetsPath.luckyDrawGameGrayBtn, scale: 1,),
                    Text(StringManager.next.tr(), style: TextStyle(color: const Color.fromRGBO(149, 72, 72, 1), fontWeight: FontWeight.w600, fontSize: ConfigSize.defaultSize! * 2),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
