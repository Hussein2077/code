import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/account_states.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/acount_bloc.dart';

class LinkingScreenBody extends StatefulWidget {
  final MyDataModel myData;

  const LinkingScreenBody({required this.myData, super.key});

  @override
  State<LinkingScreenBody> createState() => _LinkingScreenBodyState();
}

class _LinkingScreenBodyState extends State<LinkingScreenBody> {
  @override
  Widget build(BuildContext context) {
    bool isHigh = ( widget.myData.isGoogle! && widget.myData.isPhone!);
    return BlocListener<AcountBloc, AccountStates>(
      listener: (context, state) {
        if (state is GoogleAccountSuccessState) {
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
        } else if (state is GoogleAccountErrorState) {
          errorToast(context: context, title: state.errorMessage);
        } else if (state is GoogleAccountLoading) {
          loadingToast(context: context, title: StringManager.loading.tr());
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (isHigh)
                    ? Image.asset(
                  AssetsPath.highProtected,
                  scale: 1.5,
                )
                    : Image.asset(
                  AssetsPath.lowProtected,
                  scale: 1.5,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "${StringManager.protectionLevel.tr()} : ",
                          style: Theme.of(context).textTheme.bodyLarge),
                      TextSpan(
                          text:
                          (isHigh) ? StringManager.high : StringManager.low.tr(),
                          style: TextStyle(
                              color: (isHigh) ? Colors.green : Colors.red,
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
                  title: StringManager.phoneNum.tr(),
                  isBind: widget.myData.isPhone!,
                  onTap: () {
                  widget.myData.isPhone!
                        ? Navigator.pushNamed(
                            context, Routes.changePassOrNumberScreen)
                        : Navigator.pushNamed(context, Routes.phoneBindScreen);
                  },
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 3.5,
                ),
                linkingRow(
                  context: context,
                  icon: AssetsPath.googleIcon,
                  title: StringManager.google.tr(),
                  isBind: widget.myData.isGoogle!,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget linkingRow({
  required BuildContext context,
  required String icon,
  required String title,
  required void Function() onTap,
  required bool isBind,
}) {
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
        onTap: onTap,
        title: isBind ? StringManager.linked.tr():StringManager.link.tr() ,
        width: ConfigSize.defaultSize! * 7,
        height: ConfigSize.defaultSize! * 3,
        titleSize: ConfigSize.defaultSize! * 1.6,
        buttonColor:
            isBind ?   ColorManager.bageGriedinet:ColorManager.yellowGrident,
      ),

//the old ontap in the second mainbutton
      // type == "google"
      //     ? () {
      //         BlocProvider.of<AcountBloc>(context)
      //             .add(BindGoolgeAccountEvent());
      //       }
      //     : () {
      //         Navigator.pop(context);
      //         Navigator.pushNamed(context, Routes.phoneBindScreen);
      //       },

      const Spacer(
        flex: 1,
      ),
    ],
  );
}
