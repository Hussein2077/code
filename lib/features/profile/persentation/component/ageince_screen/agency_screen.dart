import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/ageince_screen/widgets/member_agency_body.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_show_agency/show_agency_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_show_agency/show_agency_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_show_agency/show_agency_state.dart';

import 'widgets/owner_agency_body.dart';

class AgenceScreen extends StatelessWidget {
 final OwnerDataModel mydata;
  const AgenceScreen({super.key,required this.mydata});

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
                  const HeaderWithOnlyTitle(title: StringManager.agency),

                  agencyCommanWidget(
                      context: context,
                      agienceName: state.data.name!,
                      bio: state.data.notice!,
                      id: state.data.owner!.uuid.toString(),
                      image: state.data.image!),
                   if(mydata.type == 2)
                    OwnerAgencyBody(myData: mydata),

                  if(mydata.type == 1)
                    Expanded(child: MemberAgencyBody(owner: state.data.owner!,))
                ],
              );
            } else if (state is ShowAgencyLoadingState) {
              return const LoadingWidget();
            } else if (state is ShowAgencyErrorState) {
              return CustoumErrorWidget(message: state.error);
            } else {
              return const CustoumErrorWidget(
                  message: StringManager.unexcepectedError);
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
             CircleAvatar(
              radius: ConfigSize.defaultSize!*3.5,
              backgroundImage: const AssetImage(AssetsPath.testImage),
            ),
            Text(
              "Name Agency :\n$agienceName",
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
