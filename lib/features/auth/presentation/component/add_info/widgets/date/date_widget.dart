import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:persian_linear_date_picker/persian_linear_date_picker.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/date/date_dilog.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({super.key});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  String selectedDatee = StringManager.birthdayDate;

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
                height: ConfigSize.defaultSize! * 35,
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
                          selectedDatee = selectedDate;
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
        child: Text(
          selectedDatee,
          style: TextStyle(
              fontSize: ConfigSize.defaultSize! * 1.9, color: Colors.grey),
        ));
  }
}
