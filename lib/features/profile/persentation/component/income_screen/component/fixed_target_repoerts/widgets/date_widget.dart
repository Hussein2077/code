import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_linear_date_picker/persian_linear_date_picker.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/date/date_dilog.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/fixed_target_repoerts/fixed_target_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_fixed_target_bloc/get_fixed_target_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_fixed_target_bloc/get_fixed_target_event.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({super.key});

  static String selectedDate = StringManager.choosemonth.tr();

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    void rebuild() {
      setState(() {});
    }

    return InkWell(
        onTap: () {
          setState(() {});
          dailogDate(
            context: context,
            widget: Container(
                height: ConfigSize.defaultSize! * 28,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize! * 3)),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        bottom: ConfigSize.defaultSize! * 3,
                      ),
                      child: PersianLinearDatePicker(
                        showLabels: false,
                        showDay: false,
                        dateChangeListener: (String selectedDate) {
                          FixedTargetScreen.selectedDate =
                              selectedDate.replaceAll('/', '-');
                          log('uuuuuuuuuuuuuuuuuu${FixedTargetScreen.selectedDate}');

                          BlocProvider.of<GetFixedTargetBloc>(context).add(
                              GetFixedTargetEvent(
                                  date: FixedTargetScreen.selectedDate));
                          DateWidget.selectedDate = selectedDate;
                        },
                        showMonthName: true,
                        columnWidth: ConfigSize.defaultSize! * 13,


                        selectedRowStyle:
                            Theme.of(context).textTheme.headlineLarge,
                        unselectedRowStyle:
                            Theme.of(context).textTheme.bodyLarge,
                        isPersian: false,
                      ),
                    ),
                    MainButton(
                      onTap: () {
                        Navigator.pop(context);
                        rebuild();
                      },
                      title: StringManager.done.tr(),
                    )
                  ],
                )),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
          width: ConfigSize.screenWidth!*0.5,
          height: ConfigSize.defaultSize! * 6,
          decoration: BoxDecoration(
              color: ColorManager.lightGray,
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 3)),
          child: Row(
            children: [
              const Icon(
                Icons.date_range,
                color: Colors.grey,
              ),
              SizedBox(
                width: ConfigSize.defaultSize,
              ),
              Text(
                DateWidget.selectedDate,
                style: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.9,
                    color: Colors.grey),
              ),
              const Spacer(),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
            ],
          ),
        ));
  }
}
