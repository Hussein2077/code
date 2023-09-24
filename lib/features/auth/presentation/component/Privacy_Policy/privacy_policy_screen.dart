
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/manager_privacy_policy/privacy_policy_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/manager_privacy_policy/privacy_policy_state.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ConfigSize.screenWidth,
        height: ConfigSize.screenHeight,
        decoration:  const BoxDecoration(
            gradient: LinearGradient(
                colors: ColorManager.mainColorList,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight
            )
        ),
        padding:
        EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 2),
        child: BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
          builder: (context, state) {
            if (state is PrivacyPolicySucssesState) {
              return Scaffold(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: ConfigSize.defaultSize! * 0.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_ios_new)),
                            const Spacer(
                              flex: 20,
                            ),
                            Text(
                              StringManager.thePrivecyPolicy.tr(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ConfigSize.defaultSize! * 0.5,
                        ),
                        Text(
                          state.message,
                          style:TextStyle() ,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ));
            } else if (state is PrivacyPolicyLoadingState) {
              return const Center(child: LoadingWidget());
            } else if (state is PrivacyPolicyErrorState) {
              return CustomErrorWidget(message: state.error);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }


}