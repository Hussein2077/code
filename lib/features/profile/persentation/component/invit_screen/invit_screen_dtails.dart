import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/invit_screen/widgets/invitation_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/invit_screen/widgets/profit_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitations_manager/get_invitations_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitations_manager/get_invitations_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/invit_code_manager/invit_code_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/invit_code_manager/invit_code_state.dart';

class InvitScreenDetails extends StatefulWidget {
  @override
  State<InvitScreenDetails> createState() => _InvitScreenDetailsState();
}

class _InvitScreenDetailsState extends State<InvitScreenDetails> {
  List<String> points = [
    StringManager.invitationCodePoint1.tr(),
    StringManager.invitationCodePoint2.tr(),
    StringManager.invitationCodePoint3.tr(),
  ];

  ValueNotifier<bool> invitatioNotifier = ValueNotifier<bool>(false);
  final TextEditingController invitCodeController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<GetInvitationBloc>(context)
        .add(const GetInVitationsDetailsEvent());
    BlocProvider.of<GetInvitationBloc>(context)
        .add(const GetParentDetailsEvent());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String paragraph = points.join('\n');

    return BlocListener<InvitCodeBloc, InvitCodeState>(
      listener: (context, state) {
        if (state is InvitCodeLoadingState) {
          log('lllllll1');
          ScaffoldMessenger.of(context).showSnackBar(loadingSnackBar(context));
        } else if (state is InvitCodeScussesState) {
          log('lllllll2');

          ScaffoldMessenger.of(context)
              .showSnackBar(successSnackBar(context, state.massage));
          log('lllllll4');
          log('ggggggg${MyDataModel.getInstance().viewInvitation}');

          MyDataModel.getInstance().viewInvitation = false;
          log('ggggggg${MyDataModel.getInstance().viewInvitation}');
          log('lllllll5');
          log('ggggggggg${invitatioNotifier.value}');

          invitatioNotifier.value = !invitatioNotifier.value;
          log('ggggggggg${invitatioNotifier.value}');
          log('lllllll6');

        } else if (state is InvitCodeErorrState) {
          log('lllllll3');

          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackBar(context, state.massage));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderWithOnlyTitle(
                  title: StringManager.invitaion.tr(),
                  endIcon: const SizedBox()),
              SizedBox(
                height: ConfigSize.defaultSize! * 0.8,
              ),

              InvitationCard(),
              SizedBox(
                height: ConfigSize.defaultSize! * 0.8,
              ),
              ProfitCard(),

              Container(
                width: ConfigSize.screenWidth,
                height: ConfigSize.screenHeight! * 0.25,
                margin: EdgeInsets.symmetric(
                    vertical: ConfigSize.defaultSize! * 1,
                    horizontal: ConfigSize.defaultSize! * 1.8),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xFFFF382C),
                      const Color(0xFFFFBB0D),
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.7),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),

                    //color: Colors.white.withOpacity(0.7),
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize! * 2.5),
                    border: Border.all(color: Colors.white)),
                child: Center(
                  child: Text(
                    paragraph,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
