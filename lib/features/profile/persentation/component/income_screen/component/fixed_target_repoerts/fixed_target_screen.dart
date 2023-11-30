import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/fixed_target_repoerts/fixed_target_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_time_data_report/time_data_report_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_time_data_report/time_data_report_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_time_data_report/time_data_report_state.dart';

class FixedTargetScreen extends StatefulWidget {
  final MyDataModel myData;

  const FixedTargetScreen({required this.myData, super.key});

  @override
  State<FixedTargetScreen> createState() => _FixedTargetScreenState();
}

class _FixedTargetScreenState extends State<FixedTargetScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TimeDataReportBloc>()
        ..add(TimeDataReportToday(
            today: 'today', userId: widget.myData.id.toString()))
        ..add(TimeDataReportMonth(
            month: "month", userId: widget.myData.id.toString()))
        ..add(TimeDataReportAllInformation(
            allInformation: '', userId: widget.myData.id.toString())),
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustoumCachedImage(
                  height: ConfigSize.defaultSize! * 32,
                  url: widget.myData.profile!.image!,
                  width: MediaQuery.of(context).size.width,
                  boxFit: BoxFit.cover,
                  widget: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: ConfigSize.defaultSize! * 1,
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.white,
                                ))),
                        Column(
                          children: [
                            InkWell(
                              child: UserImage(
                                boxFit: BoxFit.cover,
                                image: widget.myData.profile!.image!,
                                imageSize: ConfigSize.defaultSize! * 10,
                              ),
                              onTap: () {
                                Methods.instance
                                    .userProfileNvgator(context: context);
                              },
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  GradientTextVip(
                                    text: widget.myData.name!,
                                    textStyle:
                                        Theme.of(context).textTheme.bodyMedium!,
                                    isVip: widget.myData.hasColorName!,
                                  ),
                                  Text('ID :${widget.myData.uuid}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<TimeDataReportBloc, TimeDataReportState>(
                  builder: (context, state) {
                    switch (state.dataTodayReportRequest) {
                      case RequestState.loaded:
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('  ${StringManager.fixedTarget.tr()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize:
                                            ConfigSize.defaultSize! *1.5)),
                                SizedBox(
                                  height: ConfigSize.defaultSize! * 3,
                                ),
                                FixedTargetCard(
                                  width: ConfigSize.screenWidth! * 0.5,
                                  mainTitle: StringManager.hours.tr(),
                                  target: '80000',
                                  subTitle: '70000',
                                ),
                                SizedBox(
                                  height: ConfigSize.defaultSize! * 2,
                                ),
                                FixedTargetCard(
                                  width: ConfigSize.screenWidth! * 0.6,
                                  mainTitle: StringManager.day.tr(),
                                  target: '80000',
                                  subTitle: '70000',
                                ),
                                SizedBox(
                                  height: ConfigSize.defaultSize! * 2,
                                ),
                                FixedTargetCard(
                                  width: ConfigSize.screenWidth! * 0.7,
                                  mainTitle: StringManager.daimonds.tr(),
                                  target: '80000',
                                  subTitle: '70000',
                                ),
                                SizedBox(
                                  height: ConfigSize.defaultSize! * 2,
                                ),
                                FixedTargetCard(
                                  width: ConfigSize.screenWidth! * 0.8,
                                  mainTitle: StringManager.momentTarget.tr(),
                                  target: '80000',
                                  subTitle: '70000',
                                ),
                                SizedBox(
                                  height: ConfigSize.defaultSize! * 2,
                                ),
                                FixedTargetCard(
                                  width: ConfigSize.screenWidth! * 0.9,
                                  mainTitle: StringManager.reelTarget.tr(),
                                  target: '80000',
                                  subTitle: '70000',
                                ),
                              ],
                            ),
                          ),
                        );
                      case RequestState.loading:
                        return const SizedBox();
                      case RequestState.error:
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: ConfigSize.defaultSize! * 30,
                          child: CustomErrorWidget(
                              message: StringManager.unexcepectedError.tr()),
                        );
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
