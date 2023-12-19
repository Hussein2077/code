// import 'package:flutter/material.dart';
// import 'package:tik_chat_v2/core/model/user_data_model.dart';
// import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
// import 'package:tik_chat_v2/core/utils/config_size.dart';
// import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
// import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
// import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
// import 'package:tik_chat_v2/core/widgets/level_continer.dart';
// import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
// import 'package:tik_chat_v2/core/widgets/male_female_icon.dart';
// import 'package:tik_chat_v2/core/widgets/user_country_icon.dart';
// import 'package:tik_chat_v2/core/widgets/user_image.dart';
//
// class ParentScreen extends StatelessWidget {
//   final UserDataModel data;
//   final RequestState stateRequest;
//   final String message;
//
//   const ParentScreen({
//     super.key,
//     required this.data,
//     required this.stateRequest,
//     required this.message,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     switch (stateRequest) {
//       case RequestState.loaded:
//         return Scaffold(
//           body: SizedBox(
//             width: ConfigSize.screenWidth,
//             height: ConfigSize.screenHeight,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 UserImage(
//                   image: data.profile!.image ?? '',
//                   imageSize: ConfigSize.defaultSize! * 15,
//                   frame: data.frame,
//                   frameId: data.frameId,
//                 ),
//                 SizedBox(
//                   height: ConfigSize.defaultSize! * .5,
//                 ),
//                 GradientTextVip(
//                   typeUser: data.userType??0,
//                   text: data.name ?? "",
//                   textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                     fontSize: ConfigSize.defaultSize! * 1.6,
//                   ),
//                   isVip: data.hasColorName!,
//                 ),
//                 SizedBox(
//                   height: ConfigSize.defaultSize! * .5,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     MaleFemaleIcon(
//                       width: ConfigSize.defaultSize! * 4,
//                       height: ConfigSize.defaultSize! * 1.5,
//                       maleOrFeamle: data.profile!.gender,
//                       age: data.profile!.age,
//                     ),
//                     SizedBox(width: ConfigSize.defaultSize! * 0.2),
//                     if (!data.isCountryHiden!
//                     )
//                       UserCountryIcon(
//                           width: ConfigSize.defaultSize! * 3.5,
//                           height: ConfigSize.defaultSize! * 1.5,
//                           fontSize: ConfigSize.defaultSize! * 1.5,
//                           country: data.country?.flag??""),
//                     SizedBox(width: ConfigSize.defaultSize! * 0.2),
//                     if (data.level!.senderImage != '')
//                       LevelContainer(
//                         fit: BoxFit.fill,
//                         width: ConfigSize.defaultSize! * 4,
//                         height: ConfigSize.defaultSize! * 1.5,
//                         image: data.level!.senderImage
//                         !,
//                       ),
//                     if (data.vip1!.level != 0)
//                       AristocracyLevel(
//                         level: data.vip1!.level!,
//                       ),
//
//                   ],
//                 )
//
//
//               ],
//             ),
//           ),
//         );
//       case RequestState.loading:
//         return const LoadingWidget();
//       case RequestState.error:
//         return CustomErrorWidget(
//           message: message,
//         );
//     }
//   }
// }
