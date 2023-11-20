import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';

import '../../../../../../../core/utils/config_size.dart';



class ChatWidget extends StatelessWidget {
  final String img;
  final String title;
  final String content;
  final String creadet;
  const ChatWidget(
      {required this.creadet,
      required this.title,
      required this.content,
      required this.img,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: ConfigSize.screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: ColorManager.lightGray,
                    width: 1 // red as border color
                    ),


            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(img!='')


                InkWell(
                  onTap: (){
                    showImageViewer(
                        context,
                        CachedNetworkImageProvider(
                          ConstentApi().getImage(img),
                        ),
                        swipeDismissible: false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: ColorManager.lightGray,
                            width: 1 // red as border color
                        )),
                    child: CustoumCachedImage(
                      url: img,
                      height: ConfigSize.defaultSize! * 18,
                      width: double.maxFinite,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title.toString(),style: Theme.of(context).textTheme.headlineLarge,),
                      Text(content,style: Theme.of(context).textTheme.bodyMedium,overflow:TextOverflow.fade ,)],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              Methods.instance.formatDateTime(
                  dateTime: creadet,
                  locale: context.locale.languageCode),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(
                  fontSize: ConfigSize.defaultSize! ),
            ),
          )
        ],
      ),
    );
  }
}
