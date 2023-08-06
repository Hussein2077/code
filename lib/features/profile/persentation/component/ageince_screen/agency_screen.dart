import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_show_agency/show_agency_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_show_agency/show_agency_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_show_agency/show_agency_state.dart';

import 'widgets/owner_agency_body.dart';

class AgenceScreen extends StatelessWidget {
  const AgenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShowAgencyBloc>(context).add(ShowAgencyEvent());
    return Scaffold(
        body: ScreenBackGround(
            image: AssetsPath.agencyBackGround,
            child: BlocBuilder<ShowAgencyBloc, ShowAgencyState>(
              builder: (context, state) {
                if(state is ShowAgencySucssesState){
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
                        id: state.data.id.toString(),
                        image: state.data.image!),

                    const OwnerAgencyBody(),
                    // Expanded(child: MemberAgencyBody(owner: state.data.owner!,))
                  ],
                );
                }else if (state is ShowAgencyLoadingState) {
                  return const LoadingWidget();
                
                }else if (state is ShowAgencyErrorState){
                  return CustoumErrorWidget(message: state.error);
                }else {
                  return const CustoumErrorWidget(message: StringManager.unexcepectedError);
                }
              
              },
            )));
  }
}

Widget agencyCommanWidget(
    {required BuildContext context,
    required String id,
    required String agienceName,
    required String bio,
    required String image}) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            "   ID : $id",
            style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*1.7),
          ),
          const Spacer(flex: 4,),
          UserImage(
            image: image,
            imageSize: ConfigSize.defaultSize! * 7,
          ),
                    const Spacer(flex: 6,)

        ],
      ),
      Text(
        agienceName,
        style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*1.7),
      ),
      Text(
        bio,
        style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*1.7),
      ),
    ],
  );
}
