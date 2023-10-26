
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_theme/theme_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_theme/theme_event.dart';


class ModeScreen extends StatefulWidget {
   int selectedMode=2;

   ModeScreen({ super.key, required this.select});
  String select;

  @override
  State<ModeScreen> createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  List<String> mode = [StringManager.lightMode.tr(), StringManager.darkMode.tr()];

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.select=='dark'){

        widget.selectedMode=1;

    }if (widget.select=='light'){

      widget.selectedMode=0;

    }
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

                        if (widget.selectedMode!=index)
                     {
                       setState(() {
                        //  final themeCubit = BlocProvider.of<ThemeCubit>(context);

                         widget.selectedMode = index;
                        //  themeCubit.toggleTheme(widget.selectedMode);

                       });
                     }
                      },
                    );
                  })),
          MainButton(
            onTap: ()async {

              if(widget.selectedMode==0){
                Methods.instance.saveThemeStatus(theme: "light");
                BlocProvider.of<ThemeBloc>(context).add(const ChangeThemeEvent(type:"light"));
                Navigator.pop(context);
              }else {
                                Navigator.pop(context);

                Methods.instance.saveThemeStatus(theme: "dark");
                                BlocProvider.of<ThemeBloc>(context).add(const ChangeThemeEvent(type:"dark"));


              }





            },
            title: StringManager.save.tr(),
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 5.5,
          ),
        ],
      ),
    );
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
                color: widget.selectedMode == index
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
}


