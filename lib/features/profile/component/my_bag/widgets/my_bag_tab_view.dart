import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';

class MyBagTabView extends StatelessWidget {
  const MyBagTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.2),
        itemCount: 10,
        itemBuilder: (context, index) {
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
                Image.asset(
                  AssetsPath.testImage,
                  scale: 25,
                ),
                Text(
                  "هديه موت",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "14/ايام",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MainButton(
                      title: StringManager.use,
                      onTap: () {},
                      width: ConfigSize.defaultSize! * 7,
                      height: ConfigSize.defaultSize! * 2,
                      titleSize: ConfigSize.defaultSize!*1.4,
                    ),
                        MainButton(
                          buttonColor: ColorManager.bageGriedinet,
                          
                      title: StringManager.send,
                      onTap: () {},
                      width: ConfigSize.defaultSize! * 7,
                      height: ConfigSize.defaultSize! * 2,
                      titleSize: ConfigSize.defaultSize!*1.4,
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
