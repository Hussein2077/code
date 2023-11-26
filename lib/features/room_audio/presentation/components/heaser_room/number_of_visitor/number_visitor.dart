
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/number_of_visitor/visitors_room_screen/Visitors_Room_Screen.dart';

class NumberOfVisitor extends StatefulWidget {
 final MyDataModel myDataModel;
  final String ownerId;
  final String numberOfVistor;
  final EnterRoomModel roomData;
  final LayoutMode layoutMode ;

 const NumberOfVisitor(
      {required this.ownerId,
      required this.numberOfVistor,
      required this.myDataModel,
      required this.roomData,
        required this.layoutMode,
      Key? key})
      : super(key: key);

  @override
  NumberOfVisitorState createState() => NumberOfVisitorState();
}

class NumberOfVisitorState extends State<NumberOfVisitor> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bottomDailog(
          context: context,
          widget: VisitorsRoomScreen(
            numberOfVistor: int.parse(widget.numberOfVistor),
            roomData: widget.roomData,
           layoutMode:widget.layoutMode, myDataModel: widget.myDataModel ,
          ),
        );
      },
      child:  Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p6),
            child: Row(
              children: [
                 Icon(
                  Icons.person,
                  color: Colors.white,
                  size: ConfigSize.defaultSize!*2,
                ),
                Text(
                  widget.numberOfVistor,
                  style:  TextStyle(
                      color: Colors.white,
                      fontSize: ConfigSize.defaultSize!*1.4,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ));


  }
}
