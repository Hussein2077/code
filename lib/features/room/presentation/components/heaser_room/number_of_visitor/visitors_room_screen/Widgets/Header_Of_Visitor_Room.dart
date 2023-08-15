
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';


class HeaderofVisitorRoom extends StatelessWidget {
  HeaderofVisitorRoom({required this.numberOfVistor, Key? key}) : super(key: key);
  final int numberOfVistor;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
        child: Row(
          children: [
             const Spacer(
              flex:4,
            ),
            Text(
              "$numberOfVistor ${StringManager.pepoleOnline.tr()}",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
             const Spacer(
              flex: 3,
            ),
            // const Icon(
            //   CupertinoIcons.search,
            //   color: Colors.black,
            // ),
             const Spacer(
              flex: 1,
            ),
          ],
        ));
  }
}
