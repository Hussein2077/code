import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_show_agency/show_agency_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_show_agency/show_agency_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_show_agency/show_agency_state.dart';

import 'widgets/owner_agency_body.dart';

class AgenceScreen extends StatefulWidget {
 final MyDataModel mydata;
  const AgenceScreen({super.key,required this.mydata});

  @override
  State<AgenceScreen> createState() => _AgenceScreenState();
}

class _AgenceScreenState extends State<AgenceScreen> {
  @override
  void initState() {
    BlocProvider.of<MyStoreBloc>(context).add(GetMyStoreEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShowAgencyBloc>(context).add(ShowAgencyEvent());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<ShowAgencyBloc, ShowAgencyState>(
          builder: (context, state) {
            if (state is ShowAgencySucssesState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: ConfigSize.defaultSize! * 3.5,
                  ),
                   HeaderWithOnlyTitle(title: StringManager.agency.tr()),

                  agencyCommanWidget(
                      context: context,
                      agienceName: state.data.name!,
                      bio: state.data.notice!,
                      id: state.data.id!.toString(),
                      image: state.data.image!),
                  //  if(mydata.myType == 2)
                    OwnerAgencyBody(myData: widget.mydata),

                  // if(mydata.myType == 1)
                  //   Expanded(child: MemberAgencyBody(owner: state.data.owner!,))
                ],
              );
            } else if (state is ShowAgencyLoadingState) {
              return const LoadingWidget();
            } else if (state is ShowAgencyErrorState) {
              return CustomErrorWidget(message: state.error);
            } else {
              return  CustomErrorWidget(
                  message: StringManager.unexcepectedError.tr());
            }
          },
        ));
  }
}

Widget agencyCommanWidget(
    {required BuildContext context,
    required String id,
    required String agienceName,
    required String bio,
    required String image}) {
  return Container(
    height: ConfigSize.defaultSize!*20.2,
    width: MediaQuery.of(context).size.width/1.1,
    padding: EdgeInsets.symmetric(
        vertical: ConfigSize.defaultSize!*1.5,
        horizontal: ConfigSize.defaultSize!*1.5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: ColorManager.bage,

    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            UserImage(
              image: image,
              imageSize:  ConfigSize.defaultSize! * 8.75,
              boxFit: BoxFit.cover,
            ),

            /*
             CircleAvatar(
              radius: ConfigSize.defaultSize!*3.5,
              backgroundImage: const AssetImage(AssetsPath.testImage),
            ),*/
            Text(
              "${StringManager.nameAgency.tr()}:\n$agienceName",
              style:TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*1.7),
            ),

          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [

            Text(
              "ID : $id",
              style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*1.7),
            ),
            Text(
              "Bio :$bio",
              style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*1.7),
            ),

          ],
        ),
      ],
    ),
  );
}
