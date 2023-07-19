import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/config_sizee.dart';

class AddScreenShot extends StatefulWidget {
  const AddScreenShot({super.key});

  @override
  State<AddScreenShot> createState() => _AddScreenShotState();
}

class _AddScreenShotState extends State<AddScreenShot> {
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
          width: ConfigSize.defaultSize! * 11,
          height: ConfigSize.defaultSize! * 11,
          decoration: image != null
              ? BoxDecoration(
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
                  border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                  image: DecorationImage(
                    image: FileImage(File(image!.path)),
                    fit: BoxFit.cover,
                  ),
                )
              : BoxDecoration(
                                      borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),

                  border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                ),
        child:image != null? null: Center(child: Icon(Icons.add ,color: Colors.grey , size: ConfigSize.defaultSize!*4,),),        
        ),
        
        
        );
  }
}