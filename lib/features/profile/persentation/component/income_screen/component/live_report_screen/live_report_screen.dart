import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/id_with_copy_icon.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/live_report_screen/widget/break_moment_reals.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/live_report_screen/widget/card_Info_moment_reals.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/live_report_screen/widget/info_with_container_blue.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/live_report_screen/widget/live_month_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/live_report_screen/widget/live_today_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_time_data_report/time_data_report_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_time_data_report/time_data_report_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_time_data_report/time_data_report_state.dart';

class LiveReportScreen extends StatefulWidget {
  final MyDataModel myData;

  const LiveReportScreen({required this.myData, super.key});

  @override
  State<LiveReportScreen> createState() => _LiveReportScreenState();
}

class _LiveReportScreenState extends State<LiveReportScreen> {
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GradientTextVip(
                                  text: widget.myData.name!,
                                  textAlign: TextAlign.center,
                                  typeUser: widget.myData.myType ?? 0,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium!,
                                  isVip: widget.myData.hasColorName!,
                                ),
                                /* Text(widget.ownerDataModel.name!,
                                        style:
                                        TextStyle(color: Colors.white, fontSize: ConfigSize.defaultSize! *2.2,fontWeight: FontWeight.bold)),*/
                                SizedBox(
                                  height: ConfigSize.defaultSize! * 0.5,
                                ),
                                IdWithCopyIcon(
                                  userData: widget.myData,
                                )
                              ],
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

                              ///0xfff8f8f8
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children: [
                                InfoWithWidget(
                                  title: StringManager.today.tr(),
                                ),
                                SizedBox(
                                  height: ConfigSize.defaultSize! * 3,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LiveTodayCard(
                                          widget: Text(
                                            state.dataToday!.hours,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          title: StringManager.hours.tr(),
                                        ),
                                        LiveTodayCard(
                                          widget: state.dataToday!.today
                                              ? const Icon(Icons.check)
                                              : const Icon(Icons.close),
                                          title: StringManager.today.tr(),
                                        ),
                                        LiveTodayCard(
                                          widget: Text(
                                            state.dataToday!.diamonds.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          title: StringManager.diamond.tr(),
                                        ),
                                      ],
                                    ),
                                     BreakMomentReals(
                                      title: StringManager.reels.tr(),
                                    ),
                                    CardInfoMomentReals(
                                      like: state.dataToday!.reals.like.toString(),
                                      comment:
                                      state.dataToday!.reals.comment.toString(),
                                      upload:
                                      state.dataToday!.reals.upload.toString(),
                                    ),
                                     BreakMomentReals(
                                      title: StringManager.moments.tr(),
                                    ),
                                    CardInfoMomentReals(
                                      like: state.dataToday!.moment.like.toString(),
                                      comment:
                                      state.dataToday!.moment.comment.toString(),
                                      upload:
                                      state.dataToday!.moment.upload.toString(),
                                    ),
                                  ],
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
                BlocBuilder<TimeDataReportBloc, TimeDataReportState>(
                  builder: (context, state) {
                    switch (state.dataMonthlyReportRequest) {
                      case RequestState.loaded:
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(

                              ///0xfff8f8f8
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children: [
                                InfoWithWidget(
                                    title: StringManager.dataInMounth.tr()),
                                const SizedBox(
                                  height: 20,
                                ),
                                CardInfoMonthOrAllInfo(
                                  infoDay: state.dataMonthly!.days.toString(),
                                  infoDiamond:
                                      state.dataMonthly!.diamonds.toString(),
                                  infoHours:
                                      state.dataMonthly!.hours.toString(),
                                ),
                                BreakMomentReals(
                                  title: StringManager.reels.tr(),
                                ),
                                CardInfoMomentReals(
                                  like: state.dataMonthly!.reals.like.toString(),
                                  comment:
                                  state.dataMonthly!.reals.comment.toString(),
                                  upload:
                                  state.dataMonthly!.reals.upload.toString(),
                                ),
                                BreakMomentReals(
                                  title: StringManager.moments.tr(),
                                ),
                                CardInfoMomentReals(
                                  like: state.dataMonthly!.moment.like.toString(),
                                  comment:
                                  state.dataMonthly!.moment.comment.toString(),
                                  upload:
                                  state.dataMonthly!.moment.upload.toString(),
                                ),
                              ],
                            ),
                          ),
                        );
                      case RequestState.loading:
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: ConfigSize.defaultSize! * 20,
                          child: const LoadingWidget(),
                        );
                      case RequestState.error:
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: ConfigSize.defaultSize! * 20,
                          child: CustomErrorWidget(
                              message: StringManager.unexcepectedError.tr()),
                        );
                    }
                  },
                ),
                BlocBuilder<TimeDataReportBloc, TimeDataReportState>(
                  builder: (context, state) {
                    switch (state.allInfoDataRequest) {
                      case RequestState.loaded:
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(

                              ///0xfff8f8f8
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children: [
                                InfoWithWidget(title: StringManager.total.tr()),
                                const SizedBox(
                                  height: 20,
                                ),
                                CardInfoMonthOrAllInfo(
                                  infoDay: state.allInfoData!.days.toString(),
                                  infoDiamond:
                                      state.allInfoData!.diamonds.toString(),
                                  infoHours:
                                      state.allInfoData!.hours.toString(),
                                ),
                                BreakMomentReals(
                                  title: StringManager.reels.tr(),
                                ),
                                CardInfoMomentReals(
                                  like: state.allInfoData!.reals.like.toString(),
                                  comment:
                                  state.allInfoData!.reals.comment.toString(),
                                  upload:
                                  state.allInfoData!.reals.upload.toString(),
                                ),
                                BreakMomentReals(
                                  title: StringManager.moments.tr(),
                                ),
                                CardInfoMomentReals(
                                  like: state.allInfoData!.moment.like.toString(),
                                  comment:
                                  state.allInfoData!.moment.comment.toString(),
                                  upload:
                                  state.allInfoData!.moment.upload.toString(),
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
                          height: ConfigSize.defaultSize! * 20,
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
