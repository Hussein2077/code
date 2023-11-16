// import 'dart:developer';
// import 'dart:io';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
// import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
// import 'package:tik_chat_v2/core/utils/config_size.dart';
// import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
// import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
// import 'package:tik_chat_v2/core/widgets/mian_button.dart';
// import 'package:tik_chat_v2/core/widgets/text_field.dart';
// import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
// import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
// import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_bloc.dart';
// import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_event.dart';
// import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_state.dart';
// import 'widgets/chose_topic_dailog.dart';
// import 'widgets/upload_video.dart';
//
// class UploadReelsScreen extends StatefulWidget {
//   const UploadReelsScreen({super.key});
//
//   @override
//   State<UploadReelsScreen> createState() => UploadReelsScreenState();
// }
//
// class UploadReelsScreenState extends State<UploadReelsScreen> {
//   late TextEditingController reelsNameController;
//   static List<int> selectedIntrest = [];
//   static List<String> selectedTopics = [];
//   static ValueNotifier<bool> hashtag = ValueNotifier<bool>(false);
//
//   @override
//   void initState() {
//     selectedIntrest = [];
//     selectedTopics = [];
//     reelsNameController = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Theme.of(context).colorScheme.background,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             HeaderWithOnlyTitle(title: StringManager.newReel.tr()),
//             shareYourMoment(context: context),
//              UploadVideo(),
//
//             CustomHorizntalDvider(
//               width: MediaQuery.of(context).size.width,
//               color: Colors.grey,
//             ),
//
//             // reelRowWidget(
//             //     context: context,
//             //     icon: AssetsPath.mentionIcon,
//             //     title: StringManager.mentionYourFriends.tr(),
//             //     widget: const MentionDailog()),
//
//             Column(
//               children: [
//                 reelRowWidget(
//                   context: context,
//                   icon: AssetsPath.hashTagIcon,
//                   title: StringManager.chooseTheTopic.tr(),
//                   widget: const ChooseTopicDailog(),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 ValueListenableBuilder<bool>(
//                   valueListenable: hashtag,
//                   builder: (context, b, _) {
//                     return SizedBox(
//                       height: ConfigSize.defaultSize!*15,
//                       width: MediaQuery.of(context).size.width,
//                       child: GridView.builder(
//                         itemCount: selectedTopics.length,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                 mainAxisSpacing: 6,
//                                  childAspectRatio: 4,
//                                   crossAxisCount: 3 ,
//                                   crossAxisSpacing: 20
//                                   ),
//                           itemBuilder: (context, index) {
//                             return Text(
//                               "  ${selectedTopics[index]}#",
//                               style: Theme.of(context).textTheme.bodyMedium,
//                             );
//                           }),
//                     );
//                   },
//                 ),
//               ],
//             ),
//
//             BlocBuilder<UploadReelsBloc, UploadReelsState>(
//               builder: (context, state) {
//                 if (state is UploadReelsLoadingState) {
//                   return MainButton(
//                       onTap: () {
//                         errorToast(
//                             context: context,
//                             title: StringManager.pleaseWaitReel.tr());
//                       },
//                       title: StringManager.loading.tr());
//                 } else {
//                   return MainButton(
//                       onTap: () async {
//                         if (UploadVideoState.video != null) {
//                           BlocProvider.of<UploadReelsBloc>(context).add(
//                               UploadReelsEvent(
//                                   categories: selectedIntrest,
//                                   description: reelsNameController.text,
//                                   reel: File(UploadVideoState.video!)));
//                           Navigator.pop(context);
//                         } else {
//                           errorToast(
//                               context: context,
//                               title: StringManager.pleaseChosseVideo.tr());
//                         }
//                       },
//                       title: StringManager.postTheVideo.tr());
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Widget shareYourMoment({required BuildContext context}) {
//   return Column(
//     children: [
//       Row(
//         children: [
//           SizedBox(
//             width: ConfigSize.defaultSize,
//           ),
//           Image.asset(
//             AssetsPath.reelVideoIcon,
//             scale: 2,
//           ),
//           SizedBox(
//             width: ConfigSize.defaultSize,
//           ),
//           Text(
//             StringManager.shareYourMoment.tr(),
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//         ],
//       ),
//       Text(
//         StringManager.yourVideoWillPublished.tr(),
//         style: Theme.of(context).textTheme.titleSmall,
//       ),
//     ],
//   );
// }
//
//
