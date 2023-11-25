import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';

import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';

import 'package:tik_chat_v2/core/widgets/loading_widget.dart';

import 'package:tik_chat_v2/features/auth/data/model/country_model.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/get_all_country_bloc/get_all_country_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/get_all_country_bloc/get_all_country_states.dart';

class CountryDropDownSearch extends StatelessWidget {
  const CountryDropDownSearch({
    super.key, this.width,
  });
final double? width;
  static GetAllCountriesModel? selectedItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllCountriesBloc, GetAllCountriesStates>(
      builder: (context, state) {
        if (state is GetAllCountriesSuccessState) {
          return SizedBox(
            height: ConfigSize.defaultSize! * 7,
            width:width?? ConfigSize.screenWidth! * .8,
            child: DropdownSearch<GetAllCountriesModel>(
              asyncItems: (filter) async {
                return state.getAllCountriesModel.allCountiesSearch;
              },
              compareFn: (i, s) => i.name == (s.name),
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: true,

                searchFieldProps:   TextFieldProps(
                    decoration:InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
                      ),
                        hintText:StringManager.search.tr()
                    )
                ),
                itemBuilder: _customPopupItemBuilderExample2,
              ),
              dropdownBuilder: dropdownBuilder,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(

                    labelText: StringManager.country.tr(),
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          ConfigSize.defaultSize! * 3,

                        ),
                        gapPadding: 3)),
              ),
              onChanged: (print) {
                CountryDropDownSearch.selectedItem = print;
                CountryDropDownSearch.selectedItem=state.getAllCountriesModel.allCounties.firstWhere((element) => element.name==  CountryDropDownSearch.selectedItem!.name);
              },
              selectedItem: CountryDropDownSearch.selectedItem,
            ),
          );
        }
        if (state is GetAllCountriesLoading) {
          return SizedBox(
              height: ConfigSize.defaultSize! * 7,
              width: ConfigSize.defaultSize! * 5,
              child: const LoadingWidget());
        }
        if (state is GetAllCountriesError) {
          return ErrorWidget('');
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _customPopupItemBuilderExample2(BuildContext context, GetAllCountriesModel item,
      bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ConfigSize.defaultSize! * .8,
      ),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: ColorManager.darkBlack),
        borderRadius: BorderRadius.circular(
          ConfigSize.defaultSize! * .5,
        ),
        color:isSelected?Colors.grey: Colors.white,
      ),
      child: ListTile(
          selected: isSelected,
          title: Text(item.name,style: Theme.of(context).textTheme.bodyMedium,),
          subtitle: Text(item.eName.toString()),
          leading: BlocBuilder<GetAllCountriesBloc, GetAllCountriesStates>(
            builder: (context, state) {
              if(state is GetAllCountriesSuccessState) {

                return CustoumCachedImage(
                url:state.getAllCountriesModel.allCounties.firstWhere((element) => element.name==item.name).flag??"" ,
                height: ConfigSize.defaultSize! * 3,
                width: ConfigSize.defaultSize! * 3,
              );
              }
              if (state is GetAllCountriesLoading) {
                return SizedBox(
                    height: ConfigSize.defaultSize! * 3,
                    width: ConfigSize.defaultSize! * 3,
                    child: const LoadingWidget());
              }
              if (state is GetAllCountriesError) {
                return ErrorWidget('');
              } else {
                return const SizedBox();
              }
            },
          )),
    );
  }

  Widget dropdownBuilder(BuildContext context,
      GetAllCountriesModel? getAllCountriesModel) {
    return getAllCountriesModel == null
        ? const Text('')
        : Text('${getAllCountriesModel.eName} - ${getAllCountriesModel.name}');
  }
}
