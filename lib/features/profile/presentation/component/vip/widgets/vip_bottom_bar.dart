import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/pop_up_dialog.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/manger_buy_send_vip/bloc/buy_or_send_vip_bloc.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/manger_buy_send_vip/bloc/buy_or_send_vip_event.dart';

class VipBottomBar extends StatelessWidget {
  final String price;
  final String expire;
  final String id;
  final String name;
  final String vipBadge;
  const VipBottomBar(
      {required this.vipBadge,
      required this.name,
      required this.expire,
      required this.id,
      required this.price,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 2),
      width: MediaQuery.of(context).size.width,
      height: ConfigSize.defaultSize! * 7,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: price,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 236, 172, 51),
                        fontSize: ConfigSize.defaultSize! * 1.6)),
                TextSpan(
                    text:
                        ' ${StringManager.coins} / $expire ${StringManager.day}',
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
          MainButton(
            width: ConfigSize.defaultSize! * 7,
            height: ConfigSize.defaultSize! * 3,
            onTap: () {
              // bottomDailog(context: context, widget: widget)
            },
            title: StringManager.send,
            buttonColor: ColorManager.bageGriedinet,
          ),
          MainButton(
            width: ConfigSize.defaultSize! * 7,
            height: ConfigSize.defaultSize! * 3,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return PopUpDialog(
                        accpetText: () {
                          BlocProvider.of<BuyOrSendVipBloc>(context).add(BuyOrSendVipEvent(
                            type: "0", 
                            vipId: id,
                            toUId: "0"
                          ));
                          Navigator.pop(context);
                        },
                        headerText: name,
                        widget: Image.asset(
                          vipBadge,
                          scale: 5,
                        ));
                  });
            },
            title: StringManager.buy,
          )
        ],
      ),
    );
  }
}
