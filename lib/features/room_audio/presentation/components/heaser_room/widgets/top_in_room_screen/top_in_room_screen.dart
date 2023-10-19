
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/widgets/top_in_room_screen/Widgets/hearder_topIn_room_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/widgets/top_in_room_screen/Widgets/top_in_room_screen_body.dart';


class TopInRoomScreen extends StatefulWidget  {
    final int id;
    final EnterRoomModel roomData ;
    final MyDataModel myData ;
    final LayoutMode layoutMode ;
  const TopInRoomScreen({required this.id, required this.layoutMode,
    required this.myData, required this.roomData, Key? key}) : super(key: key);

  @override
  _TopInRoomScreenState createState() => _TopInRoomScreenState();
}

class _TopInRoomScreenState extends State<TopInRoomScreen>  with TickerProviderStateMixin {

  late TabController headertabcontroler;


  @override
  void initState() {
    super.initState();
    headertabcontroler = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.screenHeight! / 1.5,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2.2),
        color: Colors.white,
      ),
      child: Column(
          children: [
            HearderTopInRoomScreen(dateController: headertabcontroler,),
            DefaultTabController(
                length:2,
                child:  TopInRoomScreenBody(id: widget.id,
                  dateController : headertabcontroler,
                  roomData: widget.roomData,
                  myData: widget.myData, layoutMode: widget.layoutMode, )
            )


          ]),
    );
  }
}




