import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/splash.dart';

class LanguageScreen extends StatefulWidget {
  static int? selectedLanguage;
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<String> language = [
    StringManager.english,
    StringManager.arabic,
    StringManager.turkish,
    StringManager.urdu,
    StringManager.chinsSimplified,
    StringManager.chinsTraditional,
  ];
  List<String> languageCode = ['en', 'ar', 'tr', 'ur', '汉语', "漢語"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          const HeaderWithOnlyTitle(title: StringManager.language),
          Expanded(
              child: ListView.builder(
                  itemCount: language.length,
                  itemExtent: 50,
                  itemBuilder: (context, index) {
                    return languageRow(
                      context: context,
                      index: index,
                      language: language[index],
                      onTap: () async {
                      

                        setState(() {
                          LanguageScreen.selectedLanguage = index;
                        });
                      },
                    );
                  })),

          MainButton(
            onTap: () async {

              if (LanguageScreen.selectedLanguage != null) {
                await context.setLocale(
                    Locale(languageCode[LanguageScreen.selectedLanguage!]));
                await Methods().saveLocalazitaon(
                    language: languageCode[LanguageScreen.selectedLanguage!]);
              }
              SharedPreferences sharedPreferences = getIt();
              final bool isLogin = await sharedPreferences.getBool(StringManager.keepLogin) ?? false;
              if (isLogin) {
                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const MainView(keepInRoom: null,)),
                //     ModalRoute.withName(Routes.main));
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                         const SafeArea(child: SplashScreen())),
                    ModalRoute.withName(Routes.login));
              }
            },
            title: StringManager.save,
          )
        ],
      ),
    );
  }
}

Widget languageRow(
    {required BuildContext context,
    required String language,
    required int index,
    void Function()? onTap}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          language,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: ConfigSize.defaultSize! * 3,
            height: ConfigSize.defaultSize! * 3,
            decoration: BoxDecoration(
                color: LanguageScreen.selectedLanguage == index
                    ? ColorManager.orang
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey)),
          ),
        )
      ],
    ),
  );
}
