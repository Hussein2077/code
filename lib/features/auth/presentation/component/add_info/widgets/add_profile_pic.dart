import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class AddProFilePic extends StatefulWidget {
  const AddProFilePic({super.key});

  @override
  State<AddProFilePic> createState() => _AddProFilePicState();
}

class _AddProFilePicState extends State<AddProFilePic> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  Future<void> _getImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
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
                decoration: image != null
                    ? BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(File(image!.path)),
                          fit: BoxFit.cover,
                        ),
                      )
                    : BoxDecoration(
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
}
