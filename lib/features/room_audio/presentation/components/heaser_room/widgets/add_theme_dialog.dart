import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/room_audio/data/data_sorce/remotly_data_source_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_add_room_backGround/add_room_background_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_add_room_backGround/add_room_background_event.dart';
class AddThemeImage extends StatefulWidget {
  const AddThemeImage({super.key});

  static XFile? xFile;

  @override
  State<AddThemeImage> createState() => _AddThemeImageState();
}

class _AddThemeImageState extends State<AddThemeImage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    AddThemeImage.xFile = null;
    super.dispose();
  }

  Future getImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile?.path != null) {
      setState(() {
        _image = File(pickedFile!.path);
      });
    }
    AddThemeImage.xFile = pickedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.screenHeight! * .5,
      width: ConfigSize.screenWidth!,
      color:Theme.of(context).colorScheme.secondary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "${RemotlyDataSourceRoom.uploadImagePrice} ${StringManager.coinToUpload.tr()}",
            style: TextStyle(
                fontSize: ConfigSize.defaultSize! * 1.8),
          ),
          InkWell(
            onTap: () async {
              await getImage();
            },
            child: AddThemeImage.xFile != null
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(AddThemeImage.xFile!.path)),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize! * 5),
                    ),
                    height: ConfigSize.defaultSize! * 25,
                    width: ConfigSize.defaultSize! * 25,
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize! * 5),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    height: ConfigSize.defaultSize! * 25,
                    width: ConfigSize.defaultSize! * 25,
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).iconTheme.color,
                      size: ConfigSize.defaultSize! * 3,
                    )),
          ),
          MainButton(
            onTap: () {
              if (AddThemeImage.xFile == null) {
                errorToast(context: context, title: StringManager.pleaseAddPhoto);
              } else if (AddThemeImage.xFile != null) {
                BlocProvider.of<AddRoomBackgroundBloc>(context)
                    .add(AddRoomBackgroundEvent(roomBackGround: _image!));
              }
            },
            title: StringManager.done.tr(),
          )
        ],
      ),
    );
  }
}
