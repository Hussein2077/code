import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';

class LinkingScreen extends StatelessWidget {
  const LinkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AssetsPath.lowProtected,
                scale: 1.5,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: "${StringManager.protectionLevel} : ",
                        style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(
                        text: StringManager.low,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: ConfigSize.defaultSize! * 1.8)),
                  ],
                ),
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 3.5,
              ),
              linkingRow(
                context: context,
                icon: AssetsPath.phoneIcon,
                title: StringManager.phoneNum,
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 3.5,
              ),
       
              linkingRow(
                  context: context,
                  icon: AssetsPath.googleIcon,
                  title: StringManager.google),
            ],
          ),
        ),
      ),
    );
  }
}

Widget linkingRow(
    {required BuildContext context,
    required String icon,
    required String title,
    void Function()? onTap}) {
  return Row(
    children: [
      const Spacer(
        flex: 1,
      ),
      Image.asset(
        icon,
        scale: 2,
      ),
      const Spacer(
        flex: 1,
      ),
      Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const Spacer(
        flex: 15,
      ),
      MainButton(
        onTap: () {},
        title: StringManager.link,
        width: ConfigSize.defaultSize! * 7,
        height: ConfigSize.defaultSize! * 3,
        titleSize: ConfigSize.defaultSize! * 1.6,
      ),
      const Spacer(
        flex: 1,
      ),
    ],
  );
}
