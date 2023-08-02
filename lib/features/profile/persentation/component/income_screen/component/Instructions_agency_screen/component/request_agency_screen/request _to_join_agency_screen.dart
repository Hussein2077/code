import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/Instructions_agency_screen/component/request_agency_screen/widget/text_form_fild.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_join_to_agencie/bloc/join_to_agencie_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_join_to_agencie/bloc/join_to_agencie_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_join_to_agencie/bloc/join_to_agencie_state.dart';

class JoinToAgencyScreen extends StatefulWidget {
  const JoinToAgencyScreen({super.key});

  @override
  State<JoinToAgencyScreen> createState() => _JoinToAgencyScreenState();
}

class _JoinToAgencyScreenState extends State<JoinToAgencyScreen> {
  TextEditingController id = TextEditingController();
  TextEditingController agencyId = TextEditingController();
  TextEditingController number = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  bool showButton = true ; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocListener<JoinToAgencieBloc, JoinToAgencieState>(
        listener: (context, state) {
if (state is JoinToAgencieLoadingState){
   loadingToast(context: context, title: StringManager.loading);
}else if (state is JoinToAgencieErrorState){
  errorToast(context: context, title: state.error);
}   else if (state is JoinToAgencieSucssesState){
sucssesToast(context: context, title: StringManager.done);
showButton = false  ; 
setState(() {
  
});

}

     },
        child: BlocBuilder<GetMyDataBloc, GetMyDataState>(
          builder: (context, state) {
            if (state is GetMyDataSucssesState) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: ConfigSize.defaultSize! * 30.5,
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: ConfigSize.defaultSize! * 20.5,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: ColorManager.mainColorList),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(
                                          ConfigSize.defaultSize! * 1.5),
                                      bottomRight: Radius.circular(
                                          ConfigSize.defaultSize! * 1.5))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ConfigSize.defaultSize! * 4.4,
                                  right: ConfigSize.defaultSize! * 4,
                                  left: ConfigSize.defaultSize! * 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                        Icons.arrow_back_ios_new_rounded),
                                  ),
                                  Text(StringManager.agency.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge),
                                  const SizedBox(),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  UserImage(
                                    image: state.userData.profile!.image!,
                                    imageSize: ConfigSize.defaultSize! * 9.5,
                                  ),
                                  SizedBox(
                                    height: ConfigSize.defaultSize! * 1.0,
                                  ),
                                  Text(state.userData.name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge),
                                  SizedBox(
                                      height: ConfigSize.defaultSize! * 2.0)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ConfigSize.defaultSize! * 2.5),
                        child: Form(
                          key: formGlobalKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              SizedBox(
                                height: ConfigSize.defaultSize! * 1.0,
                              ),
                              TextFormFieldWidget(
                                textEditingController: id,
                                hintText: state.userData.uuid!,
                                readOnly: true,
                              ),
                              SizedBox(
                                height: ConfigSize.defaultSize! * 1.0,
                              ),
                              Text(
                                  StringManager.enterTheAgencyYouWishToJoin
                                      .tr(),
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              SizedBox(height: ConfigSize.defaultSize! * 1.0),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ConfigSize.defaultSize!),
                                width: MediaQuery.of(context).size.width - 50,
                                height: ConfigSize.defaultSize! * 6,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorManager.mainColor,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      ConfigSize.defaultSize! * 2),
                                ),
                                child: TextFieldWidget(
                                                                    type: TextInputType.number,

                                  controller: agencyId,
                                  hintText:
                                      StringManager.enterAgencyIDHere.tr(),
                                ),
                              ),
                              SizedBox(
                                height: ConfigSize.defaultSize! * 1.0,
                              ),
                              Text(StringManager.enterYourWhatsAppNumber.tr(),
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              SizedBox(
                                height: ConfigSize.defaultSize! * 1.0,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ConfigSize.defaultSize!),
                                width: MediaQuery.of(context).size.width - 50,
                                height: ConfigSize.defaultSize! * 6,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorManager.mainColor,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      ConfigSize.defaultSize! * 2),
                                ),
                                child: TextFieldWidget(
                                  type: TextInputType.number,
                                  controller: number,
                                  hintText:
                                      StringManager.enterYourNumberHere.tr(),
                                ),
                              ),
                              SizedBox(
                                height: ConfigSize.defaultSize! * 15,
                              ),
                              if (showButton)
                              MainButton(
                                onTap: () {
                                  if (agencyId.text.isEmpty) {
                                    errorToast(
                                        context: context,
                                        title:
                                            StringManager.pleaseEnterAgencyID);
                                  } else if (number.text.isEmpty) {
                                    errorToast(
                                        context: context,
                                        title:
                                            StringManager.pleaseEnterPhoneNum);
                                  } else {
                                    BlocProvider.of<JoinToAgencieBloc>(context)
                                        .add(JoinToAgencieEvent(
                                            agencieId: agencyId.text,
                                            whatsAppNum: number.text));
                                  }
                                },
                                title: StringManager.applicationToJoinAnAgency
                                    .tr(),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
