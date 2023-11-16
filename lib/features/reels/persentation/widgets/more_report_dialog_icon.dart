// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/user_reel_viewr/widget/problem_customers_services.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_state.dart';

class MoreReportDialogIcon extends StatelessWidget {
  TextEditingController report ;
  void Function()? onTap;
  MoreReportDialogIcon({super.key,required this.onTap , required this.report });


  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportRealsBloc, ReportRealsState>(
      listener: (context, state) {
        if (state is ReportReelsLoadingState) {
          loadingToast(context: context, title: StringManager.loading.tr());
        } else if (state is ReportReelsSucssesState) {
          sucssesToast(context: context, title: state.message);
        } else if (state is ReportReelsErrorState) {
          errorToast(context: context, title: state.error);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: ConfigSize.defaultSize!,),
          ProblemTextFormField(
            textEditingController: report,
          ),
          SizedBox(height: ConfigSize.defaultSize!*2,),

          MainButton(
            onTap: onTap!,
            title: StringManager.report.tr(),
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }
}
