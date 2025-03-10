import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_feed_back/bloc/feed_back_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_feed_back/bloc/feed_back_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_feed_back/bloc/feed_back_state.dart';

import 'widget/add_screen_shot.dart';
import 'widget/problem_type.dart';

class CustoumServiceScreen extends StatefulWidget {
  final int myId;

  const CustoumServiceScreen({required this.myId, super.key});

  @override
  State<CustoumServiceScreen> createState() => _CustoumServiceScreenState();
}

class _CustoumServiceScreenState extends State<CustoumServiceScreen> {
  late TextEditingController detailsController;
  late TextEditingController contactController;

  @override
  void initState() {
    detailsController = TextEditingController();
    contactController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderWithOnlyTitle(title: StringManager.complaints.tr()),
                Text(
                  StringManager.typeOfProblem.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const ProblemType(),
                Text(
                  StringManager.details.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  padding:
                      EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                  decoration: BoxDecoration(
                      color: ColorManager.lightGray,
                      borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize! * 2)),
                  child: TextFieldWidget(
                      maxLines: 4,
                      hintText: StringManager.explainProblem.tr(),
                      controller: detailsController),
                ),
                Text(
                  StringManager.whatsappNum.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  padding:
                      EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                  decoration: BoxDecoration(
                      color: ColorManager.lightGray,
                      borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize! * 2)),
                  child: TextFieldWidget(
                      type: TextInputType.number,
                      hintText: "",
                      controller: contactController),
                ),
                Text(
                  StringManager.screenshot.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const AddScreenShot(),
                BlocConsumer<FeedBackBloc, FeedBackState>(
                  listener: (context, state) {
                    if (state is FeedBackSucssesState) {
                      sucssesToast(context: context, title: state.massage);
                    } else if (state is FeedBackErrorState) {
                      errorToast(context: context, title: state.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is FeedBackSucssesState) {
                      return const SizedBox();
                    } else {
                      return MainButton(
                          onTap: () {
                            if (contactController.text.isEmpty) {
                              errorToast(
                                  context: context,
                                  title: StringManager.enterPhoneNum.tr());
                            } else if (detailsController.text.isEmpty) {
                              errorToast(
                                  context: context,
                                  title: StringManager.pleaseAddDetiels.tr());
                            } else if (AddScreenShot.image == null) {
                              errorToast(
                                  context: context,
                                  title: StringManager.enterYourImage.tr());
                            } else {
                              BlocProvider.of<FeedBackBloc>(context).add(
                                  FeedBackEvent(
                                      content: ProblemType
                                          .types[ProblemType.seletedProblem],
                                      phoneNumber: contactController.text,
                                      description: detailsController.text,
                                      image: File(AddScreenShot.image!.path),
                                      userId: widget.myId));
                            }
                          },
                          title: StringManager.submit.tr());
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
