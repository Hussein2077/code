import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class AddVideoLivePic extends StatefulWidget {
  const AddVideoLivePic({super.key});

  @override
  State<AddVideoLivePic> createState() => _AddVideoLivePicState();
}

class _AddVideoLivePicState extends State<AddVideoLivePic> {
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
        child: Container(
          width: ConfigSize.defaultSize! * 8,
          height: ConfigSize.defaultSize! * 8,
          decoration: image != null
              ? BoxDecoration(
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
                  border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
                  image: DecorationImage(
                    image: FileImage(File(image!.path)),
                    fit: BoxFit.cover,
                  ),
                )
              : BoxDecoration(
                                      borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),

                  border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
                ),
        child:image != null? null: Center(child: Icon(Icons.add ,color: Colors.white , size: ConfigSize.defaultSize!*4,),),        
        ),
        
        
        );
  }
}