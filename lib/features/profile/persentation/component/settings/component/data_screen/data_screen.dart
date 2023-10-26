import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/active_notification_manager/active_notification_bloc.dart';

import '../../../../manager/active_notification_manager/active_notification_event.dart';

class DataScreen extends StatefulWidget {
  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  double currentValue = 1;

  @override
  void initState() {
    intiNotificationState();
    super.initState();
  }

  Future<void> intiNotificationState() async {
    bool key = await Methods.instance.getNotificationState();

    if (key == false) {
      currentValue = 0;
    } else {
      currentValue = 1;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: ConfigSize.defaultSize!*3,),
            dataRow(
              context: context,
              icon: Icons.delete,
              title: StringManager.clearData.tr(),
              onTap: () {
                Methods.instance.clearCachData(context);
              },
            ),
            SizedBox(
              height: ConfigSize.defaultSize! * 3.5,
            ),
            dataRow(
                context: context,
                icon: Icons.cloud_download,
                title: StringManager.downloadData.tr(),
                onTap: () async {
                  await Methods.instance.chachGiftInRoom();
                  await Methods.instance.getAndLoadExtraData();
                  await Methods.instance.getAndLoadFrames();
                  await Methods.instance.getAndLoadEntro();
                  await Methods.instance.getAndLoadEmojie();
                  sucssesToast(
                      title: StringManager.downloadedData.tr(), context: context);
                }),
            SizedBox(
              height: ConfigSize.defaultSize! * 3.5,
            ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: ConfigSize.screenWidth! * 0.05,
            //     ),
            //     Text(
            //       StringManager.activeNotification.tr(),
            //       style: Theme.of(context).textTheme.bodyMedium,
            //     ),
            //     SizedBox(
            //       width: ConfigSize.screenWidth! * 0.5,
            //     ),
            //     SizedBox(
            //       height: ConfigSize.defaultSize! * 1.9,
            //       width: ConfigSize.screenWidth! * .18,
            //       child: SliderTheme(
            //         data: const SliderThemeData(
            //             trackHeight: 15,
            //             thumbColor: ColorManager.mainColor,
            //             activeTrackColor: ColorManager.orang),
            //         child: Slider(
            //           value: currentValue,
            //           divisions: 1,
            //           onChanged: (value) {
            //             if (value == 1) {
            //               Methods().setNotificationState(notificationState: true);
            //               BlocProvider.of<ActiveNotificationBloc>(context)
            //                   .add(const ActiveNotificationEvent(state: true));
            //             } else if (value == 0) {
            //               Methods()
            //                   .setNotificationState(notificationState: false);
            //               BlocProvider.of<ActiveNotificationBloc>(context)
            //                   .add(const ActiveNotificationEvent(state: false));
            //             }
            //             setState(() {
            //               currentValue = value;
            //             });
            //           },
            //         ),
            //       ),
            //     ),
            //     //SizedBox(width: ConfigSize.screenWidth!*0.05,),
            //   ],
            // ),
          ],
        ),
      )),
    );
  }
}

Widget dataRow(
    {required BuildContext context,
    required IconData? icon,
    required String title,
    double? size,
    void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        Icon(icon),
        const Spacer(
          flex: 1,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Spacer(
          flex: 15,
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.primary,
          size: ConfigSize.defaultSize! * 2,
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    ),
  );
}
