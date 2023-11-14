import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:persian_linear_date_picker/persian_linear_date_picker.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/date/date_dilog.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({super.key});
  static String selectedDatee = StringManager.birthdayDate;

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
                height: ConfigSize.defaultSize! * 40,
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

                        dateChangeListener: (String selectedDate) {
                          log(selectedDate.toString());
                          DateWidget.selectedDatee = selectedDate;
                        },
                        showMonthName: true,
                        columnWidth: ConfigSize.defaultSize! * 13,

                        //  labelStyle:
                        //      const TextStyle(fontFamily: 'DIN', color: Colors.blue),
                        selectedRowStyle:
                            Theme.of(context).textTheme.headlineLarge,
                        unselectedRowStyle:
                            Theme.of(context).textTheme.bodyLarge,
                        isPersian: false,
                      ),
                    ),
                   MainButton(onTap: (){
                     Navigator.pop(context);
                          rebuild();
                   },
                   
                   title: StringManager.done,
                   )
                  ],
                )),
          );

        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
          width: MediaQuery.of(context).size.width - 50,
          height: ConfigSize.defaultSize! * 6,
          decoration: BoxDecoration(
              color: ColorManager.lightGray,
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 3)),
          child: Row(
            children: [
              const Icon(Icons.date_range , color: Colors.grey,),
              SizedBox(width: ConfigSize.defaultSize,),
              Text(
                DateWidget.selectedDatee,
                style: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.9, color: Colors.grey),
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down , color: Colors.grey,),
            ],
          ),
        ));
  }
}
