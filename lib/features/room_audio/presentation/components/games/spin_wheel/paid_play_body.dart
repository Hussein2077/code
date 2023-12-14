import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/invite_to_game_new_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/dialog_explained_game.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/spin_wheel_game_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_manager/game_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_manager/game_event.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class PaidPlayBody extends StatefulWidget {
  final EnterRoomModel roomData;
  const PaidPlayBody({super.key, required this.roomData});

  @override
  State<PaidPlayBody> createState() => _PaidPlayBodyState();
}

class _PaidPlayBodyState extends State<PaidPlayBody> {

  late TextEditingController controller ;

  @override
  void initState() {
    SpinWheelGameScreen.peoples.clear();

    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    SpinWheelGameScreen.peoplesId.clear();
    super.dispose();
  }


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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: Colors.white, size: ConfigSize.defaultSize! * 3,),
                  ),
                  Text(
                    StringManager.numberOfCoins.tr(),
                    style: TextStyle(
                        color: const Color.fromRGBO(149, 159, 225, 1),
                        fontSize: ConfigSize.defaultSize! * 2,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      bottomDailog(context: context, widget:  ExplainGame(
                          hight: ConfigSize.screenHeight! * 0.77 ,
                          hightContaner:ConfigSize.screenHeight! * 0.62  ,
                          explainGame:StringManager.spineGame.tr() ,
                          iconGame: AssetsPath.spinWheelGameHeaderImage,
                        linearGradient: const [
                          Color.fromRGBO(80, 68, 213, 1.0),
                          Color.fromRGBO(80, 68, 213, 1.0),
                        ],
                        topPostion: ConfigSize.defaultSize!*16,

                        logoIcon: AssetsPath.turntableIcon,
                      ));
                    },
                    icon: CircleAvatar(
                     backgroundColor: Colors.white,
                        child: Icon(Icons.question_mark_outlined, color: Colors.black, size: ConfigSize.defaultSize! * 3,)),
                  ),
                ],
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
                              if(SpinWheelGameScreen.peoplesId.contains(int.parse(ZegoUIKit().getAllUsers()[index].id))){
                                SpinWheelGameScreen.peoplesId.remove(int.parse(ZegoUIKit().getAllUsers()[index].id));
                              }else {
                                SpinWheelGameScreen.peoplesId.add(int.parse(ZegoUIKit().getAllUsers()[index].id));
                              }
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 2),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: SpinWheelGameScreen.peoplesId.contains(int.parse(ZegoUIKit().getAllUsers()[index].id)) ? const Color.fromRGBO(149, 159, 225, 1) : Colors.transparent ),
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
                              if (SpinWheelGameScreen.peoplesId.length<1){
                                errorToast(context: context, title: StringManager.pleaseAddAtLeastTwoValue.tr());
                              }else {
                                BlocProvider.of<GameBloc>(context).add(InviteToGameNew(inviteToGamePramiter: InviteToGameNewPramiter(
                                    ownerId: widget.roomData.ownerId.toString(),
                                    game_id: "3",
                                    players: SpinWheelGameScreen.peoplesId,
                                    coins: controller.text,
                                    round_num: 1
                                )));
                              }

                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(AssetsPath.spinWheelGameBtnIcon),
                                Text(
                                  StringManager.save.tr(),
                                  style: TextStyle(
                                      color: const Color.fromRGBO(149, 72, 72, 1),
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
