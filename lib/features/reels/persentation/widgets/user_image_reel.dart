
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_controller.dart';

class UserImageReel extends StatelessWidget {
  final double? imageSize;
  final String image;
  final BoxFit? boxFit;
  final Widget? child;
  final bool? isFollowed;
  final int userId;
  final Function(String, bool)? onFollow;
  const UserImageReel(
      {this.child,
      required this.image,
      this.onFollow,
      required this.userId,
      this.isFollowed,
      this.boxFit,
      this.imageSize,
      super.key});

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        SizedBox(
          width: ConfigSize.defaultSize! * 5,
          height: ConfigSize.defaultSize! * 6,
        ),
        InkWell(
          onTap: () {
            Methods.instance.userProfileNvgator(
                context: context, userId: userId.toString());
          },
          child: Container(
            width: imageSize ?? ConfigSize.defaultSize! * 5,
            height: imageSize ?? ConfigSize.defaultSize! * 5,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: image != null ? DecorationImage(
                    fit: boxFit ?? BoxFit.fill,
                    image: CachedNetworkImageProvider(
                        ConstentApi().getImage(image))) : const DecorationImage(
    image: AssetImage(AssetsPath.defaultImage),
    fit: BoxFit.fill)),
            child: child,
          ),
        ),
        ValueListenableBuilder<bool>(
            valueListenable: ReelsController.follow,
            builder: (context, isShow, _) {
              if (ReelsController.followingMap[userId.toString()]==false &&
                  (userId != MyDataModel.getInstance().id)) {
                return Positioned(
                    bottom: 0,
                    right: ConfigSize.defaultSize!,
                    child: InkWell(
                      onTap: () =>
                          onFollow!(userId.toString(), isFollowed ?? false),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        padding: EdgeInsets.all(ConfigSize.defaultSize! * 0.4),
                        child: Icon(
                          CupertinoIcons.add,
                          size: ConfigSize.defaultSize! + 4,
                        ),
                      ),
                    ));
              } else {
                return const SizedBox();
              }
            }),
      ],
    );
  }
}
