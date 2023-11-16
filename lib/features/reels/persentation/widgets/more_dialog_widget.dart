// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/user_reel_viewr/user_reel_view.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/more_report_dialog_icon.dart';

class MoreDialog extends StatelessWidget {
 TextEditingController report ;
  String id;
  String userId;
  MoreDialog({super.key, required this.id, required this.userId , required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: ConfigSize.defaultSize!,
          horizontal: ConfigSize.defaultSize!),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-200,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
      child: MoreReportDialogIcon(
        report: report,
        title: StringManager.report.tr(),
        onTap: () => BlocProvider.of<ReportRealsBloc>(context).add(ReportReals(
            reportedId: userId, realId: id, description: report.text)),
      ),
    );
  }
}
