
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manager_delete_family/bloc/delete_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manager_delete_family/bloc/delete_family_event.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/family_manager/manager_delete_family/bloc/delete_family_state.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/get_my_data_manager/get_my_data_event.dart';


class DeleteScreen extends StatelessWidget {
  const DeleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteFamilyBloc, DeleteFamilyState>(
      listener: (context, state) {
        if (state is DeleteFamilySucssesStete) {
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.mainScreen, (route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                    size: ConfigSize.defaultSize! * 2.9,
                    Icons.arrow_back,
                    color: Colors.black)),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: ConfigSize.defaultSize! * 45.9,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(AssetsPath.warningIcon),
                )),
              ),
              SizedBox(
                width: ConfigSize.defaultSize! * 26.9,
                child: Text(
                  StringManager.areYouSureDeleteFamily,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: ConfigSize.defaultSize! * 2.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: ConfigSize.defaultSize! * 3.8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.red.shade400,
                          //maximumSize: const Size(10, 10),
                          fixedSize: Size(ConfigSize.defaultSize! * 14.9,
                              ConfigSize.defaultSize! * 4.9),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        BlocProvider.of<DeleteFamilyBloc>(context)
                            .add(const DeleteFamilyEvent(id: "1"));
                      },
                      child: const Text(
                        StringManager.yes,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          fixedSize: Size(ConfigSize.defaultSize! * 14.9,
                              ConfigSize.defaultSize! * 4.9),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        StringManager.no,
                        style: TextStyle(color: ColorManager.bage),
                      )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
