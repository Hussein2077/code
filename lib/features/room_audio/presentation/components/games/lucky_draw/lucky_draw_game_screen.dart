import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_users.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/dialog_explained_game.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/lucky_draw/comment_body.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/lucky_draw/selection_widget.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class LuckyDrawGameScreen extends StatefulWidget {
  EnterRoomModel room;
  LuckyDrawGameScreen({super.key, required this.room});

  @override
  State<LuckyDrawGameScreen> createState() => _LuckyDrawGameScreenState();

  static Map<int,SelecteUsers>  userSelected = {};
}

class _LuckyDrawGameScreenState extends State<LuckyDrawGameScreen> {

  List<String> chooises = [StringManager.usersOnMic.tr(), StringManager.usersInRoom.tr()];

  int selected1 = -1;

  @override
  void initState() {
    LuckyDrawGameScreen.userSelected.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.screenHeight! * 0.63,
      width: ConfigSize.screenWidth,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          Stack(
            children: [

              Image.asset(AssetsPath.luckyDrawGameHeader, scale: .9,),

              Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: Image.asset(AssetsPath.luckyDrawGameExite, scale: 1,),
                  ),
              ),


            ],
          ),

          Container(
            width: ConfigSize.screenWidth,
            height: ConfigSize.screenHeight! * 0.45,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsPath.luckyDrawGameBody),
                fit: BoxFit.fill
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  IconButton(
                    onPressed: (){
                      bottomDailog(context: context, widget:  ExplainGame(
                        hight: ConfigSize.screenHeight! * 0.60 ,
                        hightContaner:ConfigSize.screenHeight! * 0.52  ,
                        explainGame:StringManager.luckyDraw.tr() ,
                        linearGradient: const [
                          Color(0xffffd0be),
                          Color(0xffffc8b3)
                        ],
                        iconGame: AssetsPath.luckyDrawGameHeader,
                        topPostion: ConfigSize.defaultSize!*10,
                        logoIcon: AssetsPath.lotteryIcon,
                      ));
                    },
                    icon: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.question_mark_outlined, color: Colors.black, size: ConfigSize.defaultSize! * 3,)),
                  ),
                  Spacer(),
                  Text(StringManager.rangeOfUsers.tr(), style: TextStyle(color: const Color.fromRGBO(149, 72, 72, 1), fontSize: ConfigSize.defaultSize! * 2),),
                  const SizedBox(height: 10),
                  ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            if(index == 0){
                              GiftUser.userOnMicsForGifts.forEach((key, value) {
                                if(!(value.id.toString().startsWith('-1'))) {
                                  LuckyDrawGameScreen.userSelected.putIfAbsent(key, () => SelecteUsers(
                                  userId: value.id,
                                  selected: true,
                                  name: value.name,
                                  image: value.inRoomAttributes.value['img']!,
                                ),);
                                }
                              });
                            } else{
                              for(int i =0 ; i < ZegoUIKit().getAllUsers().length; i++){
                                if(!(ZegoUIKit().getAllUsers()[i].id.toString().startsWith('-1'))) {
                                  LuckyDrawGameScreen.userSelected.putIfAbsent(int.parse(ZegoUIKit().getAllUsers()[i].id), () => SelecteUsers(
                                    userId: ZegoUIKit().getAllUsers()[i].id,
                                    selected: true,
                                    name: ZegoUIKit().getAllUsers()[i].name,
                                    image: ZegoUIKit().getAllUsers()[i].inRoomAttributes.value['img']?? "",
                                ),
                                );
                                }
                              }
                            }
                            setState(() {
                              selected1 = index;
                            });
                          },
                            child: SelectionWidget(chooises: chooises, index: index, selected: (selected1 == index)),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: chooises.length
                  ),
                  Spacer(flex: 2),

                ],
              ),
            ),
          ),

          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(AssetsPath.luckyDrawGameBottom, scale: .9,),

              InkWell(
                onTap: (){
                  if(selected1 != -1){
                    int winner = Fortune.randomInt(0, LuckyDrawGameScreen.userSelected.length);
                    List<int> mapKeysList = sortMapByKey(LuckyDrawGameScreen.userSelected).keys.toList();
                    ZegoUIKit.instance.sendInRoomCommand(getMessagaRealTime(
                        winner,
                        selected1,
                        mapKeysList[winner]
                    ), []);
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return CommentBody(
                            items: sortMapByKey(LuckyDrawGameScreen.userSelected),
                            winner: winner,
                            room: widget.room,
                            id: mapKeysList[winner],
                          );
                        });
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    selected1 != -1? Image.asset(AssetsPath.spinWheelGameBtnIcon, scale: .65,) : Image.asset(AssetsPath.luckyDrawGameGrayBtn, scale: .95,),
                    Text(StringManager.start.tr(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: ConfigSize.defaultSize! * 2),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  String getMessagaRealTime(int winner, int index, int id){
    var mapInformation = {"messageContent":{
      "message": "luckyDraw",
      "winner": winner,
      "index": index,
      "id": id,
    }};
    String map = jsonEncode(mapInformation);
    return map ;
  }
  Map<int, SelecteUsers> sortMapByKey(Map<int, SelecteUsers> inputMap) {
    List<MapEntry<int, SelecteUsers>> entries = inputMap.entries.toList();
    entries.sort((a, b) => a.key.compareTo(b.key));
    return Map.fromEntries(entries);
  }
}

class SelecteUsers {
  final String userId ;
  final String image ;
  final String name ;
  final bool selected ;
  const SelecteUsers({required this.userId, required this.image, required this.name, required this.selected});
}