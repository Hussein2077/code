import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_config_key.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/create_family/widgets/add_family_pic.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_create_family/bloc/create_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_create_family/bloc/create_family_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_create_family/bloc/create_family_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_config_key/get_config_keys_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_config_key/get_config_keys_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_config_key/get_config_keys_state.dart';

class CreateFamily extends StatefulWidget {
  const CreateFamily({super.key});

  @override
  State<CreateFamily> createState() => _CreateFamilyState();
}

class _CreateFamilyState extends State<CreateFamily> {
  late TextEditingController familyNameController;
  late TextEditingController familyBioController;

  @override
  void initState() {
    BlocProvider.of<GetConfigKeysBloc>(context)
        .add(const GetConfigKeyEvent(getConfigKeyPram: GetConfigKeyPram()));
    familyNameController = TextEditingController();
    familyBioController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    familyNameController.dispose();
    familyBioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateFamilyBloc, CreateFamilyState>(
      listener: (context, state) {
        if (state is CreateFamilySucssesState) {
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          Navigator.pushNamed(context, Routes.familyProfile , arguments: int.parse(state.id));
        } else if (state is CreateFamilyLoadingState) {
          loadingToast(context: context, title: StringManager.loading.tr());
        } else if (state is CreateFamilyErrorState) {
          errorToast(context: context, title: state.massage);
        }
      },
      child: SizedBox(
        height: ConfigSize.defaultSize! * 85,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: ConfigSize.defaultSize!,
                      ),
                      Text(
                        StringManager.createFamily.tr(),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(
                        height: ConfigSize.defaultSize!,
                      ),
                      const AddFamilyPic(),
                      SizedBox(
                        height: ConfigSize.defaultSize!,
                      ),
                      Text(StringManager.addImage.tr(),
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(
                        height: ConfigSize.defaultSize!,
                      ),
                    ],
                  ),
                ),
                Text(
                  StringManager.familyName.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: ConfigSize.defaultSize!,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: ConfigSize.defaultSize! * 5,
                  padding:
                      EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                  decoration: BoxDecoration(
                      color: ColorManager.lightGray,
                      borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize! * 2)),
                  child: TextFieldWidget(
                    controller: familyNameController,
                    hintText: StringManager.familyName.tr(),
                  ),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize!,
                ),
                Text(
                  StringManager.familyBio.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: ConfigSize.defaultSize!,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: ConfigSize.defaultSize! * 5,
                  padding:
                      EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                  decoration: BoxDecoration(
                      color: ColorManager.lightGray,
                      borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize! * 2)),
                  child: TextFieldWidget(
                    controller: familyBioController,
                    hintText: StringManager.familyBio.tr(),
                  ),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 4,
                ),
                BlocBuilder<GetConfigKeysBloc, GetConfigKeysState>(
                  builder: (context, state) {
                    if (state is GetConfigKeysSucsses) {
                      return createButton(
                        price: state.getConfigKey.familyPrice!,
                        context: context,
                        onTap: () {
                          if (AddFamilyPic.image == null) {
                            errorToast(
                                context: context,
                                title: StringManager.pleaseAddPhoto.tr());
                          } else if (familyNameController.text.isEmpty) {
                            errorToast(
                                context: context,
                                title: StringManager.pleaseEnterFamilyName.tr());
                          } else if (familyBioController.text.isEmpty) {
                            errorToast(
                                context: context,
                                title: StringManager.pleaseEnterFamilyBio.tr());
                          } else {
                            BlocProvider.of<CreateFamilyBloc>(context).add(
                                CreateFamilyEvent(
                                    name: familyNameController.text,
                                    bio: familyBioController.text,
                                    image: File(AddFamilyPic.image!.path)));
                          }
                        },
                      );
                    } else {
                      return const SizedBox();
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

Widget createButton(
    {required BuildContext context,
    required void Function()? onTap,
    required String price}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: ConfigSize.defaultSize! * 5.5,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: ColorManager.mainColorList,
                begin: Alignment.centerRight,
                end: Alignment.centerLeft),
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5)),
        child: Row(
          children: [
            const Spacer(
              flex: 5,
            ),
            Text(
              StringManager.createFamily.tr(),
              style: TextStyle(
                  color: ColorManager.whiteColor,
                  fontSize: ConfigSize.defaultSize! * 1.8,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(
              flex: 15,
            ),
            Text(
              price,
              style: TextStyle(
                  color: ColorManager.whiteColor,
                  fontSize: ConfigSize.defaultSize! * 1.8,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(
              flex: 1,
            ),
            Image.asset(
              AssetsPath.goldCoinIcon,
              scale: 10,
            ),
            const Spacer(
              flex: 5,
            ),
          ],
        )),
  );
}
