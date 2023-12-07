import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/fixed_target_repoerts/widgets/date_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/fixed_target_repoerts/widgets/fixed_target_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_fixed_target_bloc/get_fixed_target_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_fixed_target_bloc/get_fixed_target_state.dart';

class FixedTargetScreen extends StatefulWidget {
  final MyDataModel myData;
  static String selectedDate = StringManager.choosemonth.tr();

  const FixedTargetScreen({required this.myData, super.key});

  @override
  State<FixedTargetScreen> createState() => _FixedTargetScreenState();
}

class _FixedTargetScreenState extends State<FixedTargetScreen> {
  @override
  dispose(){
    super.dispose();

    DateWidget.selectedDate=StringManager.choosemonth.tr();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            width: ConfigSize.screenWidth! * 0.35,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GradientTextVip(
                                  text: widget.myData.name!,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium!,
                                  isVip: widget.myData.hasColorName!,
                                ),
                                Text('ID :${widget.myData.uuid}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: ConfigSize.defaultSize!*1.1,),

              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20,),                child: DateWidget(),
              ),
              // Container(
              //   padding: EdgeInsets.only(
              //     bottom: ConfigSize.defaultSize! * 3,
              //   ),
              //   child: PersianLinearDatePicker(
              //
              //     showLabels: false,
              //     showDay: false,
              //     dateChangeListener: (String selectedDate) {
              //       FixedTargetScreen.selectedDate = selectedDate.replaceAll('/', '-');
              //       log('uuuuuuuuuuuuuuuuuu${FixedTargetScreen.selectedDate}');
              //
              //       BlocProvider.of<GetFixedTargetBloc>(context).add(
              //           GetFixedTargetEvent(
              //               date: FixedTargetScreen.selectedDate));
              //     },
              //     showMonthName: true,
              //     columnWidth: ConfigSize.defaultSize! * 13,
              //
              //     //  labelStyle:
              //     //      const TextStyle(fontFamily: 'DIN', color: Colors.blue),
              //     selectedRowStyle: Theme.of(context).textTheme.headlineLarge,
              //     unselectedRowStyle: Theme.of(context).textTheme.bodyLarge,
              //     isPersian: false,
              //   ),
              // ),
              BlocBuilder<GetFixedTargetBloc, GetFixedTargetStates>(
                builder: (context, state) {
                  if (state is GetFixedTargetSucssesState) {
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

                            FixedTargetCard(
                              width: ConfigSize.screenWidth! * 0.5,
                              mainTitle: StringManager.hours.tr(),
                              target: state.data!.hours.toString(),
                            ),
                            SizedBox(
                              height: ConfigSize.defaultSize! * 2,
                            ),
                            FixedTargetCard(
                              width: ConfigSize.screenWidth! * 0.6,
                              mainTitle: StringManager.day.tr(),
                              target: state.data!.days.toString(),
                            ),
                            SizedBox(
                              height: ConfigSize.defaultSize! * 2,
                            ),
                            FixedTargetCard(
                              width: ConfigSize.screenWidth! * 0.7,
                              mainTitle: StringManager.daimonds.tr(),
                              target: state.data!.diamonds.toString(),
                            ),
                            SizedBox(
                              height: ConfigSize.defaultSize! * 2,
                            ),
                            FixedTargetCard(
                              width: ConfigSize.screenWidth! * 0.8,
                              mainTitle: StringManager.totalUsd.tr(),
                              target: state.data!.totalUsd.toString(),
                            ),
                            SizedBox(
                              height: ConfigSize.defaultSize! * 2,
                            ),
                            FixedTargetCard(
                              width: ConfigSize.screenWidth! * 0.9,
                              mainTitle: StringManager.totalDaimonds.tr(),
                              target: state.data!.totalDiamond.toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  else if (state is GetFixedTargetErrorState) {
                    log('GetFixedTargetErrorState');

                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: ConfigSize.defaultSize! * 30,
                      child: CustomErrorWidget(message: state.errorMassage),
                    );
                  }
                  else if (state is GetFixedTargetLoadingState) {
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                  // switch (state.dataTodayReportRequest) {
                  //   case RequestState.loaded:
                  //     return Container(
                  //       width: MediaQuery.of(context).size.width,
                  //       decoration: BoxDecoration(
                  //           color: Theme.of(context).colorScheme.background,
                  //           borderRadius: const BorderRadius.only(
                  //             topRight: Radius.circular(30),
                  //             topLeft: Radius.circular(30),
                  //           )),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 20, vertical: 20),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text('  ${StringManager.fixedTarget.tr()}',
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.black,
                  //                     fontSize:
                  //                         ConfigSize.defaultSize! *1.5)),
                  //             SizedBox(
                  //               height: ConfigSize.defaultSize! * 3,
                  //             ),
                  //             FixedTargetCard(
                  //               width: ConfigSize.screenWidth! * 0.5,
                  //               mainTitle: StringManager.hours.tr(),
                  //               target: '70000',
                  //               subTitle: '80000',
                  //             ),
                  //             SizedBox(
                  //               height: ConfigSize.defaultSize! * 2,
                  //             ),
                  //             FixedTargetCard(
                  //               width: ConfigSize.screenWidth! * 0.6,
                  //               mainTitle: StringManager.day.tr(),
                  //               target: '70000',
                  //               subTitle: '80000',
                  //             ),
                  //             SizedBox(
                  //               height: ConfigSize.defaultSize! * 2,
                  //             ),
                  //             FixedTargetCard(
                  //               width: ConfigSize.screenWidth! * 0.7,
                  //               mainTitle: StringManager.daimonds.tr(),
                  //               target: '70000',
                  //               subTitle: '80000',
                  //             ),
                  //             SizedBox(
                  //               height: ConfigSize.defaultSize! * 2,
                  //             ),
                  //             FixedTargetCard(
                  //               width: ConfigSize.screenWidth! * 0.8,
                  //               mainTitle: StringManager.momentTarget.tr(),
                  //               target: '70000',
                  //               subTitle: '80000',
                  //             ),
                  //             SizedBox(
                  //               height: ConfigSize.defaultSize! * 2,
                  //             ),
                  //             FixedTargetCard(
                  //               width: ConfigSize.screenWidth! * 0.9,
                  //               mainTitle: StringManager.reelTarget.tr(),
                  //               target: '70000',
                  //               subTitle: '80000',
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   case RequestState.loading:
                  //     return const SizedBox();
                  //   case RequestState.error:
                  //     return SizedBox(
                  //       width: MediaQuery.of(context).size.width,
                  //       height: ConfigSize.defaultSize! * 30,
                  //       child: CustomErrorWidget(
                  //           message: StringManager.unexcepectedError.tr()),
                  //     );
                  // }
                },
              ),
            ],
          ),
        ));
  }
}
//  return Container(
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               color: Theme.of(context).colorScheme.background,
//                               borderRadius: const BorderRadius.only(
//                                 topRight: Radius.circular(30),
//                                 topLeft: Radius.circular(30),
//                               )),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 20, vertical: 20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('  ${StringManager.fixedTarget.tr()}',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black,
//                                         fontSize:
//                                             ConfigSize.defaultSize! *1.5)),
//                                 SizedBox(
//                                   height: ConfigSize.defaultSize! * 3,
//                                 ),
//                                 FixedTargetCard(
//                                   width: ConfigSize.screenWidth! * 0.5,
//                                   mainTitle: StringManager.hours.tr(),
//                                   target: '70000',
//                                   subTitle: '80000',
//                                 ),
//                                 SizedBox(
//                                   height: ConfigSize.defaultSize! * 2,
//                                 ),
//                                 FixedTargetCard(
//                                   width: ConfigSize.screenWidth! * 0.6,
//                                   mainTitle: StringManager.day.tr(),
//                                   target: '70000',
//                                   subTitle: '80000',
//                                 ),
//                                 SizedBox(
//                                   height: ConfigSize.defaultSize! * 2,
//                                 ),
//                                 FixedTargetCard(
//                                   width: ConfigSize.screenWidth! * 0.7,
//                                   mainTitle: StringManager.daimonds.tr(),
//                                   target: '70000',
//                                   subTitle: '80000',
//                                 ),
//                                 SizedBox(
//                                   height: ConfigSize.defaultSize! * 2,
//                                 ),
//                                 FixedTargetCard(
//                                   width: ConfigSize.screenWidth! * 0.8,
//                                   mainTitle: StringManager.momentTarget.tr(),
//                                   target: '70000',
//                                   subTitle: '80000',
//                                 ),
//                                 SizedBox(
//                                   height: ConfigSize.defaultSize! * 2,
//                                 ),
//                                 FixedTargetCard(
//                                   width: ConfigSize.screenWidth! * 0.9,
//                                   mainTitle: StringManager.reelTarget.tr(),
//                                   target: '70000',
//                                   subTitle: '80000',
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );