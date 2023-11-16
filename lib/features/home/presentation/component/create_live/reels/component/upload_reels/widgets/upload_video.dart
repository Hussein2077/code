

import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/trim_view.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({   super.key});


  @override
  State<UploadVideo> createState() => UploadVideoState();
}

class UploadVideoState extends State<UploadVideo> {




  String? _thumbnailPath;
     static String? video ;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()async{
       try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    
    if (result != null) {
      log("sucsses");
      String? filePath = result.files.single.path;
      if (filePath != null) {
             Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return TrimmerView(file:  File(result.files.single.path!) ,);
                  }),
                );
    _generateThumbnail(filePath);
      } else {
      }
    } else {
      // User canceled the file picking

    }
  } catch (error) {
    // Handle error
    log('Failed to pick video. Error: $error');
  }
      },
      child: 
      // _thumbnailPath != null
      //       ? Image.file(File(_thumbnailPath!))
      //       :

      Container(
          width: ConfigSize.defaultSize! * 3,
          height: ConfigSize.defaultSize! * 3,
          decoration: BoxDecoration(
              color: ColorManager.mainColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(
                  ConfigSize.defaultSize! * 3)),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: ConfigSize.defaultSize! * 3,
          )),
    );
  }
   Future<void> _generateThumbnail(String videoPath) async {
    try {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        maxHeight: 200,
        quality: 100,
      );

      setState(() {
        log("sucsses2");
        _thumbnailPath = thumbnailPath!;
      });
    } catch (e) {
      log('Failed to generate thumbnail: $e');
    }
  }
}