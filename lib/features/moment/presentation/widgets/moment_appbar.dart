import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_moment/delete_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_moment/delete_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_info_row.dart';


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
    return Padding(
      padding:  EdgeInsets.symmetric(
        vertical: ConfigSize.defaultSize!*2
      ),
      child: SizedBox(
        width: ConfigSize.screenWidth!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: ConfigSize.defaultSize! * 35,
                child: MomentInfoRow(
                  momentModel: widget.momentModel,
                )),
            SizedBox(
              width: ConfigSize.defaultSize! * 4,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  customButton: Icon(
                    Icons.more_vert_rounded,
                    size: ConfigSize.defaultSize! * 2.5,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  dropdownDecoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  items: widget.momentModel.userId == MyDataModel.getInstance().id
                      ? [
                          ...MenuItems.myItems.map(
                            (item) => DropdownMenuItem<MenuItem>(
                              value: item,
                              child: MenuItems.buildItem(item),
                            ),
                          ),
                        ]
                      : [
                          ...MenuItems.othersItems.map(
                            (item) => DropdownMenuItem<MenuItem>(
                              value: item,
                              child: MenuItems.buildItem(item),
                            ),
                          ),
                        ],
                  onChanged: (value) {
                    MenuItems.onChanged(
                        context,
                        value!,
                        widget.momentModel.momentId.toString(),
                        widget.momentModel.userId.toString());
                  },
                  dropdownWidth: ConfigSize.defaultSize! * 12,
                ),
              ),
            ),
          ],
        ),
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
  static List<MenuItem> myItems = [
    delete,
  ];
  static List<MenuItem> othersItems = [
    report,
  ];

  static final delete =
      MenuItem(text: StringManager.delete.tr(), icon: Icons.delete_forever);
  static final report = MenuItem(
      text: StringManager.report.tr(), icon: Icons.report_problem_outlined);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.red.withOpacity(0.8), size: 22),
        SizedBox(
          width: ConfigSize.defaultSize!,
        ),
        Expanded(
          child: Text(
            item.text,
            style: TextStyle(
              color: Colors.red.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(
      BuildContext context, MenuItem item, String momentId, String userId) {
    if (item == delete) {
      BlocProvider.of<DeleteMomentBloc>(context).add(DeleteMomentEvent(momentId: momentId ));
      BlocProvider.of<GetMomentBloc>(context).add(LocalDeleteMomentEvent(momentId: momentId ));
      BlocProvider.of<GetMomentILikeItBloc>(context).add(LocalDeleteMomentILikedEvent(momentId: momentId ));

    } else if (item == report) {
      //BlocProvider.of<DeleteMomentBloc>(context).add(DeleteMomentEvent(momentId: momentId ));
    }
  }
}
