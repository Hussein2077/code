import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/component/linking_screen/linking_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/widget/log_out_button.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
           HeaderWithOnlyTitle(title: StringManager.settings.tr()),
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          settingsRow(
            context: context,
            icon: AssetsPath.linkingIcon,
            title: StringManager.linkingAccount.tr(),
            onTap: () =>
                bottomDailog(context: context, widget:  LinkingScreen()),
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          settingsRow(
            context: context,
            icon: AssetsPath.languageIcon,
            title: StringManager.language.tr(),
            onTap: () => Navigator.pushNamed(context, Routes.language),
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          settingsRow(
            context: context,
            icon: AssetsPath.modeIcon,
            title: StringManager.mode.tr(),
            onTap: () async{
              String theme = await Methods().returnThemeStatus();
              Navigator.pushNamed(context, Routes.mode,arguments:theme );
            },
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
             settingsRow(
            context: context,
            icon: AssetsPath.roomlocked,
            size: 3.3,
            title: StringManager.privacy.tr(),
            onTap: () => Navigator.pushNamed(
                    context, Routes.privacySettings,
                    arguments: MyDataModel.getInstance()),
          ),
          const Spacer(
            flex: 5,
          ),
          // BlocConsumer<LogOutBloc, LogOutState>(
          //   listener: (context, state) async{
          //     if(state is LogOutSucssesState) {
          //           await FirebaseAuth.instance.signOut();
          //           Methods().clearAuth();
          //
          //
          //       // ignore: use_build_context_synchronously
          //       Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
          //     }else if (state is LogOutErrorState){
          //       errorToast(context: context, title: state.error);
          //     }
          //   },
          //   builder: (context, state) {
          //     return MainButton(onTap: () {
          //       BlocProvider.of<LogOutBloc>(context).add(LogOutEvent());
          //     }, title: StringManager.logOut.tr());
          //   },
          // ),
          LogOutOrDeleteAccountButton(logOut: true,
            text: StringManager.logOut.tr(),

            image: const Icon(Icons.delete_forever,color: Colors.red,),

          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 1.6,
          ),

            LogOutOrDeleteAccountButton(logOut: false,
            text: StringManager.deleteAccount.tr(),
            image: const Icon(Icons.delete_forever,color: Colors.red,),
          ),

          const Spacer(),


        ],
      ),
    );
  }
}

Widget settingsRow(
    {required BuildContext context,
    required String icon,
    required String title,
     double? size,
    void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        Image.asset(
          icon,
          scale:size?? 2,
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
        Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.primary,
          size: ConfigSize.defaultSize! * 2,
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    ),
  );
}
