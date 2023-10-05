import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class AddRoomLivePic extends StatefulWidget {
   final String? roomCover;
  const AddRoomLivePic({super.key, this.roomCover});

  @override
  State<AddRoomLivePic> createState() => AddRoomLivePicState();
}

class AddRoomLivePicState extends State<AddRoomLivePic> {
  final ImagePicker picker = ImagePicker();
   static  XFile? image;
  Future<void> _getImage() async {
    image = await picker.pickImage(source: ImageSource.gallery,imageQuality: 50);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          _getImage();
        },
        child: Container(
          width: ConfigSize.defaultSize! * 13,
          height: ConfigSize.defaultSize! * 13,
          decoration: (image != null)
              ? BoxDecoration(
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
                  border: Border.all(color: Theme.of(context).colorScheme.primary, width: 0.5),
                  image: DecorationImage(
                    image: FileImage(File(image!.path)),
                    fit: BoxFit.cover,
                  ),
                )
              : BoxDecoration(
                      borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
                  image:DecorationImage(
                    image: NetworkImage(
                      //todo add defulet image from server
                        ConstentApi().getImage(widget.roomCover??'')
                    )
                  ) ,
                  border: Border.all(color: Theme.of(context).colorScheme.primary, width: 0.5),
                ),
        child:image != null? null: Center(child: Icon(Icons.add ,color: Colors.grey , size: ConfigSize.defaultSize!*4,),),        
        ),
        
        
        );
  }
}