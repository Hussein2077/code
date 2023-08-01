import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:tik_chat_v2/features/profile/presentation/component/settings/widget/linking_screen.dart';

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
          const HeaderWithOnlyTitle(title: StringManager.settings),
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          settingsRow(
            context: context,
            icon: AssetsPath.linkingIcon,
            title: StringManager.linkingAccount,
            onTap: () =>
                bottomDailog(context: context, widget: const LinkingScreen()),
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          settingsRow(
            context: context,
            icon: AssetsPath.languageIcon,
            title: StringManager.language,
            onTap: () => Navigator.pushNamed(context, Routes.language),
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          settingsRow(
            context: context,
            icon: AssetsPath.modeIcon,
            title: StringManager.mode,
            onTap: () => Navigator.pushNamed(context, Routes.mode),
          ),
          const Spacer(),
          BlocConsumer<LogOutBloc, LogOutState>(
            listener: (context, state) async{
              if(state is LogOutSucssesState) {
                    await FirebaseAuth.instance.signOut();
                    Methods().clearAuth();


                // ignore: use_build_context_synchronously
                Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
              }else if (state is LogOutErrorState){
                errorToast(context: context, title: state.error);
              }
            },
            builder: (context, state) {
              return MainButton(onTap: () {
                BlocProvider.of<LogOutBloc>(context).add(LogOutEvent());
              }, title: StringManager.logOut);
            },
          )
        ],
      ),
    );
  }
}

Widget settingsRow(
    {required BuildContext context,
    required String icon,
    required String title,
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
