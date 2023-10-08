import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class UserAvatar extends StatelessWidget {
  String image;
  bool isMicrophoneEnabled;
  UserAvatar({super.key, required this.image, required this.isMicrophoneEnabled});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: ConstentApi().getImage(image),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
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
          errorWidget: (context, url, error) => const Icon(Icons.error),
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
