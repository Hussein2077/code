import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_join_family/bloc/join_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_join_family/bloc/join_family_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_join_family/bloc/join_family_state.dart';

class FamilyProfileBottomBar extends StatelessWidget {
  final String familyId;

  const FamilyProfileBottomBar({required this.familyId, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JoinFamilyBloc, JoinFamilyState>(
      listener: (context, state) {
        if(state is JoinFamilySucssesState){
          sucssesToast(context: context, title: state.messeage);
        }else if(state is JoinFamilyErrorState){
          errorToast(context: context, title: state.error);
        }
      },
      builder: (context, state) {
        if(state is JoinFamilySucssesState){
    return Container(
          padding: EdgeInsets.symmetric(
              horizontal: ConfigSize.defaultSize! * 3,
              vertical: ConfigSize.defaultSize! * 2.5),
          width: MediaQuery.of(context).size.width,
          height: ConfigSize.defaultSize! * 9,
          color: Theme.of(context).colorScheme.secondary,
          child: MainButton(
            buttonColor: ColorManager.bageGriedinet,
            onTap: () {
              
            },
            title: state.messeage,
          ),
        );
        }else {
              return Container(
          padding: EdgeInsets.symmetric(
              horizontal: ConfigSize.defaultSize! * 3,
              vertical: ConfigSize.defaultSize! * 2.5),
          width: MediaQuery.of(context).size.width,
          height: ConfigSize.defaultSize! * 9,
          color: Theme.of(context).colorScheme.secondary,
          child: MainButton(
            onTap: () {
              BlocProvider.of<JoinFamilyBloc>(context)
                  .add(JoinFamilyEvent(id: familyId));
            },
            title: StringManager.requestToJoin.tr(),
          ),
        );
        }
      },
    );
  }
}
