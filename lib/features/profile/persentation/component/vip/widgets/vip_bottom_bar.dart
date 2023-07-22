import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';

class VipBottomBar extends StatelessWidget {
  const VipBottomBar({super.key});

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
                    text: '160.000 ',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 236, 172, 51),
                        fontSize: ConfigSize.defaultSize! * 1.6)),
                TextSpan(
                    text: '${StringManager.coins} / 30 ${StringManager.day}',
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
          MainButton(
            width: ConfigSize.defaultSize! * 7,
            height: ConfigSize.defaultSize! * 3,
            onTap: () {},
            title: StringManager.send,
            buttonColor: ColorManager.bageGriedinet,
          ),
          MainButton(
            width: ConfigSize.defaultSize! * 7,
            height: ConfigSize.defaultSize! * 3,
            onTap: () {},
            title: StringManager.buy,
          )
        ],
      ),
    );
  }
}
