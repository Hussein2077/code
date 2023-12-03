import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Column(
          children: [
            const Spacer(),
            Text(StringManager.unexcepectedError.tr()),
            const SizedBox(height: 25,),
            MainButton(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.login, (route) => false);
                },
                title: StringManager.logOut),
            const Spacer()

          ],
        )),
      ),
    );
  }
}
