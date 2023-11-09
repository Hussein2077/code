

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';

import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/show_svga.dart';
import 'package:tik_chat_v2/features/profile/domin/entitie/data_mall_entities.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/mall/widget/custom_avatar.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/mall/widget/mall_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/mall/widget/svg_dialog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';

class MallTabView extends StatelessWidget {
    final List<DataMallEntities> dataMall;
  final RequestState stateRequest;
  final String dataMallMessage;
  final String type;
  const MallTabView({required this.dataMall, required this.dataMallMessage , required this.stateRequest, super.key, required this.type});

  @override
  Widget build(BuildContext context) {
   return GridView.builder(
    
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1),
        itemCount: dataMall.length,
        itemBuilder: (context, index) {
          return MallCard(
            image: dataMall[index].image,
            id: dataMall[index].id.toString(),
            name: dataMall[index].name,
            price: dataMall[index].price.toString(),
            time: dataMall[index].expire.toString(), onTapTest: () {

            if (type == "c") {
              SvgDialog(
                context: context,
                widget: Stack(
                  children: [
                    Center(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 100, top: 500),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                MyDataModel.getInstance()
                                    .name
                                    .toString(),
                                style: TextStyle(
                                    color: ColorManager.gold,
                                    fontSize:
                                    ConfigSize.defaultSize! * 1.5),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                StringManager.hasJoin.tr(),

                                style: TextStyle(
                                    color: ColorManager.whiteColor,
                                    fontSize:
                                    ConfigSize.defaultSize! * 1.2),
                              )
                            ],
                          )),
                    ),
                    ShowSVGA(
                      imageId:
                      '${dataMall[index].id}$cacheEntroKey',
                      url: dataMall[index].svg,
                    )
                  ],
                ),
              );
            }
            else if (type == "f")
            {
              SvgDialog(
                context: context,
                widget: Stack(
                  children: [
                    Center(
                      child: CustomAvtare(
                        image: MyDataModel.getInstance().profile!.image.toString(),
                        size: ConfigSize.defaultSize! * 12.9,
                      ),
                    ),
                    Center(
                      child: ShowSVGA(
                        imageId:
                        '${dataMall[index].id}${cacheFrameKey}',
                        url: dataMall[index].svg,
                      ),
                    )
                  ],
                ),
              );
            } else if (type == "b") {
              showDialog(
                  builder: (context) {
                    return Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30),
                          child: Center(
                              child: Image.network(ConstentApi()
                                  .getImage(
                                  dataMall[index].image))),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Text(
                            'Hello',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    );
                  },
                  context: context);
            } else {
              Container();
            }

          },

          );
        });
  }
}