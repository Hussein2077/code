// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/data/model/country_model.dart';
import 'package:tik_chat_v2/features/auth/data/model/third_party_auth_model.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_state.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/get_all_country_bloc/get_all_country_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/get_all_country_bloc/get_all_country_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/country_drop_down_search.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'widgets/add_profile_pic.dart';
import 'widgets/continer_with_icons.dart';
import 'widgets/date/date_widget.dart';
import 'widgets/male_female_buttons.dart';

class AddInfoScreen extends StatefulWidget {
  ThirdPartyAuthModel? Data;

  AddInfoScreen({
    this.Data,
    super.key,
  });

  @override
  State<AddInfoScreen> createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  late TextEditingController nameController;

  @override
  void initState() {
    SnackBar snackBar = SnackBar(
      content: widget.Data?.isAgeNotComplete == true &&
              widget.Data?.isCountryNotComplete == true
          ?  Text(StringManager.pleaseCompleteYourInfoAgeAndCountry.tr())
          : Text(widget.Data?.isAgeNotComplete == true
              ? StringManager.pleaseCompleteYourInfoAge.tr()
              : StringManager.pleaseCompleteYourInfoCountry.tr()),
    );
    nameController = TextEditingController();
    if (widget.Data != null) {
      if (widget.Data!.type.toString() == "google") {
        if (widget.Data!.data.displayName != null) {
          nameController.text = widget.Data!.data.displayName!;
        }
      }
      if (widget.Data!.type.toString() == "apple") {
        if (widget.Data!.data.givenName != null) {
          nameController.text = widget.Data!.data.givenName!;
        }
      }
    }
    BlocProvider.of<GetAllCountriesBloc>(context).add(GetAllCountriesEvent());
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.Data?.isAgeNotComplete == true ||
          widget.Data?.isCountryNotComplete == true) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddInfoBloc, AddInfoState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
               HeaderWithOnlyTitle(
                title: StringManager.completeYourAccount.tr(),
              ),
              const Spacer(
                flex: 1,
              ),
              AddProFilePic(
                gooleImageUrl: widget.Data?.type.toString() == "google"
                    ? widget.Data?.data.photoUrl
                    : (MyDataModel.getInstance().profile?.image),
                quality: 100,
              ),
              const Spacer(
                flex: 1,
              ),
              Text(
                StringManager.postYourBestPhoto.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(
                flex: 2,
              ),
              ContinerWithIcons(
                  icon1: Icons.person,
                  widget: SizedBox(
                    width: ConfigSize.defaultSize! * 25,
                    child: TextField(
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: ConfigSize.defaultSize! * 1.7),
                      autofocus: false,
                      controller: nameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: MyDataModel.getInstance().name ??
                              StringManager.userName.tr(),
                          hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                  )),
              const Spacer(
                flex: 1,
              ),
              const DateWidget(),
              const Spacer(
                flex: 1,
              ),
              const CountryDropDownSearch(),
              const Spacer(
                flex: 1,
              ),
              const MaleFemaleButtons(),
              const Spacer(
                flex: 4,
              ),
              MainButton(
                  onTap: () {
                    bool result = valadate();
                    if (result) {
                      if (Methods().calculateAge(DateWidget.selectedDatee) >=
                          18) {
                        BlocProvider.of<AddInfoBloc>(context).add(AddInfoEvent(
                            image: AddProFilePic.image == null
                                ? AddProFilePic.googleImage
                                : File(AddProFilePic.image!.path),
                            gender: MaleFemaleButtons.selectedGender == "male"
                                ? "1"
                                : "0",
                            name: nameController.text,
                            date: DateWidget.selectedDatee,
                            countryID:CountryDropDownSearch. selectedItem!.id));
                      } else {
                        errorToast(
                          context: context,
                          title: StringManager.yourAgeIsUnder18.tr(),
                        );
                      }
                    }
                  },
                  title: StringManager.done.tr()),
              const Spacer(
                flex: 1,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsPath.warningIcon,
                    scale: 1.4,
                  ),
                  SizedBox(
                    width: ConfigSize.defaultSize,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text(
                      StringManager.youCanNotModify.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                ],
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is AddInfoSuccesMessageState) {
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          Navigator.pushNamed(context, Routes.mainScreen);

        } else if (state is AddInfoErrorMessageState) {
          errorToast(context: context, title: state.errorMessage);
        }
      },
    );
  }

  bool valadate() {
    if (AddProFilePic.googleImage == null &&
        AddProFilePic.image == null &&
       (MyDataModel.getInstance().profile==null?true: MyDataModel.getInstance().profile!.image == '')) {
      warningToast(context: context, title: StringManager.pleaseAddPhoto.tr());
      return false;
    } else if (nameController.text.isEmpty &&
        MyDataModel.getInstance().name == null) {
      warningToast(
          context: context, title: StringManager.pleaseEnterYourName.tr());
      return false;
    } else if (DateWidget.selectedDatee == StringManager.birthdayDate) {
      warningToast(
          context: context, title: StringManager.pleaseEnterYourBirthDate);

      return false;
    } else if (CountryDropDownSearch.selectedItem == null) {
      warningToast(
          context: context, title: StringManager.pleaseSelectYourCountry);
      return false;
    } else {
      return true;
    }
  }


}
