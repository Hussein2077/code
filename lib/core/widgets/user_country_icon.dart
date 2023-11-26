

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class UserCountryIcon extends StatelessWidget {
  final String country;

  final double? width;

  final double? height;
  final double? fontSize;

  const UserCountryIcon(
      {required this.country,  this.width,  this.height ,this.fontSize,super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: country == ''
          ? const SizedBox()
          : CachedNetworkImage(
        imageUrl: ConstentApi().getImage(
            country
        ),
        width: ConfigSize.defaultSize! * 2.4,
        height: ConfigSize.defaultSize! * 2.4,
      ),
    );
  }
}