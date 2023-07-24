import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
      body: SingleChildScrollView(child: BlocBuilder<GetMyDataBloc, GetMyDataState>(
        builder: (context, state) {
       if (state is GetMyDataSucssesState){
          return CustoumErrorWidget(message: "state",);
           return const ProfileBody();
       }
      else if (state is GetMyDataErrorState){
        return CustoumErrorWidget(message: state.errorMassage,);
        }
       else {
        return const LoadingWidget();

       }
        },
      )),
    );
  }
}
