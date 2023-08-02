import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/vip_center_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';

import 'vip_bottom_bar.dart';
import 'vip_dailog.dart';

class VipTabView extends StatelessWidget {
  final VipCenterModel vipData;
  final String vipIcon;
  const VipTabView({required this.vipData, required this.vipIcon, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          vipIcon,
          scale: 2.5,
        ),
        SizedBox(
          height: ConfigSize.defaultSize! * 3,
        ),
        BlocBuilder<GetMyDataBloc, GetMyDataState>(
          builder: (context, state) {
            if(state is GetMyDataSucssesState){
              if(vipData.level == state.userData.vip1!.level){
 return Text(
              "${StringManager.youAreVip}  ${vipData.level.toString()}",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: ConfigSize.defaultSize! * 1.7),
            );
              }else {
                 return Text(
              StringManager.buyToEnjoy.tr(),
              style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: ConfigSize.defaultSize! * 1.7),
            );
              }
 
            }else {
                return Text(
              StringManager.buyToEnjoy.tr(),
              style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: ConfigSize.defaultSize! * 1.7),
            );
            }
          
          },
        ),
        SizedBox(
          height: ConfigSize.defaultSize! * 3,
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ConfigSize.defaultSize! * 4),
                    topRight: Radius.circular(ConfigSize.defaultSize! * 4))),
            child: Column(
              children: [
                SizedBox(
                  height: ConfigSize.defaultSize! * 2,
                ),
                Text(
                  StringManager.advantages.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                CustomHorizntalDvider(
                  width: ConfigSize.defaultSize! * 2,
                  color: ColorManager.orang,
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: vipData.privilgesData!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 1.2),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return VipDailog(
                                    title: vipData
                                        .privilgesData![index].item!.title!,
                                    headerText: vipData
                                        .privilgesData![index].item!.name!,
                                    image: vipData
                                        .privilgesData![index].item!.image!,
                                  );
                                });
                          },
                          child: privilgesVipIcon(
                              context: context, index: index, vipData: vipData),
                        );
                      }),
                ),
                VipBottomBar(
                  expire: vipData.expire.toString(),
                  id: vipData.id.toString(),
                  price: vipData.price.toString(),
                  name: vipData.name.toString(),
                  vipBadge: vipIcon,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget privilgesVipIcon(
    {required BuildContext context,
    required VipCenterModel vipData,
    required index}) {
  return Column(
    children: [
      Container(
        width: ConfigSize.defaultSize! * 5,
        height: ConfigSize.defaultSize! * 5,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(vipData
                        .privilgesData![index].active
                    ? ConstentApi().getImage(vipData.privilgesData![index].img1)
                    : ConstentApi()
                        .getImage(vipData.privilgesData![index].img2)))),
      ),
      SizedBox(
        height: ConfigSize.defaultSize!,
      ),
      Text(
        vipData.privilgesData![index].name,
        style: Theme.of(context).textTheme.bodySmall,
      )
    ],
  );
}
