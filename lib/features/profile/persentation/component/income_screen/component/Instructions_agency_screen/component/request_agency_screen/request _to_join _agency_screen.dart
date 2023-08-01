import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/Instructions_agency_screen/component/request_agency_screen/widget/text_form_fild.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
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
                          gradient: const LinearGradient(colors: ColorManager.mainColorList),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(ConfigSize.defaultSize! * 1.5),
                              bottomRight: Radius.circular(ConfigSize.defaultSize! * 1.5))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ConfigSize.defaultSize! * 4.4,
                          right: ConfigSize.defaultSize! * 4,
                          left: ConfigSize.defaultSize! * 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                                Icons.arrow_back_ios_new_rounded),
                          ),
                          Text(StringManager.agency,
                              style:Theme.of(context).textTheme.headlineLarge),

                          const SizedBox(),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: ConfigSize.defaultSize! * 9.5,
                            height: ConfigSize.defaultSize! * 9.5,
                            decoration:  const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                    image:AssetImage(AssetsPath.testImage)
                                )),
                          ),
                          SizedBox(
                            height:  ConfigSize.defaultSize! * 1.0,
                          ),
                          Text(StringManager.newReel,
                              style:Theme.of(context).textTheme.headlineLarge),
                          SizedBox(
                            height: ConfigSize.defaultSize! * 2.0
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:  ConfigSize.defaultSize! * 2.5),
                child: Form(
                  key: formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID',
                          style:Theme.of(context).textTheme.titleMedium),
                      SizedBox(
                        height:  ConfigSize.defaultSize! * 1.0,
                      ),
                      TextFormFieldWidget(
                        textEditingController: id,
                        hintText: '44546',
                        readOnly: true,
                      ),
                      SizedBox(
                        height:  ConfigSize.defaultSize! * 1.0,
                      ),
                      Text(StringManager.enterTheAgencyYouWishToJoin,
                          style:Theme.of(context).textTheme.titleSmall),
                      SizedBox(
                        height:  ConfigSize.defaultSize! * 1.0

                      ),
                      TextFormFieldWidget(
                        readOnly: false,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return  StringManager.cantBeEmpty;
                          }
                          return null;
                        },
                        hintText: StringManager.enterAgencyIDHere,
                        textEditingController: agencyId,
                      ),
                      SizedBox(
                        height:  ConfigSize.defaultSize! * 1.0,
                      ),
                      Text(StringManager.enterYourWhatsAppNumber,
                          style:Theme.of(context).textTheme.titleSmall),
                      SizedBox(
                        height:  ConfigSize.defaultSize! * 1.0,
                      ),

                      TextFormFieldWidget(
                        readOnly: false,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return  StringManager.cantBeEmpty;
                          }
                          return null;
                        },
                        hintText: StringManager.enterYourNumberHere,
                        textEditingController: number,
                      ),
                      SizedBox(
                        height:  ConfigSize.defaultSize! *15
                        ,
                      ),
                      MainButton(
                        onTap: () {

                        },
                        title: StringManager.applicationToJoinAnAgency,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
