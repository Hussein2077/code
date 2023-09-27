import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment/add_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment/add_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment/add_moment_state.dart';

class AddMomentScreen extends StatefulWidget {
  final TextEditingController? controller = TextEditingController();

  AddMomentScreen({super.key});

  static XFile? image;

  @override
  State<AddMomentScreen> createState() => _AddMomentScreenState();
}

class _AddMomentScreenState extends State<AddMomentScreen> {

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
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(flex: 1,),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed:
                      () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(flex: 4,),

                Text(StringManager.giftBox.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Spacer(flex: 5,),

              ],
            ),            SizedBox(
              height: ConfigSize.defaultSize! * 2,
            ),
            TextField(
              //enabled: widget.enabled,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: null,
              controller: widget.controller,
              onChanged: (String inputMessage) {},
              textInputAction: TextInputAction.send,
              onSubmitted: (message) {},
              cursorColor: const Color(0xffA653ff),
              cursorHeight: ConfigSize.defaultSize! * 3,
              cursorWidth: ConfigSize.defaultSize! * 0.3,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                  hintText: StringManager.addMoment1.tr(),
                  hintStyle: Theme.of(context).textTheme.bodySmall,
                  contentPadding: EdgeInsets.only(
                    left: ConfigSize.defaultSize! * 2,
                    top: ConfigSize.defaultSize! * -0.5,
                    right: ConfigSize.defaultSize! * 2,
                    bottom: ConfigSize.defaultSize! * 1.5,
                  ),
                  // isDense: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )),
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
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                        borderRadius:
                            BorderRadius.circular(ConfigSize.defaultSize! * 5),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      height: ConfigSize.defaultSize! * 25,
                      width: ConfigSize.defaultSize! * 25,
                      child: Icon(
                        Icons.add,
                        size: ConfigSize.defaultSize! * 3,
                      )),
            ),
            SizedBox(
              height: ConfigSize.defaultSize! * 35,
            ),
            BlocListener<AddMomentBloc, AddMomentState>(
              listener: (context, state) {
                if (state is AddMomentSucssesState) {
                  log('jako${state.message}');
                  sucssesToast(context: context, title: state.message);
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else if (state is AddMomentErrorState) {
                  log('jako${state.error}');

                  errorToast(context: context, title: state.error);
                } else if (state is AddMomentLoadingState) {
                  log('jako');
                  loadingToast(context: context);
                }
              },
              child: InkWell(
                onTap: () {
                  BlocProvider.of<AddMomentBloc>(context).add(AddMomentEvent(
                    userId: MyDataModel.getInstance().id.toString(),
                    moment: widget.controller!.text,
                    momentImage: AddMomentScreen.image!,
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.secondary),
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize! * 5),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                  ),
                  height: ConfigSize.defaultSize! * 5,
                  width: ConfigSize.defaultSize! * 10,
                  child: Center(
                      child: Text(
                    StringManager.send.tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
                ),
              ),
            ),
            SizedBox(
              height: ConfigSize.defaultSize! * 2,
            ),
          ],
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
