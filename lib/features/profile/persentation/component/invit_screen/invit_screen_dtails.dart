import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/features/profile/data/data_sorce/remotly_data_source_profile.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/invit_screen/widgets/invitation_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/invit_screen/widgets/profit_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitation_parent_bloc/get_invitations_parent_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitation_parent_bloc/get_invitations_parent_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/invit_code_manager/invit_code_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/invit_code_manager/invit_code_state.dart';

class InvitScreenDetails extends StatefulWidget {
  @override
  State<InvitScreenDetails> createState() => _InvitScreenDetailsState();
}

class _InvitScreenDetailsState extends State<InvitScreenDetails> {
  final TextEditingController invitCodeController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<GetInvitationParentDetailsBloc>(context)
        .add(const GetParentDetailsParentEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<InvitCodeBloc, InvitCodeState>(
      listener: (context, state) {
        if (state is InvitCodeLoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(loadingSnackBar(context));
        } else if (state is InvitCodeScussesState) {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(successSnackBar(context, state.massage));

          MyDataModel.getInstance().viewInvitation = false;

          InvitationCard.invitatioNotifier.value =
              !InvitationCard.invitatioNotifier.value;
        } else if (state is InvitCodeErorrState) {

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
                // height: ConfigSize.screenHeight! * 0.25,
                margin: EdgeInsets.symmetric(
                    vertical: ConfigSize.defaultSize! * 1,
                    horizontal: ConfigSize.defaultSize! * 1.8),
                padding: EdgeInsets.all(ConfigSize.defaultSize! * 1.5),
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
                  child: FutureBuilder(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.toString(),
                          overflow: TextOverflow.fade,
                        );
                      } else if (snapshot.hasError) {
                        return const CustomErrorWidget(
                          message: StringManager.noDataFoundHere,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    String paragraph =
        await RemotlyDataSourceProfile().GetInvitationExplination();
    return paragraph;
  }
}
