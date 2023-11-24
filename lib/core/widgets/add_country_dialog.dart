import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
 import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_state.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/get_all_country_bloc/get_all_country_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/get_all_country_bloc/get_all_country_event.dart';
 import 'package:tik_chat_v2/features/auth/presentation/widgets/country_drop_down_search.dart';
class AddCountryDialog extends StatefulWidget {
  const AddCountryDialog({super.key});

  @override
  State<AddCountryDialog> createState() => _AddCountryDialogState();
}

class _AddCountryDialogState extends State<AddCountryDialog> {
  @override
  void initState() {
    BlocProvider.of<GetAllCountriesBloc>(context).add(GetAllCountriesEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1),
      ),
      child: SizedBox(
        height: ConfigSize.screenHeight! * .4,
        width: ConfigSize.screenWidth!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(StringManager.pleaseAddYourCountry.tr()),
            SizedBox(height: ConfigSize.defaultSize! * 5,),
            CountryDropDownSearch(width: ConfigSize.screenWidth! * .7,),
            SizedBox(height: ConfigSize.defaultSize! * 5,),
            MainButton(
                onTap: () {
                  if (CountryDropDownSearch.selectedItem != null) {
                    BlocProvider.of<AddInfoBloc>(context).add(AddInfoEvent(
                        gender: MyDataModel.getInstance()
                            .profile!
                            .gender
                            .toString(),
                        name: MyDataModel.getInstance().name!,
                        countryID: CountryDropDownSearch.selectedItem!.id));
                  } else {
                    warningToast(
                        context: context,
                        title: StringManager.pleaseSelectYourCountry.tr());
                  }
                },
                height: ConfigSize.defaultSize! * 6,
                width: ConfigSize.defaultSize! * 12,
                title: StringManager.done.tr()),
          ],
        ),
      ),
    );

  }
}
