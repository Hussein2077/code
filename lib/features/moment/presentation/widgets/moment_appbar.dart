import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_info_row.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

class MomentAppBar extends StatefulWidget{
final MomentModel momentModel;
   const MomentAppBar({super.key,
     required this.momentModel,
  });

  @override
  State<MomentAppBar> createState() => _MomentAppBarState();
}

class _MomentAppBarState extends State<MomentAppBar> {
  List<String> global = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ConfigSize.screenWidth!,
      height: ConfigSize.defaultSize!*10,
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: ConfigSize.defaultSize!*35,
              height: ConfigSize.defaultSize!*10,
              child: MomentInfoRow(
            momentModel: widget.momentModel, comment: false,
              )),
          SizedBox(
            width: ConfigSize.defaultSize! * 4,
            height: ConfigSize.defaultSize! * 4,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton:  Icon(
                  Icons.more_vert_rounded,
                  size:ConfigSize.defaultSize! *2.5,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                items: [
                  ...MenuItems.firstItems.map(
                        (item) => DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
                  ),

                ],
                onChanged: (value) {
                  MenuItems.onChanged(context, value!);
                },
                dropdownWidth: ConfigSize.defaultSize!*12,


              ),
            ),


          ),





























        ],
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static  List<MenuItem> firstItems = [delete, report, ];


  static  final delete = MenuItem(text: StringManager.delete.tr(), icon: Icons.delete_forever);
  static final report = MenuItem(text: StringManager.report.tr(), icon: Icons.report_problem_outlined);


  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
         SizedBox(
          width: ConfigSize.defaultSize!,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    if (item == delete) {
      // Do something for delete
    } else if (item == report) {
      // Do something for report
    }
  }
}