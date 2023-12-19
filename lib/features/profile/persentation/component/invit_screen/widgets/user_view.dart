import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/invit_screen/widgets/user_info_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitations_manager/get_invitations_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitations_manager/get_invitations_state.dart';

class UserScreen extends StatelessWidget {
  // final List<InvitationUsersModel> data;
  // final RequestState stateRequest;
  // final String message;

  const UserScreen({
    super.key,
    // required this.data,
    // required this.stateRequest,
    // required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetInvitationBloc, InvitationDetailsDataStates>(
        builder: (BuildContext context, InvitationDetailsDataStates state) {
          if (state is UsersDataScussesState) {
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
                child: Text(''),
              );
            }

          } else if (state is UsersDataErorrState) {
            return CustomErrorWidget(
              message: state.massage,
            );
          } else if (state is UsersDataLoadingState) {
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
