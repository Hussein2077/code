
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
 
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/Gift_Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/anonymous_dialog_gifts.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';



class GiftButton extends StatelessWidget {
  const GiftButton({required this.myDataModel,
    required this.listAllUsers ,
    required this.roomData, super.key});
  final MyDataModel myDataModel;
  final List<ZegoUIKitUser>  listAllUsers ;
  final EnterRoomModel? roomData ;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: ()  {

        myDataModel.id.toString()!='0'?
        bottomDailog(
            context: context,
            widget: GiftScreen(
              listAllUsers:listAllUsers,
              roomData:roomData!,
              myDataModel: myDataModel,
              isSingleUser: false,
              userId: null,
              userImage: null,
            )):
        showDialog(  context: context, builder: (BuildContext context) { return AnonymounsDialogGifts(); })
        ;
      },
      child:  Image(
          width:  ConfigSize.defaultSize!*5.7,
            height: ConfigSize.defaultSize!*6.9,
            image: const  AssetImage(AssetsPath.giftbox),
          ),
    );
  }
}
