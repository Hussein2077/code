import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
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
  OwnerDataModel ? tempData ; 
  @override
  void initState() {
 //   BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
      body: LiquidPullToRefresh(
        color: ColorManager.bage,
        backgroundColor: ColorManager.mainColor,
        showChildOpacityTransition : false,

   onRefresh: ()async{
      BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
      
              },
        child: SingleChildScrollView(
            child: BlocBuilder<GetMyDataBloc, GetMyDataState>(
          builder: (context, state) {
         if (state is GetMyDataSucssesState){
          tempData = state.userData ;
             return  ProfileBody(myData: state.userData,);
         }
        else if (state is GetMyDataErrorState){
          //todo show toast here to show error
          return  ProfileBody(myData: getIt<OwnerDataModel>());
          }
         else if(state is GetMyDataLoadingState){
          return tempData==null? const LoadingWidget() :
          ProfileBody(myData: tempData!);
         }else {
           //todo update this ui
          return const CustoumErrorWidget(message: StringManager.unexcepectedError,);
         }
          },
        )),
      ),
    );
  }
}
