import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_vip_prev.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_state.dart';

import 'widget/main_prevalage_privecy_column.dart';

class PrivacySetting extends StatefulWidget {
  final MyDataModel myData;

  const PrivacySetting({Key? key, required this.myData}) : super(key: key);

  @override
  PrivacySettingState createState() => PrivacySettingState();
}

class PrivacySettingState extends State<PrivacySetting> {
  List<GetVipPrevModel>? tempData;

  int isFirst = 0;

  @override
  void initState() {
    BlocProvider.of<MangerGetVipPrevBloc>(context).add(getVipPrevEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrivacyBloc, PrivacyState>(
      listener: (context, state) {
        if (state is SucssesState) {
          BlocProvider.of<MangerGetVipPrevBloc>(context).add(getVipPrevEvent());
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
        } else if (state is ErrorState) {
          errorToast(context: context, title: state.massege.tr());
        } else if (state is LoadingState) {
          loadingToast(context: context, title: StringManager.loading.tr());
        }
      },
      builder: (context, state) {
        return BlocBuilder<MangerGetVipPrevBloc, MangerGetVipPrevState>(
          builder: (context, state) {
            if (state is GetVipPrevSucssesState) {
              isFirst++;
              tempData = state.data;

              print('${state.data[5].title!}huss');
              return Scaffold(
                body: Column(
                  children: [
                    HeaderWithOnlyTitle(
                      title: StringManager.settings.tr(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return state.data[index].key == 'room'
                              ? const SizedBox()
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ConfigSize.defaultSize! * 2),
                                  child: MainPravelagePrivecyColumn(
                                    prevalageName: state.data[index].title!,
                                    prevalageDescription:
                                        state.data[index].description!,
                                    state: state.data[index].isActive!,
                                    myData: widget.myData,
                                    isAllow: state.data[index].isAllowToUser!,
                                    keytype: state.data[index].key!,
                                  ),
                                );
                        },
                        itemCount: state.data.length,
                      ),
                    )
                  ],
                ),
              );
            } else {
              if (state is GetVipPrevLoadingState) {
                if (isFirst == 0) {
                  return const LoadingWidget();
                } else {
                  return  Scaffold(
                    body: Column(
                      children: [
                        HeaderWithOnlyTitle(
                          title: StringManager.settings.tr(),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return
                                tempData![index].key == 'room'
                                    ? const SizedBox()
                                    :  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ConfigSize.defaultSize! * 2),
                                      child: MainPravelagePrivecyColumn(
                                        prevalageName: tempData![index].title!,
                                        prevalageDescription:
                                            tempData![index].description!,
                                        state: tempData![index].isActive!,
                                        myData: widget.myData,
                                        isAllow:
                                            tempData![index].isAllowToUser!,
                                        keytype: tempData![index].key!,
                                      ),
                                    );
                            },
                            itemCount: tempData!.length,
                          ),
                        )
                      ],
                    ),
                  );
                }
              } else if (state is GetVipPrevErrorState) {
                return Scaffold(
                  body: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ConfigSize.screenWidth! * 0.3),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetsPath.serverError),
                          SizedBox(height: ConfigSize.screenHeight! * 0.1),
                          Text(
                            (state.error).toString().tr(),
                            style: const TextStyle(fontSize: 22),
                          ),
                        ]),
                  ),
                );
              } else {
                return Scaffold(
                  body: Center(
                      child: Column(
                    children: [
                      Text(
                        StringManager.unexcepectedError.tr(),
                      ),
                    ],
                  )),
                );
              }
            }
          },
        );
      },
    );
  }
}
