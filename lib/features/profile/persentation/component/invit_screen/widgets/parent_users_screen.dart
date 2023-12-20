import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/invit_screen/widgets/user_info_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitations_users_manager/get_invitations_users_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitations_users_manager/get_invitations_users_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitations_users_manager/get_invitations_users_users_event.dart';

class ParentUsersScreen extends StatefulWidget {
  const ParentUsersScreen({
    super.key,
  });

  @override
  State<ParentUsersScreen> createState() => _ParentUsersScreenState();
}

class _ParentUsersScreenState extends State<ParentUsersScreen> {
  @override
  void initState() {
    BlocProvider.of<GetInvitationUsersDetailsBloc>(context)
        .add(const GetInVitationsUsersDetailsEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetInvitationUsersDetailsBloc,
          InvitationDetailsUsersStates>(
        builder: (BuildContext context, InvitationDetailsUsersStates state) {
          if (state is UsersDataScussesUsersState) {
            if (state.data != null) {
              return SizedBox(
                width: ConfigSize.screenWidth,
                height: ConfigSize.screenHeight,
                child: ListView.builder(
                  itemCount: state.data!.length,
                  itemBuilder: (context, i) {
                    return UserDetailsForParent(
                      data: state.data![i],
                    );
                  },
                ),
              );
            } else {
              return SizedBox(
                width: ConfigSize.screenWidth,
                height: ConfigSize.screenHeight,
              );
            }
          } else if (state is UsersDataErorrUsersState) {
            return CustomErrorWidget(
              message: state.massage,
            );
          } else if (state is UsersDataLoadingUsersState) {
            return const LoadingWidget();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

// switch (stateRequest) {
//   case RequestState.loaded:
//     return SizedBox(
//       width: ConfigSize.screenWidth,
//       height: ConfigSize.screenHeight,
//       child: ListView.builder(
//         itemCount: data.length,
//         itemBuilder: (context, i) {
//           return UserDetailsForParent(
//             data: data[i],
//           );
//         },
//       ),
//     );
//   case RequestState.loading:
//     return const LoadingWidget();
//   case RequestState.error:
//     log('user${message}');
//     return CustomErrorWidget(
//       message: message,
//     );
// }
