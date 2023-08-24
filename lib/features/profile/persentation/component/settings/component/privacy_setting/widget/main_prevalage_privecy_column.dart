

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/component/privacy_setting/widget/diloge_for_privcy.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_event.dart';

class MainPravelagePrivecyColumn extends StatefulWidget {
  final String prevalageName;
  final String prevalageDescription;
  final bool isAllow;
  final bool state;
  final MyDataModel myData;
  final String keytype;

  const MainPravelagePrivecyColumn({
    super.key,
    required this.prevalageName,
    required this.prevalageDescription,
    required this.state,
    required this.myData,
    required this.isAllow,
    required this.keytype,
  });

  @override
  State<MainPravelagePrivecyColumn> createState() =>
      _MainPravelagePrivecyColumnState();
}

class _MainPravelagePrivecyColumnState
    extends State<MainPravelagePrivecyColumn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.prevalageName),
            Switch(
                activeColor: ColorManager.mainColor,
                value: widget.state,
                onChanged: (value) {
                  if (widget.state == false) {
                    setState(() {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DilogForPrivecyScreen(
                              flag: widget.isAllow,
                              buildContext: context,
                              confirm: () {
                                Navigator.pop(context);

                                BlocProvider.of<PrivacyBloc>(context)
                                    .add(AtivePrev(type: widget.keytype));
                              },
                              text: widget.isAllow
                                  ? StringManager.useTheFeatureAndEnjoyit.tr()
                                  : StringManager
                                      .thisFeatureisNotAvailableForYou
                                      .tr(),
                            );
                          });
                    });
                  } else {
                    BlocProvider.of<PrivacyBloc>(context)
                        .add(DisposeePrev(type: widget.keytype));
                  }
                })
          ],
        ),
        const Divider(),
        SizedBox(
          height: ConfigSize.defaultSize! * 0.5,
        ),
        Text(
          widget.prevalageDescription,
          style: Theme.of(context).textTheme.titleMedium,
          overflow: TextOverflow.clip,
        ),
        SizedBox(
          height: ConfigSize.defaultSize! * 0.5,
        ),
      ],
    );
  }

// Widget takeAction ({required String type}){
//   return DilogForPrivecyScreen(
//                                   flag:
//                                  widget.myData.vip1!.level! >
//                                       3
//                                       ? true
//                                       : false,
//                                   buildContext: context,
//                                   confirm: () {
//                                     Navigator.pop(context);

//                                     BlocProvider.of<PrivacyBloc>(
//                                         context)
//                                         .add(HideCountryEvent(
//                                         type: "country"));
//                                   },
//                                   text: "widget.prevalageVipRank",
//                                 );
// }
}



// Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(StringManager.hideCountry.tr()),
//                 Switch(
//                     activeColor: ColorManager.mainColorNotList,
//                     value: state.data.countryHidden!,
//                     onChanged: (value) {
//                       if (state.data.countryHidden == false) {
//                         setState(() {
//                           showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return DilogForPrivecyScreen(
//                                   flag:
//                                   widget.myData.vip1!.level! >
//                                       3
//                                       ? true
//                                       : false,
//                                   buildContext: context,
//                                   confirm: () {
//                                     Navigator.pop(context);
//
//                                     BlocProvider.of<PrivacyBloc>(
//                                         context)
//                                         .add(HideCountryEvent(
//                                         type: "country"));
//                                   },
//                                   text: StringManager
//                                       .privilegeVip4
//                                       .tr(),
//                                 );
//                               });
//                         });
//                       } else {
//                         BlocProvider.of<PrivacyBloc>(context).add(
//                             DisposeHideCountryEvent(
//                                 type: "country"));
//                       }
//                     })
//               ],
//             ),
//             const Divider(),
//             SizedBox(
//               height: ConfigSize.defaultSize! * 0.5,
//             ),
//             Text(StringManager.onProfilePage.tr(),
//               style: Theme.of(context).textTheme.titleMedium,
//               overflow: TextOverflow.clip,
//             ),
//             SizedBox(
//               height: ConfigSize.defaultSize! * 0.5,
//             ),
//           ],
//         ),