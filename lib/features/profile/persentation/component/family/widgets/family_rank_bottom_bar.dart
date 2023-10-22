import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/create_family/create_family_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';

class FamilyRankBottomBar extends StatelessWidget {
  const FamilyRankBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMyDataBloc, GetMyDataState>(
      builder: (context, state) {
        if(state is GetMyDataSucssesState){
          if(state.myDataModel.familyId==0){
         return InkWell(
          onTap: () {
            bottomDailog(context: context, widget: const CreateFamily());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: ConfigSize.screenHeight! / 14,
            color: ColorManager.lightOrange,
            child: Center(
              child: Text(
                StringManager.createFamily.tr(),
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: ConfigSize.defaultSize! * 2),
              ),
            ),
          ),
        );
          }else {
            return InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.familyProfile , arguments: state.myDataModel.familyId);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: ConfigSize.screenHeight! / 14,

            color: ColorManager.lightOrange,
            child: Center(
              child: Text(
                StringManager.myFamily.tr(),
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: ConfigSize.defaultSize! * 2),
              ),
            ),
          ),
        );
          }
   
        }else {
          return const SizedBox();
        }
     
      },
    );
  }
}
