import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';


class MomentInfoRow extends StatelessWidget {
  final MomentModel momentModel;
  const MomentInfoRow(
      {
      required this.momentModel,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () {

            Methods().userProfileNvgator(
                context: context, userId: momentModel.userId.toString());
          },
      child: Container(
        width: ConfigSize.screenWidth,
        height: ConfigSize.defaultSize!*3,
        padding:
            EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 0.5),
        child:

        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             const Spacer(flex: 1,),
                UserImage(
                  boxFit: BoxFit.cover,
                  image: momentModel.userImage,
                ),
                const Spacer(flex: 1,),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: ConfigSize.defaultSize! * 20,
                      child:
                      Row(


                        children: [
                          SizedBox(width: ConfigSize.defaultSize!*0.5,),
                          GradientTextVip(
                            text: momentModel.userName,
                            textStyle: Theme.of(context).textTheme.bodyLarge!,
                            isVip: momentModel.hasColorName,
                          ),
                          SizedBox(width: ConfigSize.defaultSize!*0.5,),

                          Text(
                            "ID ${momentModel.uuid.toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                fontSize:
                                ConfigSize.defaultSize! * 1.1),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(
                      width: ConfigSize.defaultSize! * 20,
                      child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              LevelContainer(
                                image: momentModel.receiverImage,
                              ),
                              LevelContainer(
                                image: momentModel.senderImage,
                              ),

                            ],
                          ),
                    ),


                  ],
                ),

                const Spacer(flex: 5,),


              ],
            ),

          ],
        ),
      ),
    );
  }
}
