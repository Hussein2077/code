import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';

class AddGenderDialog extends StatefulWidget {
  const AddGenderDialog({super.key});

  @override
  State<AddGenderDialog> createState() => _AddGenderDialogState();
}

class _AddGenderDialogState extends State<AddGenderDialog> {
  String selectedGender = "male";

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddInfoBloc, AddInfoState>(
      listener: (context, state) {
        if (state is AddInfoSuccesMessageState) {
          Navigator.pop(context);
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
        } else if (state is AddInfoErrorMessageState) {
          errorToast(context: context, title: state.errorMessage);
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1),
        ),
        child: SizedBox(
          height: ConfigSize.screenHeight! * .25,
          width: ConfigSize.screenWidth!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(StringManager.pleaseAddYourGender.tr()),
              SizedBox(
                height: ConfigSize.defaultSize! * 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectedGender = "male";
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedGender == "male"
                              ? ColorManager.lightBlue
                              : ColorManager.lightGray,
                          borderRadius: BorderRadius.only(
                            bottomLeft:
                                Radius.circular(ConfigSize.defaultSize! * 3),
                            topLeft:
                                Radius.circular(ConfigSize.defaultSize! * 3),
                          )),
                      width: (MediaQuery.of(context).size.width - 50) / 3,
                      height: ConfigSize.defaultSize! * 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringManager.male.tr(),
                            style: TextStyle(
                                color: selectedGender == "male"
                                    ? ColorManager.blue
                                    : Colors.grey,
                                fontSize: ConfigSize.defaultSize! * 1.8),
                          ),
                          SizedBox(
                            width: ConfigSize.defaultSize,
                          ),
                          Image.asset(selectedGender == "male"
                              ? AssetsPath.maleIcon
                              : AssetsPath.unSelectedMaleIcon)
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedGender = "female";
                      setState(() {});
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 50) / 3,
                      height: ConfigSize.defaultSize! * 6,
                      decoration: BoxDecoration(
                        color: selectedGender == "female"
                            ? ColorManager.lightPink
                            : ColorManager.lightGray,
                        borderRadius: BorderRadius.only(
                          bottomRight:
                              Radius.circular(ConfigSize.defaultSize! * 3),
                          topRight:
                              Radius.circular(ConfigSize.defaultSize! * 3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringManager.female.tr(),
                            style: TextStyle(
                                color: selectedGender == "female"
                                    ? ColorManager.pink
                                    : Colors.grey,
                                fontSize: ConfigSize.defaultSize! * 1.8),
                          ),
                          SizedBox(
                            width: ConfigSize.defaultSize,
                          ),
                          Image.asset(selectedGender == "female"
                              ? AssetsPath.femaleIcon
                              : AssetsPath.unSelectedFemaleIcon)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 3,
              ),
              InkWell(
                onTap: () {
                  BlocProvider.of<AddInfoBloc>(context).add(AddInfoEvent(
                    gender: selectedGender == "male" ? 1 : 0,
                  ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ConfigSize.defaultSize! * 5.2),
                  width: ConfigSize.defaultSize! * 15,
                  height: ConfigSize.defaultSize! * 3.5,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: ColorManager.mainColorList),
                      borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize! * 1.0)),
                  child: Center(
                    child: Text(
                      StringManager.done.tr(),
                      style: const TextStyle(
                          color: ColorManager.whiteColor,
                          fontSize: 18,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
