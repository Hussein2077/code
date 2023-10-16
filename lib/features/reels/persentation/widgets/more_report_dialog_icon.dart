// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/user_reel_viewr/widget/problem_customers_services.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_state.dart';

class MoreReportDialogIcon extends StatelessWidget {

  String title;
  void Function()? onTap;
  MoreReportDialogIcon({super.key, required this.title, required this.onTap});

  static TextEditingController report = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportRealsBloc, ReportRealsState>(
      listener: (context, state) {
        if (state is ReportReelsLoadingState) {
          loadingToast(context: context, title: StringManager.loading.tr());
        } else if (state is ReportReelsSucssesState) {
          sucssesToast(context: context, title: state.message);
        } else if (state is ReportReelsErrorState) {
          sucssesToast(context: context, title: state.error);
        }
      },
      child: Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ProblemTextFormField(
              textEditingController: report,
            ),
            MainButton(
              onTap: onTap!,
              title: StringManager.report.tr(),
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}
