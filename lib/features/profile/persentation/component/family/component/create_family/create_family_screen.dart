import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/create_family/widgets/add_family_pic.dart';

class CreateFamily extends StatefulWidget {
  const CreateFamily({super.key});

  @override
  State<CreateFamily> createState() => _CreateFamilyState();
}

class _CreateFamilyState extends State<CreateFamily> {
  late TextEditingController familyNameController;
  late TextEditingController familyBioController;

  @override
  void initState() {
    familyNameController = TextEditingController();
    familyBioController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ConfigSize.defaultSize! * 85,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: ConfigSize.defaultSize!,
                    ),
                    Text(
                      StringManager.createFamily,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize!,
                    ),
                    const AddFamilyPic(),
                    SizedBox(
                      height: ConfigSize.defaultSize!,
                    ),
                    Text(StringManager.addImage,
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(
                      height: ConfigSize.defaultSize!,
                    ),
                  ],
                ),
              ),
              Text(
                StringManager.familyName,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: ConfigSize.defaultSize!,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                height: ConfigSize.defaultSize! * 5,
                padding:
                    EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                decoration: BoxDecoration(
                    color: ColorManager.lightGray,
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize! * 2)),
                child: TextFieldWidget(
                  controller: familyBioController,
                  hintText: StringManager.familyName,
                ),
              ),
              SizedBox(
                height: ConfigSize.defaultSize!,
              ),
              Text(
                StringManager.familyBio,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: ConfigSize.defaultSize!,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                height: ConfigSize.defaultSize! * 5,
                padding:
                    EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                decoration: BoxDecoration(
                    color: ColorManager.lightGray,
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize! * 2)),
                child: TextFieldWidget(
                  controller: familyNameController,
                  hintText: StringManager.familyBio,
                ),
              ),
                    SizedBox(
                height: ConfigSize.defaultSize!*4,
              ),
              createButton(context: context , onTap: (){Navigator.pushNamed(context, Routes.familyProfile);},)
            ],
          ),
        ),
      ),
    );
  }
}




Widget createButton ({required BuildContext context , required void Function()? onTap}){
  return InkWell(
                onTap: onTap,
                child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: ConfigSize.defaultSize! * 5.5,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: ColorManager.mainColorList,
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft),
                        borderRadius:
                            BorderRadius.circular(ConfigSize.defaultSize! * 5)),
                    child: Row(
                      children: [
                        const Spacer(
                          flex: 5,
                        ),
                        Text(
                          StringManager.createFamily,
                          style: TextStyle(
                              color: ColorManager.whiteColor,
                              fontSize: ConfigSize.defaultSize! * 1.8,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(
                          flex: 15,
                        ),
                        Text(
                          "100000",
                          style: TextStyle(
                              color: ColorManager.whiteColor,
                              fontSize: ConfigSize.defaultSize! * 1.8,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Image.asset(
                          AssetsPath.goldCoinIcon,
                          scale: 10,
                        ),
                        const Spacer(
                          flex: 5,
                        ),
                      ],
                    )),
              );

}