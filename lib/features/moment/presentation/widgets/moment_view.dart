import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/see_more_text.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

class MomentView extends StatelessWidget {
  final MomentModel momentModel;
  const MomentView({super.key, required this.momentModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ConfigSize.defaultSize! * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onLongPress: () {
              Clipboard.setData(ClipboardData(
                text: momentModel.moment,
              ));
              sucssesToast(
                  context: context,
                  title: StringManager.copiedToClipboard.tr());
            },
            child: (momentModel.moment.length <= 1500)
                ? Align(
                    alignment:isFirstCharArabic(momentModel.moment)?  Alignment.centerRight:Alignment.centerLeft,
                    child: ExpandableText(
                      textAlign: isFirstCharArabic(momentModel.moment)? TextAlign.right:TextAlign.left,
                      momentModel.moment,
                      trimLines: 3,
                    ),
                  )
                : Align(
                    alignment: isFirstCharArabic(momentModel.moment)?  Alignment.centerRight:Alignment.centerLeft,
                    child: ExpandableText(
                      textAlign: isFirstCharArabic(momentModel.moment)? TextAlign.right:TextAlign.left,
                      momentModel.moment,
                      trimLines: 3,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      ConfigSize.defaultSize! * 5),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              content: SizedBox(
                                height: ConfigSize.screenHeight! * 0.6,
                                width: ConfigSize.screenWidth! * 0.7,
                                child: SingleChildScrollView(
                                  child: InkWell(
                                    onLongPress: () {
                                      Clipboard.setData(ClipboardData(
                                        text: momentModel.moment,
                                      ));
                                      sucssesToast(
                                          context: context,
                                          title: StringManager.copiedToClipboard.tr());
                                    },

                                    child: Text(
                                      overflow: TextOverflow.fade,
                                      momentModel.moment,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
          ),
          if (momentModel.momentImage != '')
            Column(
              children: [
                SizedBox(
                  height: ConfigSize.defaultSize! * 1.2,
                ),
                InkWell(
                  onTap: () {
                    showImageViewer(
                        context,
                        CachedNetworkImageProvider(
                          ConstentApi().getImage(momentModel.momentImage),
                        ),
                        swipeDismissible: false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize! * 2),
                    ),

                    child: CachedNetworkImage(imageUrl: ConstentApi().getImage(momentModel.momentImage),),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}



bool isFirstCharArabic(String text) {
  log(text);
  if(text.isEmpty){
    return false ;
  }
  final firstChar = text.isNotEmpty ? text[0] : '';


  // Arabic Unicode character ranges
  final arabicRangeStart = 0x0600;
  final arabicRangeEnd = 0x06FF;

  // // English Unicode character ranges
  // final englishRangeStart = 0x0041;
  // final englishRangeEnd = 0x007A;

  final firstCharCode = firstChar.runes.first;
  bool result = (firstCharCode >= arabicRangeStart && firstCharCode <= arabicRangeEnd) ;
  return result ;
}
