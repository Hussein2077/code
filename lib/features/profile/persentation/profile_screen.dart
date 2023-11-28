import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';

import 'widget/profile_body.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  MyDataModel? tempData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        color: ColorManager.bage,
        backgroundColor: ColorManager.loadingColor,
        showChildOpacityTransition: false,
        onRefresh: () async {
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
        },
        child: SingleChildScrollView(
            child: BlocBuilder<GetMyDataBloc, GetMyDataState>(
          builder: (context, state) {
            if (state is GetMyDataSucssesState) {
              tempData = state.myDataModel;
              return ProfileBody(myData: state.myDataModel);
            } else if (state is GetMyDataErrorState) {
              //todo show toast here to show error
              return ProfileBody(myData: getIt<MyDataModel>());
            } else if (state is GetMyDataLoadingState) {
              return tempData == null
                  ? const LoadingWidget()
                  : ProfileBody(myData: tempData!);
            } else {
              //todo update this ui
              return CustomErrorWidget(
                message: StringManager.unexcepectedError.tr(),
              );
            }
          },
        )),
      ),
    );
  }
}
