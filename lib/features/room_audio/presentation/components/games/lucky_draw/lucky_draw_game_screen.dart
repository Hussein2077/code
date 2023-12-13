import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/lucky_draw/selection_widget.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class LuckyDrawGameScreen extends StatefulWidget {
  const LuckyDrawGameScreen({super.key});

  @override
  State<LuckyDrawGameScreen> createState() => _LuckyDrawGameScreenState();

  static Map<int,SelecteUsers>  userSelected = {};
}

class _LuckyDrawGameScreenState extends State<LuckyDrawGameScreen> {

  List<String> chooises = [StringManager.usersOnMic.tr(), StringManager.usersInRoom.tr()];
  List<String> numbers = ["1"];

  int selected1 = -1;
  int selected2 = -1;

  @override
  void initState() {
    LuckyDrawGameScreen.userSelected.clear();
    print(RoomScreen.userOnMics.toString());
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(StringManager.rangeOfUsers.tr(), style: TextStyle(color: const Color.fromRGBO(149, 72, 72, 1), fontSize: ConfigSize.defaultSize! * 2),),
                  const SizedBox(height: 10),

                  ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){

                            if(index == 0){

                              for(int i =0 ; i < RoomScreen.userOnMics.value.length; i++) {
                                LuckyDrawGameScreen.userSelected.putIfAbsent(i,
                                        () => SelecteUsers(
                                          userId: RoomScreen.userOnMics.value[i]?.id ?? "",
                                          selected: true,
                                          name: RoomScreen.userOnMics.value[i]?.name?? "",
                                          image: RoomScreen.userOnMics.value[i]?.inRoomAttributes.value['img']?? "",
                                        ),
                                );

                              }

                            } else{

                              for(int i =0 ; i < ZegoUIKit().getAllUsers().length; i++){
                                LuckyDrawGameScreen.userSelected.putIfAbsent(i, () => SelecteUsers(
                                    userId: ZegoUIKit().getAllUsers()[i].id,
                                    selected: true,
                                    name: ZegoUIKit().getAllUsers()[i].name,
                                    image: ZegoUIKit().getAllUsers()[i].inRoomAttributes.value['img']?? "",
                                ),
                                );
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

                  const SizedBox(height: 10),

                  Text(StringManager.numberOfLuckyUsers.tr(), style: TextStyle(color: const Color.fromRGBO(149, 72, 72, 1), fontSize: ConfigSize.defaultSize! * 2),),

                  const SizedBox(height: 10),

                  ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            setState(() {
                              selected2 = index;
                            });
                          },
                          child: SelectionWidget(chooises: numbers, index: index, selected: (selected2 == index)),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: numbers.length
                  ),
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
                  if(selected1 != -1 && selected2 != -1){
                    ZegoUIKit.instance.sendInRoomMessage(StringManager.luckyDrawGameKey+" ", );
                    Navigator.pop(context);
                  }else{

                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    selected1 != -1 && selected2 != -1? Image.asset(AssetsPath.spinWheelGameBtnIcon, scale: .65,) : Image.asset(AssetsPath.luckyDrawGameGrayBtn, scale: .95,),
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
}

class SelecteUsers {
  final String userId ;
  final String image ;
  final String name ;
  final bool selected ;
  const SelecteUsers({required this.userId, required this.image, required this.name, required this.selected});
}