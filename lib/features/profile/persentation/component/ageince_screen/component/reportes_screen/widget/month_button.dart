import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/data/model/agency_time_history_model.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_history/agency_time_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_history/agency_time_event.dart';

import 'years_button.dart';

class MounthButton extends StatefulWidget {
  static   String? mounth;
  final List <AgencyHistoryTime> data ; 

  const MounthButton({required this.data, super.key});

  @override
  State<MounthButton> createState() => _MounthButtonState();
}

class _MounthButtonState extends State<MounthButton> {
   List<String> global = [] ;
@override
  void initState() {
    for(int i = 0 ; i<widget.data.length; i++){
      global.add(widget.data[i].month.toString());
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: ConfigSize.defaultSize!*17,
      height: ConfigSize.defaultSize!*5,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(ConfigSize.defaultSize!) ,color: Colors.white.withOpacity(0.2)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
           StringManager.mounths,
            style: TextStyle(
              fontSize: ConfigSize.defaultSize! * 1.8,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          items: global
              .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child :    Text(
                        item,
                        style: TextStyle(
                          fontSize: ConfigSize.defaultSize! * 1.8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),))
              .toList(),
          value: MounthButton.mounth,
          onChanged: (value) {
            setState(() {
              MounthButton.mounth = value as String;
              if (MounthButton.mounth!=null && YearsButton.year!=null){
                BlocProvider.of<AgencyTimeBloc>(context).add(AgencyTimeEvent(
                  mounth: MounthButton.mounth! ,
                  year: YearsButton.year!
                ));
              }
            });
          },
          icon: const Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: ConfigSize.defaultSize! * 1.8,
          iconEnabledColor: Colors.white,
          iconDisabledColor: Colors.grey,
          buttonHeight: ConfigSize.defaultSize! * 1.8,
          buttonWidth: ConfigSize.defaultSize! * 170,
          buttonPadding: EdgeInsets.only(
              left: ConfigSize.defaultSize!, right: ConfigSize.defaultSize!),
          buttonDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          itemHeight: ConfigSize.defaultSize! * 5,
          itemPadding: EdgeInsets.only(
              left: ConfigSize.defaultSize! * 1.8,
              right: ConfigSize.defaultSize! * 1.8),
          dropdownMaxHeight: ConfigSize.defaultSize! * 15,
          dropdownWidth: ConfigSize.defaultSize! * 18,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: ColorManager.lightGray.withOpacity(0.5),
          ),
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
        ),
      ),
    );
  }
}