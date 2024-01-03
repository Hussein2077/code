import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/add_or_delete_block/add_or_delete_block_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/add_or_delete_block/add_or_delete_block_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/add_or_delete_block/add_or_delete_block_state.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/profile_room_body_controler.dart';

class HeaderProfile extends StatelessWidget {
  final MyDataModel myDataModel;

  final bool myProfile;

  const HeaderProfile(
      {required this.myDataModel, required this.myProfile, super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      StringManager.block.tr(),
      StringManager.report.tr(),
    ];
    return BlocListener<AddOrDeleteBLockListBloc, AddOrDeleteBlockListState>(
      listener: (context, state) {
        if (state is AddBlockListSuccessState) {
          Navigator.pop(context);
          successSnackBar(context, state.message);
        } else if (state is DeleteBlockListErrorState) {
          errorSnackBar(context, state.errorMassage);
        } else if (state is DeleteBlockListLoadingState) {
          loadingSnackBar(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            headerIcon(
              icon: Icons.arrow_back_ios,
              onTap: () => Navigator.pop(context),
            ),
            myProfile
                ? headerIcon(
              icon: Icons.edit,
              onTap: () => Navigator.pushNamed(context, Routes.editInfo,
                  arguments: myDataModel),
            )
                : DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                items: items
                    .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: ConfigSize.defaultSize! * 1.4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                ))
                    .toList(),
                // value:RoomTypeButton.roomType ,
                onChanged: (value) {
                  if (value == StringManager.block.tr()) {
                    BlocProvider.of<AddOrDeleteBLockListBloc>(context)
                        .add(AddBlockListEvent(myDataModel
                        .convertToUserObject()
                        .id
                        .toString()));
                  } else if (value == StringManager.report.tr()) {
                    repoertsAction(
                        context: context,
                        userData: myDataModel.convertToUserObject());
                  }
                },
                icon: CircleAvatar(
                  backgroundColor:
                  ColorManager.whiteColor.withOpacity(.5),
                  // radius: ConfigSize.defaultSize! * 3,
                  child: Icon(
                    Icons.more_horiz_outlined,
                    size: ConfigSize.defaultSize! * 3,
                    color: ColorManager.whiteColor,
                  ),
                ),

                buttonHeight: ConfigSize.defaultSize! * 3,
                buttonWidth: ConfigSize.defaultSize! * 10,
                buttonDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                itemHeight: ConfigSize.defaultSize! * 5,
                itemPadding: EdgeInsets.only(
                    left: ConfigSize.defaultSize! * 1.8,
                    right: ConfigSize.defaultSize! * 1.8),
                dropdownMaxHeight: ConfigSize.defaultSize! * 15,
                dropdownWidth: ConfigSize.defaultSize! * 10,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    ConfigSize.defaultSize!,
                  ),
                  color: ColorManager.gray.withOpacity(0.7),
                ),
                scrollbarRadius: Radius.circular(
                  ConfigSize.defaultSize! * 4,
                ),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                offset: const Offset(-20, 0),
              ),
            ),
            // headerIcon(icon: Icons.report_problem_outlined ,onTap: () =>  )
          ],
        ),
      ),
    );
  }
}

Widget headerIcon(
    {required IconData icon, void Function()? onTap, double? size}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 2),
      padding: EdgeInsets.all(ConfigSize.defaultSize! - 3),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5), shape: BoxShape.circle),
      child: Icon(
        icon,
        color: Colors.white,
        size: size ?? ConfigSize.defaultSize! * 1.7,
      ),
    ),
  );
}
