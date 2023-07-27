import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';

import 'widget/add_voice_live_pic.dart';
import 'widget/public_privite_button.dart';
import 'widget/room_type_button.dart';

class CreateVoiceLiveBody extends StatefulWidget {
  
  const CreateVoiceLiveBody({super.key});

  @override
  State<CreateVoiceLiveBody> createState() => _CreateVoiceLiveBodyState();
}

class _CreateVoiceLiveBodyState extends State<CreateVoiceLiveBody> {
  late TextEditingController voicNameController ;
  @override
  void initState() {
    voicNameController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenBackGround(
        image: AssetsPath.createVoicBackGround,
        child: Column(
          children: [
            SizedBox(
              height: ConfigSize.defaultSize! * 4,
            ),
            header(context: context),
             SizedBox(
              height: ConfigSize.defaultSize! * 4,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: ConfigSize.defaultSize! * 10,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ConfigSize.defaultSize! * 1.2),
                  color: Colors.white.withOpacity(0.2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    const AddVoiceLivePic(),
                    SizedBox(width: ConfigSize.defaultSize!*20, child: TextFieldWidget( textColor: Colors.white, controller:voicNameController,hintText: StringManager.roomName, )),
                    Icon(Icons.edit, color: Colors.white, size: ConfigSize.defaultSize!*2,)
                  ],),
            ) , 
             SizedBox(
              height: ConfigSize.defaultSize! * 2,
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:const [ 
              
                         PublicPriveteButton(),
            RoomTypeButton()
],),
 SizedBox(
              height: ConfigSize.defaultSize! * 4,
            ),

Image.asset(AssetsPath.seatsImage),
 SizedBox(
              height: ConfigSize.defaultSize! * 10,
            ),

MainButton(onTap: () {
  
},title: StringManager.createRoom,)
          ],
        ));
  }
}

Widget header({required BuildContext context}) {
  return Row(
    children: [
      SizedBox(
        width: ConfigSize.defaultSize,
      ),
      Container(
        padding: EdgeInsets.all(ConfigSize.defaultSize! - 3),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.white.withOpacity(0.5)),
        child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: ConfigSize.defaultSize! * 2,
            )),
      ),
      SizedBox(
        width: ConfigSize.defaultSize!,
      ),
      Text(
        StringManager.createVoice,
        style: TextStyle(
            color: Colors.white, fontSize: ConfigSize.defaultSize! * 2),
      )
    ],
  );
}
