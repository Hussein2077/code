import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/invit_code_manager/invit_code_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/invit_code_manager/invit_code_event.dart';

class InvitationCard extends StatefulWidget {
  @override
  State<InvitationCard> createState() => _InvitationCardState();
}

class _InvitationCardState extends State<InvitationCard> {
  ValueNotifier<bool> invitatioNotifier = ValueNotifier<bool>(false);
  final TextEditingController invitCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2.5),
          border: Border.all(color: Colors.white)),
      child: ValueListenableBuilder(
        valueListenable: invitatioNotifier,
        builder: (context, value, child) {
          log('rebuild');
          return (MyDataModel.getInstance().viewInvitation!)
              ? Column(
                  children: [
                    SizedBox(
                      height: ConfigSize.defaultSize! * 7,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ConfigSize.defaultSize!),
                      width: ConfigSize.screenWidth! * 0.6,
                      height: ConfigSize.defaultSize! * 6,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorManager.mainColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(ConfigSize.defaultSize! * 2),
                      ),
                      child: TextFieldWidget(
                        type: TextInputType.number,
                        controller: invitCodeController,
                        hintText: StringManager.enterTheInvitCode.tr(),
                      ),
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 2,
                    ),
                    MainButton(
                      width: ConfigSize.defaultSize! * 20,
                      height: ConfigSize.defaultSize! * 5,
                      onTap: () {
                        if (invitCodeController.text.isNotEmpty) {
                          if (MyDataModel.getInstance().uuid.toString() ==
                              invitCodeController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                errorSnackBar(context,
                                    StringManager.youCantInvitYourSelf.tr()));
                          } else {
                            BlocProvider.of<InvitCodeBloc>(context)
                                .add(InvitCodeEvent(
                              id: invitCodeController.text,
                            ));
                            invitCodeController.clear();
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              errorSnackBar(
                                  context, StringManager.cantBeEmpty.tr()));
                        }
                      },
                      title: StringManager.send.tr(),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        border: Border.all(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ConfigSize.defaultSize! * 20)),
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                        size: ConfigSize.defaultSize! * 15,
                      ),
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 2,
                    ),
                    Text(
                      StringManager.youHaveBeenInvited.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                );
        },
      ),
    );
  }
}
