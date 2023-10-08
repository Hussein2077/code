
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_buy_manager/mall_buy_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_buy_manager/mall_buy_event.dart';

import '../../../../../../core/widgets/pop_up_dialog.dart';

class MallCard extends StatelessWidget {
  final String name;
  final String price;
  final String time;
  final String id;
  final String image;
  final  void Function() onTapTest;
  const MallCard(
      {required this.image,
      required this.id,
      required this.name,
      required this.price,
      required this.time,
      super.key, required this.onTapTest});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: ConfigSize.defaultSize!,
          right: ConfigSize.defaultSize!,
          bottom: ConfigSize.defaultSize! * 1.2),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
      child: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize!,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(
            height: ConfigSize.defaultSize!,
          ),
          CustoumCachedImage(
            height: ConfigSize.defaultSize! * 7,
            width: ConfigSize.defaultSize! * 7,
            url: image,
            radius: ConfigSize.defaultSize!,
          ),
          SizedBox(
            height: ConfigSize.defaultSize!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                   Image.asset(
                AssetsPath.goldCoinIcon,
                scale: 10,
              ),
              Text(
                " $price / $time ${StringManager.day.tr()} ",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: ConfigSize.defaultSize! * 1.2,
                ),
              ),
         
            ],
          ),
          SizedBox(
            height: ConfigSize.defaultSize!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainButton(
                title: StringManager.buy,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return PopUpDialog(
                          accpettitle: StringManager.buy.tr(),
                            accpetText: () {
                              BlocProvider.of<MallBuyBloc>(context).add(BuyItemEvent(idItem: id, quantity: "1"));
                              Navigator.pop(context);
                            },
                            headerText: StringManager.youWillBuy.tr(),
                            widget: CustoumCachedImage(
                              height: ConfigSize.defaultSize! * 7,
                              width: ConfigSize.defaultSize! * 7,
                              url: image,
                            ));
                      });
                },
                width: ConfigSize.defaultSize! * 7,
                height: ConfigSize.defaultSize! * 2,
                titleSize: ConfigSize.defaultSize! * 1.4,
              ),

              MainButton(
                title: StringManager.test,
                onTap: onTapTest,

                width: ConfigSize.defaultSize! * 7,
                height: ConfigSize.defaultSize! * 2,
                titleSize: ConfigSize.defaultSize! * 1.4,
              ),
            ],
          )
        ],
      ),
    );
  }
}
