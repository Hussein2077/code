import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class AddFamilyPic extends StatefulWidget {
  static   XFile? image;

  const AddFamilyPic({super.key});

  @override
  State<AddFamilyPic> createState() => _AddFamilyPicState();
}

class _AddFamilyPicState extends State<AddFamilyPic> {
  final ImagePicker picker = ImagePicker();
  Future<void> _getImage() async {
    AddFamilyPic.image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _getImage();
        },
        child: SizedBox(
          width: ConfigSize.defaultSize! * 10.4,
          height: ConfigSize.defaultSize! * 10.4,
          child: Stack(
            children: [
              Container(
                width: ConfigSize.defaultSize! * 10,
                height: ConfigSize.defaultSize! * 10,
                decoration: AddFamilyPic.image != null
                    ? BoxDecoration(
                        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(File(AddFamilyPic.image!.path)),
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