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
    return BlocListener<AddInfoBloc, AddInfoState>(
      listener: (context, state) {
        if(state is AddInfoSuccesMessageState){
          sucssesToast(context: context, title: StringManager.sucsses);
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
        }else if (state is AddInfoErrorMessageState) {
          errorToast(context: context, title: state.errorMessage);

        }else if (state is AddInfoLoadingState){
          loadingToast(context: context, title: StringManager.loading);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<GetMyDataBloc, GetMyDataState>(
          builder: (context, state) {
            if (state is GetMyDataSucssesState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const HeaderWithOnlyTitle(title: StringManager.editProfile),
                  const CompleteProfile(),
                  title(context: context, title: StringManager.personalInfo),
                  UserInfoWidget(myDataModel: state.myDataModel),
                  title(context: context, title: StringManager.addImage),
                  const AddProFilePic(),
                  MainButton(
                    onTap: () {
                             BlocProvider.of<AddInfoBloc>(context).add(AddInfoEvent(
                              bio:UserInfoWidget.bioController!.text ,
                        gender: myDataModel.profile!.gender!,
                        country: CountryWidget.countryFlag!,
                        name: UserInfoWidget.nameController!.text,
                      ));
                    },
                    title: StringManager.save,
                  )
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const HeaderWithOnlyTitle(title: StringManager.editProfile),
                  const CompleteProfile(),
                  title(context: context, title: StringManager.personalInfo),
                  UserInfoWidget(myDataModel: myDataModel),
                  title(context: context, title: StringManager.addImage),
                  const AddProFilePic(),
                  MainButton(
                    onTap: () {
               
                    },
                    title: StringManager.save,
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
