
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';


class HeaderofVisitorRoom extends StatelessWidget {
  const HeaderofVisitorRoom({required this.numberOfVistor, Key? key})
      : super(key: key);
  final int numberOfVistor;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
        child: Row(
          children: [
            const Spacer(
              flex: 8,
            ),
            Text(
              '$numberOfVistor',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(StringManager.pepoleOnline.tr(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    )),
            const Spacer(
              flex: 8,
            ),
            // const Icon(
            //   CupertinoIcons.search,
            //   color: Colors.black,
            // ),
          ],
        ));
  }
}
