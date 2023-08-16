// //import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
// import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
// import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
// import 'package:tik_chat_v2/core/utils/config_size.dart';
// import 'package:tik_chat_v2/core/widgets/mian_button.dart';
// import 'package:tik_chat_v2/core/widgets/text_field.dart';
// import 'package:tik_chat_v2/features/home/presentation/component/create_live/video/widgets/add_video_live_pic.dart';
// import 'package:tik_chat_v2/features/home/presentation/component/create_live/voice/widget/public_privite_button.dart';
// import 'package:tik_chat_v2/features/home/presentation/component/create_live/voice/widget/room_type_button.dart';
//
// class CreateLiveVideoBody extends StatefulWidget {
//   static late List<CameraDescription> cameras;
//   const CreateLiveVideoBody({super.key});
//
//   @override
//   State<CreateLiveVideoBody> createState() => _CreateLiveVideoBodyState();
// }
//
// class _CreateLiveVideoBodyState extends State<CreateLiveVideoBody> {
//   late TextEditingController liveVideoNameController;
//   late CameraController cameraController;
//   int direction = 1;
//
//   @override
//   void initState() {
//     liveVideoNameController = TextEditingController();
//     cameraController = CameraController(
//       CreateLiveVideoBody.cameras[direction],
//       ResolutionPreset.max,
//     );
//     cameraController.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             // Handle access errors here.
//             break;
//           default:
//             // Handle other errors here.
//             break;
//         }
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         CameraPreview(cameraController),
//         Column(
//           children: [
//             SizedBox(
//               height: ConfigSize.defaultSize! * 4,
//             ),
//             header(
//               context: context,
//             ),
//             SizedBox(
//               height: ConfigSize.defaultSize! * 4,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width - 50,
//               height: ConfigSize.defaultSize! * 10,
//               decoration: BoxDecoration(
//                   borderRadius:
//                       BorderRadius.circular(ConfigSize.defaultSize! * 1.2),
//                   color: Colors.white.withOpacity(0.2)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   const AddVideoLivePic(),
//                   SizedBox(
//                       width: ConfigSize.defaultSize! * 20,
//                       child: TextFieldWidget(
//                         hintColor: Colors.white,
//                         textColor: Colors.white,
//                         controller: liveVideoNameController,
//                         hintText: StringManager.roomName,
//                       )),
//                   Icon(
//                     Icons.edit,
//                     color: Colors.white,
//                     size: ConfigSize.defaultSize! * 2,
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: ConfigSize.defaultSize! * 2,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: const [PublicPriveteButton(), RoomTypeButton()],
//             ),
//             SizedBox(
//               height: ConfigSize.defaultSize! * 4,
//             ),
//             const Spacer(),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                   padding: EdgeInsets.only(left: ConfigSize.defaultSize! * 2),
//                   child: Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             direction = direction == 0 ? 1 : 0;
//                             cameraController.setDescription(
//                                 CreateLiveVideoBody.cameras[direction]);
//                           });
//                         },
//                         child: livesButtons(
//                             icon: AssetsPath.flipIcon,
//                             title: StringManager.flip),
//                       ),
//                       SizedBox(
//                         height: ConfigSize.defaultSize! * 2,
//                       ),
//                       livesButtons(
//                           icon: AssetsPath.filtterIcon,
//                           title: StringManager.fillter)
//                     ],
//                   )),
//             ),
//             const Spacer(),
//             MainButton(
//               onTap: () {
//
//               },
//               title: StringManager.startLive,
//               buttonColornotList: ColorManager.darkPink,
//             ),
//             SizedBox(
//               height: ConfigSize.defaultSize! * 3,
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// Widget livesButtons({
//   required String icon,
//   required String title,
// }) {
//   return Column(
//     children: [
//       Image.asset(
//         icon,
//         scale: 2.5,
//       ),
//       Text(
//         title,
//         style: TextStyle(
//             color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.5),
//       )
//     ],
//   );
// }
//
// Widget header({required BuildContext context, void Function()? onTap}) {
//   return Row(
//     children: [
//       SizedBox(
//         width: ConfigSize.defaultSize,
//       ),
//       Container(
//         padding: EdgeInsets.all(ConfigSize.defaultSize! - 3),
//         decoration: BoxDecoration(
//             shape: BoxShape.circle, color: Colors.white.withOpacity(0.5)),
//         child: InkWell(
//             onTap: () => Navigator.pop(context),
//             child: Icon(
//               Icons.close,
//               color: Colors.white,
//               size: ConfigSize.defaultSize! * 2,
//             )),
//       ),
//       SizedBox(
//         width: ConfigSize.defaultSize!,
//       ),
//       Text(
//         StringManager.createLiveVideo,
//         style: TextStyle(
//             color: Colors.white, fontSize: ConfigSize.defaultSize! * 2),
//       ),
//     ],
//   );
// }
