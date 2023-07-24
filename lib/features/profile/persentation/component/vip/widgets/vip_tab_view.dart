import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';

class VipTabView extends StatelessWidget {
  final String vipIcon;
  const VipTabView({required this.vipIcon, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          vipIcon,
          scale: 2.5,
        ),
              SizedBox(height: ConfigSize.defaultSize!*3,),

        Text(
          StringManager.buyToEnjoy,
          style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: ConfigSize.defaultSize! * 1.7),
        ),
                      SizedBox(height: ConfigSize.defaultSize!*3,),

        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ConfigSize.defaultSize! * 4),
                    topRight: Radius.circular(ConfigSize.defaultSize! * 4))),
            child: Column(
              children: [
                              SizedBox(height: ConfigSize.defaultSize!*2,),


                Text(
                  StringManager.advantages,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                CustomHorizntalDvider(
                  width: ConfigSize.defaultSize! * 2,
                  color: ColorManager.orang,
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: 20,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.2),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              width: ConfigSize.defaultSize! * 5,
                              height: ConfigSize.defaultSize! * 5,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(AssetsPath.testImage))),
                            ),
                        SizedBox(height: ConfigSize.defaultSize!,),
                            Text("ميزه موت", style: Theme.of(context).textTheme.bodySmall,)
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
