import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/room_type_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/enter_room_pass/enter_password_dialog_room.dart';

import '../../num_of_vistor.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';

class VideoLiveBox extends StatelessWidget {
  final RoomModelOfAll room;
  final int style;
  const VideoLiveBox({required this.room, required this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (room.passwordStatus ?? false) {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  insetPadding: EdgeInsets.symmetric(
                      horizontal: ConfigSize.defaultSize! * 5),
                  backgroundColor: Colors.transparent,
                  child: EnterPasswordRoomDialog(
                    myData: MyDataModel.getInstance(),
                    ownerId: room.ownerId.toString(),
                  ),
                );
              });
        } else {
          Navigator.pushNamed(context, Routes.roomHandler,
              arguments: RoomHandlerPramiter(
                  ownerRoomId: room.ownerId.toString(),
                  myDataModel: MyDataModel.getInstance()));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: ConfigSize.defaultSize! * 18,
              height: ConfigSize.defaultSize! * 14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(
                        ConstentApi().getImage(room.cover))),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: ConfigSize.defaultSize,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: ConfigSize.defaultSize!,
                      ),
                      Text(room.country!,style: const TextStyle(
                          fontSize: 17
                      )),
                    /*  CachedNetworkImage(
                        imageUrl: ConstentApi().getImage(room.country),
                        width: ConfigSize.defaultSize!*2.4,
                        height: ConfigSize.defaultSize!*2.4,
                      ),*/
                      SizedBox(
                        width: ConfigSize.defaultSize!,
                      ),
                      RoomTypeWidget(
                        style: style,
                        type: room.type!.name,
                      ),
                      SizedBox(
                        width: ConfigSize.defaultSize,
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ConfigSize.defaultSize! * 6,
                          left: ConfigSize.defaultSize! * 12),
                      child:  NumVistor(numOfVistor: room.visitorsCount.toString(),))
                ],
              )),
          Text(
            room.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            room.roomIntro!,
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      ),
    );
  }
}
