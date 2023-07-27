import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';

class GiftGallery extends StatelessWidget {
  const GiftGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 3),
            color: Theme.of(context).colorScheme.background,
            width: MediaQuery.of(context).size.width,
            height: ConfigSize.defaultSize! * 9,
            child: const HeaderWithOnlyTitle(title: StringManager.giftGallery),
          ),
          Expanded(
            child: GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.1, crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(
                          left: ConfigSize.defaultSize!,
                          right: ConfigSize.defaultSize!,
                          bottom: ConfigSize.defaultSize!),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          ConfigSize.defaultSize!,
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Column(
                        children: [
                          const Spacer(
                            flex: 1,
                          ),
                          Image.asset(
                            AssetsPath.testImage,
                            scale: 30,
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Text(
                            " 2 x",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ));
                }),
          )
        ],
      ),
    );
  }
}
