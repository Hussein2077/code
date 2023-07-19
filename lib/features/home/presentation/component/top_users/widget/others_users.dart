import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';

class OthersUsers extends StatelessWidget {
  const OthersUsers({super.key});

  @override
  Widget build(BuildContext context) {
        Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: ConfigSize.defaultSize!,
            ),
            height: ConfigSize.defaultSize! * 10,
            decoration: BoxDecoration(
                color:isDarkTheme?Colors.black: ColorManager.whiteColor,
                borderRadius: index == 0
                    ? BorderRadius.only(
                        topLeft: Radius.circular(ConfigSize.defaultSize! * 2),
                        topRight: Radius.circular(ConfigSize.defaultSize! * 2))
                    : null),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               Row(children: [
            const    Spacer(flex: 1,),
              Text(
                "${index + 4}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
                          const    Spacer(flex: 1,),

              Container(
                width: ConfigSize.defaultSize! * 4,
                height: ConfigSize.defaultSize! * 4,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(AssetsPath.testImage),
                        fit: BoxFit.fill)),
              ),
                          const    Spacer(flex: 1,),

              Text(
                "اسمينا الحمودي",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
                          const    Spacer(flex: 20,),

              Text(
                "1.4 M",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
                          const    Spacer(flex: 1,),

            ]),
            CustomHorizntalDvider(width: MediaQuery.of(context).size.width-100,color: Colors.black.withOpacity(0.1),)
            ],)
          );
        });
  }
}
