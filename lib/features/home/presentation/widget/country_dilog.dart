import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/home/data/model/country_model.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/country_manager/counrty_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/country_manager/counrty_event.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/country_manager/counrty_state.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_events.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/country_icon.dart';

import 'body/aduio/audio_body.dart';

class CountryDialog extends StatefulWidget {
  static ValueNotifier<bool> selectedCountry = ValueNotifier<bool>(false);
  static String? flag;
  static String? name;

  const CountryDialog({Key? key}) : super(key: key);

  @override
  State<CountryDialog> createState() => _CountryDialogState();
}

class _CountryDialogState extends State<CountryDialog> {
  @override
  void initState() {
    BlocProvider.of<CounrtyBloc>(context).add(GetAllCountryEvent());
    super.initState();
  }

  List<CountryModel>? tempData;
  int isFirst = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .7,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ConfigSize.defaultSize! * 1.5),
                  topRight: Radius.circular(ConfigSize.defaultSize! * 1.5))),
          child: BlocBuilder<CounrtyBloc, CountryStates>(
            builder: (context, state) {
              if (state is CountrySuccesMessageState) {
                isFirst++;
                tempData = state.countrys;
                return SizedBox(
                  width: ConfigSize.defaultSize! * 10,
                  height: ConfigSize.defaultSize! * 14,
                  child: Padding(
                      padding: EdgeInsets.all(ConfigSize.defaultSize!),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 5,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10),
                          itemCount: state.countrys.length + 1,
                          itemBuilder: (BuildContext ctx, index) {
                            return InkWell(
                              onTap: () {
                                if (index == 0) {
                                  AduioBody.type = StringManager.popular;
                                  AduioBody.countryId = null;
                                  CountryDialog.flag = AssetsPath.fireIcon;
                                  CountryDialog.name =
                                      StringManager.popular.tr();
                                  BlocProvider.of<GetRoomsBloc>(context).add(
                                      GetRoomsEvent(
                                          typeGetRooms: TypeGetRooms.popular));
                                } else {
                                  AduioBody.type = "country_id";
                                  AduioBody.countryId =
                                      state.countrys[index - 1].id;
                                  CountryDialog.flag =
                                      state.countrys[index - 1].flag;
                                  CountryDialog.name =
                                      state.countrys[index - 1].name;
                                  BlocProvider.of<GetRoomsBloc>(context).add(
                                      GetRoomsEvent(
                                          countryId:
                                              state.countrys[index - 1].id));
                                }

                                CountryDialog.selectedCountry.value =
                                    !CountryDialog.selectedCountry.value;
                                Navigator.pop(context);
                              },
                              child: index == 0
                                  ? CountryIcon(
                                      color: Colors.grey.withOpacity(0.6),
                                      flag: AssetsPath.fireIcon,
                                      name: StringManager.popular.tr())
                                  : CountryIcon(
                                      color: Colors.grey.withOpacity(0.6),
                                      flag: state.countrys[index - 1].flag,
                                      name: state.countrys[index - 1].name),
                            );
                          })),
                );
              } else if (state is CountryLoadingState) {
                if (isFirst == 0) {
                  return const LoadingWidget();
                } else {
                  return SizedBox(
                  width: ConfigSize.defaultSize! * 10,
                  height: ConfigSize.defaultSize! * 14,
                  child: Padding(
                      padding: EdgeInsets.all(ConfigSize.defaultSize!),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 5,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10),
                          itemCount: tempData!.length + 1,
                          itemBuilder: (BuildContext ctx, index) {
                            return InkWell(
                              onTap: () {
                                if (index == 0) {
                                  AduioBody.type = StringManager.popular;
                                  AduioBody.countryId = null;
                                  CountryDialog.flag = AssetsPath.fireIcon;
                                  CountryDialog.name =
                                      StringManager.popular.tr();
                                  BlocProvider.of<GetRoomsBloc>(context).add(
                                      GetRoomsEvent(
                                          typeGetRooms: TypeGetRooms.popular));
                                } else {
                                  AduioBody.type = "country_id";
                                  AduioBody.countryId = tempData![index - 1].id;
                                  CountryDialog.flag =
                                      tempData![index - 1].flag;
                                  CountryDialog.name =
                                      tempData![index - 1].name;
                                  BlocProvider.of<GetRoomsBloc>(context).add(
                                      GetRoomsEvent(
                                          countryId: tempData![index - 1].id));
                                }

                                CountryDialog.selectedCountry.value =
                                    !CountryDialog.selectedCountry.value;
                                Navigator.pop(context);
                              },
                              child: index == 0
                                  ? CountryIcon(
                                      color: Colors.grey.withOpacity(0.6),
                                      flag: AssetsPath.fireIcon,
                                      name: StringManager.popular.tr())
                                  : CountryIcon(
                                      color: Colors.grey.withOpacity(0.6),
                                      flag: tempData![index - 1].flag,
                                      name: tempData![index - 1].name),
                            );
                          })),
                );
                }
              } else if (state is CountryErrorMessageState) {
                return CustomErrorWidget(
                  message: state.errorMessage,
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
