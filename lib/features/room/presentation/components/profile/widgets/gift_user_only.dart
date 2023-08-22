

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/buttons/gifts/widgets/gift_users.dart';

class GiftUserOnly extends StatefulWidget {
  final String userId;
  final String ownerId;
  const GiftUserOnly({required this.userId, required this.ownerId, super.key});
  static String userSelected = "";
  @override
  GiftUserOnlyState createState() => GiftUserOnlyState();
}

class GiftUserOnlyState extends State<GiftUserOnly> {
  int selectUserIndex = 0;

  @override
  void initState() {
    GiftUserOnly.userSelected = widget.userId;
    GiftUser.userSelected.putIfAbsent(
        0, () => SelecteObject(userId: widget.userId, selected: true));
    super.initState();
  }

  @override
  void dispose() {
    GiftUser.userSelected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ConfigSize.screenWidth,
      child: Container(
        padding: EdgeInsets.only(top: ConfigSize.defaultSize!),
        height: ConfigSize.defaultSize! * 7,
        width: ConfigSize.screenWidth! - 50,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    if (GiftUser.userSelected.containsKey(index)) {
                      GiftUser.userSelected.remove(index);
                    } else {
                      GiftUser.userSelected.putIfAbsent(
                          index,
                          () => SelecteObject(
                              userId: widget.userId, selected: true));
                    }
                  });
                },
                child: Stack(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(3),
                        width: ConfigSize.defaultSize! * 4,
                        height: ConfigSize.defaultSize! * 4,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: GiftUser.userSelected.containsKey(index)
                                ? ColorManager.mainColor
                                : Colors.transparent, // red as border color
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                            child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(ConstentApi().getImage(
                                    RoomScreen.usersInRoom[widget.userId]!
                                        .profile!.image))))),
                    if (RoomScreen.adminsInRoom.containsKey(widget.userId))
                      Positioned(
                        top: ConfigSize.defaultSize! * 3,
                        left: ConfigSize.defaultSize! * 1.3,
                        child: SizedBox(
                            width: ConfigSize.defaultSize! * 2,
                            height: ConfigSize.defaultSize! * 1.5,
                            child: Image.asset(AssetsPath.adminMark)),
                      ),
                    if (widget.userId == widget.ownerId.toString())
                      Positioned(
                        top: ConfigSize.defaultSize! * 3,
                        left: ConfigSize.defaultSize! * 1.3,
                        child: SizedBox(
                            width: ConfigSize.defaultSize! * 2,
                            height: ConfigSize.defaultSize! * 1.5,
                            child: Image.asset(AssetsPath.hostMark)),
                      ),
                    if (widget.userId != widget.ownerId.toString() &&
                        !RoomScreen.adminsInRoom.containsKey(widget.userId))
                      Positioned(
                        top: ConfigSize.defaultSize! * 3,
                        left: ConfigSize.defaultSize! * 1.3,
                        child: Container(
                            width: ConfigSize.defaultSize! * 2,
                            height: ConfigSize.defaultSize! * 1.5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.whiteColor),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(fontSize: ConfigSize.defaultSize!-3),
                              ),
                            )),
                      )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
