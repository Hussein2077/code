
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/splash.dart';

import '../../../../manager/theme_bloc/theme_bloc.dart';

class ModeScreen extends StatefulWidget {
  static int selectedMode=0;
  const ModeScreen({super.key});

  @override
  State<ModeScreen> createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  List<String> mode = [StringManager.lightMode.tr(), StringManager.darkMode.tr()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
           HeaderWithOnlyTitle(title: StringManager.mode.tr()),
          Expanded(
              child: ListView.builder(
                  itemCount: mode.length,
                  itemExtent: 50,
                  itemBuilder: (context, index) {
                    return modeRow(
                      context: context,
                      index: index,
                      mode: mode[index],
                      onTap: () {
                        if (ModeScreen.selectedMode!=index)
                     {
                       setState(() {
                         final themeCubit = BlocProvider.of<ThemeCubit>(context);

                         ModeScreen.selectedMode = index;
                         themeCubit.toggleTheme(ModeScreen.selectedMode);

                       });
                     }
                      },
                    );
                  })),
          MainButton(
            onTap: ()async {

              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt('mode', ModeScreen.selectedMode);
              int? mode = prefs.getInt('mode');
              if(mode==0){
                SplashScreen.isDark = false ;
              }else {
                SplashScreen.isDark = true ;

              }
               // Navigator.pushNamedAndRemoveUntil(context, Routes.splash, (route) => false);

            },
            title: StringManager.save.tr(),
          )
        ],
      ),
    );
  }
}

Widget modeRow(
    {required BuildContext context,
    required String mode,
    required int index,
    void Function()? onTap}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          mode,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: ConfigSize.defaultSize! * 3,
            height: ConfigSize.defaultSize! * 3,
            decoration: BoxDecoration(
                color: ModeScreen.selectedMode == index
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
