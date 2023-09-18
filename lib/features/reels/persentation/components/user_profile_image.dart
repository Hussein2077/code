import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import '../../../../core/utils/config_size.dart';

class UserProfileImage extends StatelessWidget {
  final String profileUrl;
  const UserProfileImage({Key? key,required this.profileUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: ConstentApi().getImage(profileUrl),
      alignment: Alignment.centerLeft,
      imageBuilder: (context, imageProvider) => Container(
        height: ConfigSize.defaultSize!*3.2,
        width: ConfigSize.defaultSize!*3.2,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*1.6),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) =>  SizedBox(
        height: ConfigSize.defaultSize!*2,
        width: ConfigSize.defaultSize!*2,
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) =>
       SizedBox(
        height: ConfigSize.defaultSize!*2,
        width: ConfigSize.defaultSize!*2,
        child: const Icon(Icons.error),
      ),
    );
  }
}

