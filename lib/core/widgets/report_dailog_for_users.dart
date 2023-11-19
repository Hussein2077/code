import 'dart:io';


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_user_repoert/user_report_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_user_repoert/user_report_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_user_repoert/user_report_state.dart';



class ReportDialogForUsers extends StatefulWidget {
  final String userID; 
  const ReportDialogForUsers({required this.userID ,  Key? key}) : super(key: key);

  @override
  State<ReportDialogForUsers> createState() => _ReportDialogForUsersState();
}

int? _value = 0;
String? content;

List<String> list = [
  StringManager.violence.tr(),
  StringManager.porn.tr(),
  StringManager.bullying.tr(),
];
late TextEditingController textEditingController ; 

class _ReportDialogForUsersState extends State<ReportDialogForUsers> {

  

     @override
void initState() {
textEditingController = TextEditingController();
    super.initState();
  }

   @override
  void dispose() {
textEditingController.dispose();
    super.dispose();
  }
  final formGlobalKey = GlobalKey<FormState>();
  ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserReportBloc, UserReportState>(
      listener: (context, state) {
        if (state is UserReportLoading){

          ScaffoldMessenger.of(context).showSnackBar(custoumSnackBar(context,StringManager.loading.tr()));

          // loadingToast(context: context, title: StringManager.loading.tr());
    

        }else if (state is UserReportSucsses){
          ScaffoldMessenger.of(context).showSnackBar(custoumSnackBar(context,StringManager.sucsses.tr()));

          // sucssesToast(context: context, title: StringManager.sucsses.tr());
        
        }else if (state is UserReportError){
          ScaffoldMessenger.of(context).showSnackBar(custoumSnackBar(context,state.error));

          // errorToast(context: context, title: state.error);
         

        }
      },
      builder: (context, state) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: ConfigSize.defaultSize! * 55,
            padding: EdgeInsets.only(
                right: ConfigSize.defaultSize! * 2,
                left: ConfigSize.defaultSize! * 2),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ConfigSize.defaultSize! * 2),
                    topRight: Radius.circular(ConfigSize.defaultSize! * 2))),
            child: Form(
              key: formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 0,
                      ),
                      Text(StringManager.report.tr() , style: Theme.of(context).textTheme.headlineLarge,),
                     
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                              color: Colors.black, CupertinoIcons.xmark)),
                    ],
                  ),
                  Text( StringManager.whatProblem.tr() , style: Theme.of(context).textTheme.headlineMedium,),

              
                      SizedBox(
                        width: ConfigSize.defaultSize! * 0.5,
                      ),
                  Wrap(
                    spacing: 5.0,
                    children: List<Widget>.generate(
                      list.length,
                      (int index) {
                        return ChoiceChip(
                          label: Text(list[index]),
                          selectedColor: const Color(0xff3EDF9F),
                          selected: _value == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? index : null;
                              if (kDebugMode) {
                                content = list[index];
                                print(content);
                              }
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),

                                    Text( StringManager.description.tr() , style: Theme.of(context).textTheme.headlineMedium,),

             
                  SizedBox(
                    height: ConfigSize.defaultSize! * 0.2,
                  ),
                  TextFormField(
                    style: TextStyle(
                            color: const Color(0xff999999),
                            fontSize: ConfigSize.defaultSize! * 1.5,
                            fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.text,
                    controller: textEditingController,
                    textAlignVertical: TextAlignVertical.top,
                    maxLength: 200,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringManager.mustNotBeEmpty.tr();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      
                        hintMaxLines: 3,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorManager.mainColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorManager.mainColor,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                        ),
                        contentPadding: EdgeInsets.only(
                            left: ConfigSize.defaultSize! * 1.0,
                            right: ConfigSize.defaultSize! * 1.0,
                            bottom: ConfigSize.defaultSize! * 5,
                            top: ConfigSize.defaultSize! * 2),
                        alignLabelWithHint: true,
                        filled: true,
                        hintStyle: TextStyle(
                            color: const Color(0xff999999),
                            fontSize: ConfigSize.defaultSize! * 1.5,
                            fontWeight: FontWeight.w400),
                        fillColor: const Color(0xffF3F3F3),
                        hintText: StringManager.pleaseExplain.tr(),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          
                        )),
                  ),

                                                      Text(  StringManager.screenshot.tr() , style: Theme.of(context).textTheme.headlineMedium,),


             
                  InkWell(
                    onTap: () async {
                      image =
                          await picker.pickImage(source: ImageSource.gallery);

                      setState(() {
                        image = XFile(image!.path);
                      });
                    },
                    child: Container(
                      height: ConfigSize.defaultSize! * 10.0,
                      width: ConfigSize.defaultSize! * 10.0,
                      decoration: BoxDecoration(
                        image: image != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(image!.path)),
                              )
                            : null,
                        borderRadius:
                            BorderRadius.circular(ConfigSize.defaultSize! * 2),
                        color: const Color(0xffE7E7E7),
                      ),
                      child: image != null
                          ? const SizedBox()
                          : Icon(Icons.add, size: ConfigSize.defaultSize! * 2),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ConfigSize.defaultSize! * 1.4)),
                        minimumSize: Size(MediaQuery.of(context).size.width,
                            ConfigSize.defaultSize! * 2.5)),
                    onPressed: () {
                      if (formGlobalKey.currentState!.validate()) {
                        formGlobalKey.currentState!.save();
                       content ??= list[0];
                       if (image==null){
                        BlocProvider.of<UserReportBloc>(context)
        .add( UserReporetEvent(id: widget.userID , reporetContetnt: textEditingController.text , typeReporet:content   ));

                       }else {
                        BlocProvider.of<UserReportBloc>(context)
        .add( UserReporetEvent(id: widget.userID ,image: File(image!.path) , reporetContetnt: textEditingController.text , typeReporet:content   ));
                       }

  
                                         }
                   
                    },
                    child: Text(                    StringManager.submission.tr()
 ,style: Theme.of(context).textTheme.headlineMedium,)
                    
                   
                  ),
                  SizedBox(
                    height: ConfigSize.defaultSize! * 2.0,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
