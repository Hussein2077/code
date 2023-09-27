import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_info_row.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';


class MomentLikesScreen extends StatelessWidget {
 final MomentModel momentModel;
  const MomentLikesScreen({
    required this.momentModel,
    super.key,
  });

  // final UserDataModel? userDataModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      width: ConfigSize.screenWidth!,
      height: ConfigSize.defaultSize!*45,
      child: Padding(
        padding: EdgeInsets.only(
            left: ConfigSize.defaultSize!,
            right: ConfigSize.defaultSize!,
            top: ConfigSize.defaultSize!),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!),
            child: MomentInfoRow(momentModel: momentModel,comment: false),
            //MomentAppBar(),
          ),
          Divider(
            indent: ConfigSize.defaultSize! * 8,
            endIndent: 50,
            thickness: 1,
            height: ConfigSize.defaultSize! * 2,
            color: ColorManager.gray,
          ),
        ]),
      ),
    );
  }
}
