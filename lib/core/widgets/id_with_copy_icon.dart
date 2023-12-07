// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variable
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';

class IdWithCopyIcon extends StatefulWidget {
  var userData;
  Color? color;
  MainAxisAlignment? mainAxisAlignment;
  IdWithCopyIcon({required this.userData,this.color, super.key,this.mainAxisAlignment});

  @override
  State<IdWithCopyIcon> createState() => _IdWithCopyIconState();
}

class _IdWithCopyIconState extends State<IdWithCopyIcon> {
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: widget.userData.uuid.toString()));
        sucssesToast(
            context: context, title: StringManager.theTextHasBeenCopied.tr());
      },
      child: Row(
        mainAxisAlignment:widget.mainAxisAlignment?? MainAxisAlignment.center,
        children: [
          widget.userData.imageIdModel==null||widget.userData.imageIdModel?.image==""?

          SizedBox(
            width: ConfigSize.defaultSize,
          ):
          Image(image: CachedNetworkImageProvider(
              scale: 7,
              ConstentApi().getImage(widget.userData.imageIdModel?.image??'')),
          ),

          widget.userData.imageIdModel==null||widget.userData.imageIdModel?.color==''?
          Text(
            'ID: ${widget.userData.uuid.toString()}',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: ConfigSize.defaultSize!*1.6
            ),
          ):
          Text(
            'ID: ${widget.userData.uuid.toString()}',
            style: TextStyle(
              color:HexColor(widget.userData.imageIdModel?.color),
              fontSize: ConfigSize.defaultSize! * 1.9,
            ),
          ),

          SizedBox(
            width: ConfigSize.defaultSize,
          ),
          Icon(
            Icons.copy,
            size: ConfigSize.defaultSize! * 1.8,
            color: widget.userData.isGold!
                ? ColorManager.shimmerGold1
                : ColorManager.orang,
          )
        ],
      ),
    );
  }
}
