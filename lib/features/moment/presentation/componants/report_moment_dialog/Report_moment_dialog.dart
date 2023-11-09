
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/report_moment_dialog/problem_type.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_report_moment/report_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_report_moment/report_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_report_moment/report_moment_state.dart';

class MomentReportDialog extends StatefulWidget {

  final String momentId;
  MomentReportDialog({required this.momentId});
  @override
  State<MomentReportDialog> createState() => _MomentReportDialogState();
}

class _MomentReportDialogState extends State<MomentReportDialog> {
  late TextEditingController detailsController;
  late TextEditingController contactController;

  @override
  void initState() {
    super.initState();
    detailsController = TextEditingController();
    contactController = TextEditingController();
 
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: BlurryContainer(
color: Theme.of(context).colorScheme.background.withOpacity(0.5),
        height: ConfigSize.screenHeight!*0.6,
        width: ConfigSize.screenWidth!*0.8,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ConfigSize.defaultSize!*5,),
              Text(
                StringManager.typeOfProblem.tr(),
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,
              ),
              SizedBox(height: ConfigSize.defaultSize!*2,),

               ProblemType(),
              SizedBox(height: ConfigSize.defaultSize!*4,),

              Text(
                StringManager.details.tr(),
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,
              ),
              SizedBox(height: ConfigSize.defaultSize!,),

              Container(
                width: ConfigSize.screenWidth!*0.7,
                padding:
                EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                decoration: BoxDecoration(
                    color: ColorManager.lightGray,
                    borderRadius:
                    BorderRadius.circular(ConfigSize.defaultSize! * 2)),
                child: TextFieldWidget(
                    maxLines: 4,
                    hintText: StringManager.explainProblem.tr(),
                    controller: detailsController,
                fontSize: ConfigSize.defaultSize!*1.4,
                ),
              ),
              SizedBox(height: ConfigSize.defaultSize!*5,),

              BlocConsumer<ReportMomentBloc, ReportMomentStates>(
                listener: (context, state) {
                  if (state is ReportMomentSucssesState) {
                    sucssesToast(context: context, title: state.sucssesMessage);
                  }
                  else if (state is ReportMomentErrorState) {
                  //  errorToast(context: context, title: state.errorMessage);
                  }
                },
                builder: (context, state) {
                  if (state is ReportMomentSucssesState) {
                    return const SizedBox();
                  } else {
                    return MainButton(
                        onTap: () {

                          if (detailsController.text.isEmpty) {
                            errorToast(
                                context: context,
                                title: StringManager.pleaseAddDetiels.tr());
                          } else {
                            BlocProvider.of<ReportMomentBloc>(context).add(
                                ReportMomentEvent(

                                  type: ProblemType.typesArabic[ProblemType.seletedMomentProblem],
                                  momentId:widget.momentId,
                                  discreption:detailsController.text,

                                ));
                          }
                        },
                        title: StringManager.submit.tr());
                  }
                },
              ),

            ],
          ),
        ),

      ),
    );
  }
}