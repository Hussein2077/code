import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/pop_up_dialog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_delete_family/bloc/delete_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_delete_family/bloc/delete_family_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_delete_family/bloc/delete_family_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_exite_family/bloc/exit_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_exite_family/bloc/exit_family_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';

class SettingsDailog extends StatelessWidget {
  final bool isOwner;
  final String numOfRequests;
  final String familyId;
  final bool isAdmin;
  final bool isMember;
  const SettingsDailog(
      {required this.familyId,
      required this.isOwner,
      required this.numOfRequests,
      required this.isAdmin,
      required this.isMember,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExitFamilyBloc, ExitFamilyState>(
      listener: (context, state) {
        if(state is ExitFamilySucssesState){
          Navigator.pop(context);
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
        }else if (state is ExitFamilyErrorState){
          errorToast(context: context, title: state.error);
        }
      },
      child: BlocListener<DeleteFamilyBloc, DeleteFamilyState>(
        listener: (context, state) {
          if (state is DeleteFamilySucssesStete) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.mainScreen, (route) => false);
          } else if (state is DeleteFamilyErrorSate) {
            errorToast(context: context, title: state.massage);
          }
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (isAdmin || isOwner)
                  settingsTabs(
                    context: context,
                    title: "${StringManager.joinRequests} ( $numOfRequests )",
                    onTap: () => Navigator.pushNamed(
                        context, Routes.familyRequests,
                        arguments: familyId),
                  ),
                CustomHorizntalDvider(width: MediaQuery.of(context).size.width),
                if (isOwner)
                  settingsTabs(
                    context: context,
                    title: StringManager.deleteFamily,
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return PopUpDialog(
                            headerText: StringManager.areYouSureDeleteFamily,
                            accpetText: (){ Navigator.pop(context);
                                BlocProvider.of<DeleteFamilyBloc>(context)
                                    .add(DeleteFamilyEvent(id: familyId));},
                          );
                        }),
                  ),
                if ((isAdmin || isMember)&&!isOwner)
                  settingsTabs(
                    context: context,
                    title: StringManager.exitFamily,
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return PopUpDialog(
                            headerText: StringManager.exitFamily,
                            accpetText: () =>
                                BlocProvider.of<DeleteFamilyBloc>(context)
                                    .add(DeleteFamilyEvent(id: familyId)),
                          );
                        }),
                  ),
                MainButton(
                    height: ConfigSize.defaultSize! * 4,
                    buttonColor: ColorManager.bageGriedinet,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: StringManager.cancel)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget settingsTabs(
    {required BuildContext context, required title, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge,
    ),
  );
}
