import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/pop_up_dialog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_delete_family/bloc/delete_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_delete_family/bloc/delete_family_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_delete_family/bloc/delete_family_state.dart';

class SettingsDailog extends StatelessWidget {
  final bool isOwner;
  final String numOfRequests;
  final String familyId;
  const SettingsDailog(
      {required this.familyId,
      required this.isOwner,
      required this.numOfRequests,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteFamilyBloc, DeleteFamilyState>(
      listener: (context, state) {
        if(state is DeleteFamilySucssesStete){
          Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen, (route) => false);
        }else if (state is DeleteFamilyErrorSate){
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
              settingsTabs(
                context: context,
                title: "${StringManager.joinRequests} ( $numOfRequests )",
                onTap: () =>
                    Navigator.pushNamed(context, Routes.familyRequests),
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
