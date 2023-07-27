import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';


class AddProFilePic extends StatefulWidget {
 final String? gooleImageUrl ;
  const AddProFilePic({this.gooleImageUrl, super.key});
    static XFile? image;
  static File? googleImage; 

  @override
  State<AddProFilePic> createState() => _AddProFilePicState();
}

class _AddProFilePicState extends State<AddProFilePic> {

  final ImagePicker picker = ImagePicker();


@override
  void initState() {
    if(widget.gooleImageUrl!=null){
 getGoogleImage();
    }
    
    super.initState();
  }

  Future<void> getGoogleImage() async{
    AddProFilePic.googleImage = await getImageFileFromNetwork(widget.gooleImageUrl!);
        setState(() {});

  }

  Future<void> _getImage() async {
    
    AddProFilePic.image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _getImage();
        },
        child: SizedBox(
          width: ConfigSize.defaultSize! * 11.4,
          height: ConfigSize.defaultSize! * 11.4,
          child: Stack(
            children: [
              Container(
                width: ConfigSize.defaultSize! * 11,
                height: ConfigSize.defaultSize! * 11,
                decoration: AddProFilePic.image != null
                    ? BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(File(AddProFilePic.image!.path)),
                          fit: BoxFit.cover,
                        ),
                      )
                    :AddProFilePic.googleImage!=null?
                    BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(AddProFilePic.googleImage!),
                          fit: BoxFit.cover,
                        ),
                      ):
                    
                     BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                        shape: BoxShape.circle,
                      ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: ConfigSize.defaultSize! * 4,
                  height: ConfigSize.defaultSize! * 4,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: ColorManager.mainColorList,
                          begin: Alignment.topLeft)),
                  child: Icon(
                    size: ConfigSize.defaultSize! * 1.8,
                    Icons.camera_alt,
                    color: ColorManager.whiteColor,
                  ),
                ),
              )
            ],
          ),
        ));
  }



  Future<File> getImageFileFromNetwork(String imageUrl) async {
  var response = await Dio().get(imageUrl,
      options: Options(responseType: ResponseType.bytes));
          final dir = await getTemporaryDirectory();
          var filename = '${dir.path}/image.png';

   final file = File(filename);
    await file.writeAsBytes(response.data);
  return file;
}
}
