import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';

import '../../../../../../core/widgets/user_image.dart';

class FamilyInfoRow extends StatelessWidget {
  final String image ;
  final String name ; 
  final String intro ; 
  const FamilyInfoRow({required this.image , required this.intro , required this.name ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: ConfigSize.defaultSize,
            ),
            UserImage(
              image: image,
              imageSize: ConfigSize.defaultSize! * 5,
            ),
            SizedBox(
              width: ConfigSize.defaultSize,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                // Row(
                //   children: const [
                //     UserCountryIcon(country: ""),
                //     CustomIcon(
                //       color: ColorManager.deepBlue,
                //       icon: AssetsPath.groupIcon,
                //       title: "18",
                //     )
                //   ],
                // ),
                Text(
                  intro,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.primary,
              size: ConfigSize.defaultSize! * 2,
            ),
            SizedBox(
              width: ConfigSize.defaultSize,
            )
          ],
        ),
        CustomHorizntalDvider(
          width: MediaQuery.of(context).size.width - 50,
          color: ColorManager.lightGray,
        )
      ],
    );
  }
}
