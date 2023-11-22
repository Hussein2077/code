import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/add_profile_pic.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/country_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/edit_info/widget/compelete_profile.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';
import 'widget/user_info_widget.dart';

class EditInfoScreen extends StatelessWidget {
  final MyDataModel myDataModel;
  const EditInfoScreen({required this.myDataModel, super.key});

  @override
  Widget build(BuildContext context) {
    double percent = completeProfile(myDataModel: myDataModel);

    return BlocListener<AddInfoBloc, AddInfoState>(
      listener: (context, state) {
        if (state is AddInfoSuccesMessageState) {
          sucssesToast(context: context, title: StringManager.sucsses.tr());
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state is AddInfoErrorMessageState) {
          errorToast(context: context, title: state.errorMessage);
        } else if (state is AddInfoLoadingState) {
          loadingToast(context: context, title: StringManager.loading.tr());
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<GetMyDataBloc, GetMyDataState>(
          builder: (context, state) {
            if (state is GetMyDataSucssesState) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HeaderWithOnlyTitle(title: StringManager.editProfile.tr()),
                      CompleteProfile(percent: percent),
                      const AddProFilePic(
                        quality: 40,
                      ),
                      title(context: context, title: StringManager.personalInfo.tr()),
                      UserInfoWidget(myDataModel: state.myDataModel),
                      // title(context: context, title: StringManager.addImage.tr()),

                      MainButton(
                        onTap: () {
                          BlocProvider.of<AddInfoBloc>(context).add(AddInfoEvent(
                              bio: UserInfoWidget.bioController!.text,
                              date: UserInfoWidget.age == null ? null : UserInfoWidget.age!,
                              gender: UserInfoWidget.gender!.toString(),
                              name: UserInfoWidget.nameController!.text,
                              image: AddProFilePic.image == null
                                  ? null
                                  : File(AddProFilePic.image!.path), countryID: 0));
                        },
                        title: StringManager.save.tr(),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HeaderWithOnlyTitle(title: StringManager.editProfile.tr()),
                  CompleteProfile(percent: percent),
                  const AddProFilePic(quality: 40,),

                  title(context: context, title: StringManager.personalInfo.tr()),
                  UserInfoWidget(myDataModel: myDataModel),
                  // title(context: context, title: StringManager.addImage.tr()),
                  MainButton(
                    onTap: () {},
                    title: StringManager.save.tr(),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

Widget title({required BuildContext context, required String title}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(
        vertical: ConfigSize.defaultSize!, horizontal: ConfigSize.defaultSize!),
    color: Theme.of(context).colorScheme.secondary,
    child: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
    ),
  );
}

double completeProfile({required MyDataModel myDataModel}) {
  double name = (myDataModel.name == "" || myDataModel.name == null) ? 0 : 0.2;
  double bio = (myDataModel.bio == "" || myDataModel.bio == null) ? 0 : 0.2;
  double country = (myDataModel.profile!.country == "" ||
          myDataModel.profile!.country == null)
      ? 0
      : 0.2;
  double image =
      (myDataModel.profile!.image == "" || myDataModel.profile!.image == null)
          ? 0
          : 0.2;
  return 0.2 + name + bio + country + image;
}
