import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment/add_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment/add_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment/add_moment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_event.dart';



class AddMomentScreen extends StatefulWidget {
  final TextEditingController? controller = TextEditingController();

  AddMomentScreen({super.key});

  static XFile? image;

  @override
  State<AddMomentScreen> createState() => _AddMomentScreenState();
}

class _AddMomentScreenState extends State<AddMomentScreen> {
  String? path;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    widget.controller?.clear();

    super.initState();
  }

  @override
  void dispose() {
    AddMomentScreen.image = null;
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        height: ConfigSize.screenHeight!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              Row(
                children:  [
                  const Spacer(flex: 1,),
                  IconButton(onPressed: () { Navigator.pop(context); },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Spacer(flex: 4,),
                  Text(StringManager.addMoment.tr(),style: Theme.of(context).textTheme.titleLarge,),
                  const Spacer(flex: 5,),
                ],
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              Container(
                width: ConfigSize.screenWidth! * 0.9,
                height: ConfigSize.screenWidth! * 0.35,
                decoration: BoxDecoration(
                  color: ColorManager.deeporang,
                  borderRadius:
                      BorderRadius.circular(ConfigSize.defaultSize! * 2),
                ),
                child: TextField(
                  enableIMEPersonalizedLearning: true,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                  controller: widget.controller,
                  textInputAction: TextInputAction.send,
                  cursorColor: ColorManager.mainColor,
                  cursorHeight: ConfigSize.defaultSize! * 3,
                  cursorWidth: ConfigSize.defaultSize! * 0.3,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                      hintText: '${StringManager.addMoment.tr()} ...',
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      contentPadding: EdgeInsets.only(
                        left: ConfigSize.defaultSize! * 2,
                        top: ConfigSize.defaultSize! * -0.5,
                        right: ConfigSize.defaultSize! * 2,
                        bottom: ConfigSize.defaultSize! * 1.5,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                            Radius.circular(ConfigSize.defaultSize!)),
                      )),
                ),
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              InkWell(
                onTap: () {
                  _getMomentImage(50);
                },
                child: AddMomentScreen.image != null
                    ? Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(File(AddMomentScreen.image!.path)),
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
                          size: ConfigSize.defaultSize! * 3,
                        )),
              ),
              SizedBox(
                height: ConfigSize.screenHeight! * 0.2,
              ),
              BlocListener<AddMomentBloc, AddMomentState>(
                listener: (context, state) {
                  if (state is AddMomentSucssesState) {
                    sucssesToast(context: context, title: state.message);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else if (state is AddMomentErrorState) {
                    errorToast(context: context, title: state.error);
                    errorToast(context: context, title: state.error);
                  } else if (state is AddMomentLoadingState) {
                    loadingToast(context: context);
                  }
                },
                child: InkWell(
                  onTap: () {
                    path=AddMomentScreen.image?.path;
                    if(path!=null){
                      BlocProvider.of<AddMomentBloc>(context).add(AddMomentEvent(
                        userId: MyDataModel.getInstance().id.toString(),
                        moment: widget.controller!.text,
                        momentImage: File(path!,),

                      ));

                    }

                    else{
                      BlocProvider.of<AddMomentBloc>(context).add(AddMomentEvent(
                        userId: MyDataModel.getInstance().id.toString(),
                        moment: widget.controller!.text,


                      ));

                    }





                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient:
                          const LinearGradient(colors: ColorManager.mainColorList),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize! * 5),
                    ),
                    height: ConfigSize.defaultSize! * 5,
                    width: ConfigSize.screenWidth! * 0.8,
                    child: Center(
                        child: Text(
                      StringManager.send.tr(),
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getMomentImage(int quality) async {
    AddMomentScreen.image = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: quality);

    setState(() {});
  }
}
