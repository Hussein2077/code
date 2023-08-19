import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';

class LowerBody extends StatelessWidget {
  const LowerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ConfigSize.defaultSize! * 3),
                topRight: Radius.circular(ConfigSize.defaultSize! * 3))),
        child: Column(
          children: [
            Text(
              StringManager.levelMissions.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            CustomHorizntalDvider(
              width: ConfigSize.defaultSize! * 5,
              color: Colors.orange,
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemExtent: 100,
            //     itemCount: 10,
            //     itemBuilder: (context, index) {
            //     return Column(
            //       children: [
            //         Row(
                      
            //           children: [
            //             const Spacer(flex: 1,),
            //             Image.asset(
            //               AssetsPath.testImage,
            //               scale: 25,
            //             ),
            //                                     const Spacer(flex: 1,),

            //             Column(
            //               children: [
            //                 Text(
            //                   "دخول الحمود",
            //                   style: Theme.of(context).textTheme.headlineMedium,
            //                 ),
            //                 Text(
            //                   "هتكسب حب الناس",
            //                   style: Theme.of(context).textTheme.titleMedium,
            //                 ),
            //               ],
            //             ),
            //                                     const Spacer(flex:20,),

            //             Icon(Icons.arrow_forward_ios , color: Theme.of(context).colorScheme.primary, size: ConfigSize.defaultSize!*1.8,),
            //                                     const Spacer(flex: 1,),

            //           ],
            //         )
            //       ],
            //     );
            //   }),
            // )
const Spacer(),
            Center(child: Text(StringManager.comingSoon , style: Theme.of(context).textTheme.headlineLarge),),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
