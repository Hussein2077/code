// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:tik_chat_v2/features/reels/persentation/widgets/trim_view.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video Trimmer"),
//       ),
//       body: Center(
//         child: Container(
//           child: ElevatedButton(
//             child: Text("LOAD VIDEO"),
//             onPressed: () async {
//               FilePickerResult? result = await FilePicker.platform.pickFiles(
//                 type: FileType.video,
//                 allowCompression: false,
//               );
//               if (result != null) {
//                 File file = File(result.files.single.path!);
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) {
//                     return TrimmerView(file);
//                   }),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }