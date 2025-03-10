import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room_audio/data/data_sorce/remotly_data_source_room.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class UserAvatar extends StatelessWidget {
  final String? image;
  final bool isMicrophoneEnabled;
  final ZegoUIKitUser? user;

  UserAvatar({
    super.key,
    this.user,
    this.image,
    required this.isMicrophoneEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
            imageUrl: ConstentApi().getImage(image),
            imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
            placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    width: ConfigSize.defaultSize! * 5.7,
                    height: ConfigSize.defaultSize! * 5.7,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            errorWidget: (context, url, error) => FutureBuilder(
                future: RemotlyDataSourceRoom().getUsersInRoon(user!.id),
                builder: (context, snapShot) {
                  if(snapShot.hasData){
                    user?.inRoomAttributes.value['img'] = snapShot.data![0].image;
                    return UserImage(image: snapShot.data![0].image);
                  }else {
                 return  const SizedBox();
                   }

                })
        ),
        if (!isMicrophoneEnabled)
          Positioned(
            bottom: 0,
            left: AppPadding.p4,
            child: Container(
              width: AppPadding.p26,
              height: AppPadding.p26,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage(AssetsPath.muteSeatGreen))),
            ),
          )
      ],
    );
  }
}
