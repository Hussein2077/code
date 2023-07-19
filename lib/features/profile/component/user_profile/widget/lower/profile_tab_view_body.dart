import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';

import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class ProfileTabViewBody extends StatelessWidget {
  const ProfileTabViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cover(
                title: StringManager.dimond,
                num: "12.4 k",
                image: AssetsPath.dimondCover),
            cover(
                title: StringManager.level,
                num: "lvl 12",
                image: AssetsPath.leveCover),
            cover(
                title: StringManager.vip,
                num: "vip. 7",
                image: AssetsPath.vipCover),
          ],
        ),
        SizedBox(
          height: ConfigSize.defaultSize! * 2,
        ),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, Routes.giftGallery);
          },
          child: Row(
            children: [
              const Spacer(
                flex: 1,
              ),
              Text(
                StringManager.giftGallery,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(
                flex: 15,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.primary,
                size: ConfigSize.defaultSize! * 1.5,
              ),
              const Spacer(
                flex: 1,
              )
            ],
          ),
        ),
        SizedBox(
          height: ConfigSize.defaultSize! * 2,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: ConfigSize.defaultSize! * 10,
                      height: ConfigSize.defaultSize! * 10,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AssetsPath.testImage))),
                    ),
                    Text(
                      "2 x",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                );
              }),
        )
      ],
    );
  }
}

Widget cover(
    {required String title, required String num, required String image}) {
  return Container(
    padding: EdgeInsets.only(
        top: ConfigSize.defaultSize!, right: ConfigSize.defaultSize!),
    width: ConfigSize.defaultSize! * 13,
    height: ConfigSize.defaultSize! * 7,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: ConfigSize.defaultSize! * 1.4,
              fontWeight: FontWeight.bold),
        ),
        Text(
          num,
          style: TextStyle(
              color: Colors.white,
              fontSize: ConfigSize.defaultSize! * 1.4,
              fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
