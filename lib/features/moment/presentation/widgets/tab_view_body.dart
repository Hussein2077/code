import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_chat_v2/core/service/dynamic_link.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_appbar.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_bottom_bar.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_view.dart';


class TabViewBody extends StatelessWidget {
 final List<MomentModel> momentModelList;
 final ScrollController scrollController;
 final bool? isFromUserProfile;

  const TabViewBody({Key? key,
    required this.scrollController,
    required this.momentModelList,
  this.isFromUserProfile
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: ConfigSize.screenWidth,
      height: isFromUserProfile==true?ConfigSize.screenHeight!*0.5:ConfigSize.screenHeight!*0.84,
      padding: EdgeInsets.symmetric(
          horizontal: ConfigSize.defaultSize! * 0.2),
      child: ListView.builder(
        controller: scrollController,
        itemCount: momentModelList.length,
        itemBuilder: (context, i) {

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Column(
                  children: [
                    MomentAppBar(
                      momentModel: momentModelList[i],
                    ),
                    MomentView(
                      momentModel: momentModelList[i],
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 1.5,
                    ),
                    MomentBottomBar(
                      momentModel: momentModelList[i],
                        isFromUserProfile:isFromUserProfile
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 1.5,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
