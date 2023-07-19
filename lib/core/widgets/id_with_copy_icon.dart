

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class IdWithCopyIcon extends StatelessWidget {
  const IdWithCopyIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return    InkWell(
                            onTap: (){
                              Clipboard.setData(const ClipboardData(text:"123456"));
                            

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Text(
                                  'ID: ${123456}',
                                  style:
                                  TextStyle(color: ColorManager.orang , fontSize: ConfigSize.defaultSize!*1.7)
                                ),
                                SizedBox(width: ConfigSize.defaultSize,),
                               
                                Icon(Icons.copy,size: ConfigSize.defaultSize!*1.8, color: ColorManager.orang,)

                              ],
                            ),
                          );
  }
}