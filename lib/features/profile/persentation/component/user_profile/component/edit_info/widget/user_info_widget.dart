import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/country_widget.dart';

class UserInfoWidget extends StatefulWidget {
    static TextEditingController? bioController;
  static TextEditingController? nameController;
  final OwnerDataModel userData;
  const UserInfoWidget({required this.userData, super.key});

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {


  @override
  void initState() {
    CountryWidget.countryFlag = widget.userData.profile!.country;
    UserInfoWidget.bioController = TextEditingController(text: widget.userData.bio);
    UserInfoWidget.nameController = TextEditingController(text: widget.userData.name);
     UserInfoWidget.bioController!.addListener(() {
      setState(() {
        
      });
      });
      UserInfoWidget.nameController!.addListener(() {
      setState(() {
        
      });
      });

    super.initState();
  }
@override
  void dispose() {
UserInfoWidget.bioController!.dispose();
UserInfoWidget.nameController!.dispose();
 CountryWidget.countryFlag="";

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: ConfigSize.defaultSize! * 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          rowWidget(
            context: context,
            title: StringManager.bio,
            subTitle:UserInfoWidget.bioController!.text,
            onTap: () {
              bottomDailog(
                  context: context,
                  widget: editDailog(
                      context: context,
                      controller: UserInfoWidget.bioController!,
                      title: StringManager.bio));
            },
          ),
          rowWidget(
              context: context,
              title: StringManager.interests,
              subTitle: widget.userData.intro,
              onTap: () => Navigator.pushNamed(context, Routes.interstedScreen),
              
              ),

          rowWidget(
            context: context,
            title: StringManager.userName,
            subTitle: UserInfoWidget.nameController!.text,
            onTap: () {
              bottomDailog(
                  context: context,
                  widget: editDailog(
                      context: context,
                      controller: UserInfoWidget.nameController!,
                      title: StringManager.userName));
            },
          ),

   Row(
    children:
   
    [
      const Spacer(flex: 1,),
     const CountryWidget(),
           const Spacer(flex: 25,),

     Icon(Icons.arrow_forward_ios , color: Theme.of(context).colorScheme.primary,),
           const Spacer(flex: 1,),

   ],)
        ],
      ),
    );
  }
}

Widget rowWidget(
    {required BuildContext context,
    required String title,
    String? subTitle,
    String? image,
    void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
      child: Row(
        children: [
          // const Spacer(flex: 1),
          Text(
            title,
            style: TextStyle(
                color: Colors.grey, fontSize: ConfigSize.defaultSize! * 1.7),
          ),
          const Spacer(flex: 15),

          if (subTitle != null)
            Text(
              subTitle,
              style: TextStyle(
                  color: Colors.grey, fontSize: ConfigSize.defaultSize! * 1.5),
            ),

          if (image != null)
            Text(
              image,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          const Spacer(flex: 1),

          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).colorScheme.primary,
          ),
          // const Spacer(flex: 1),
        ],
      ),
    ),
  );
}

Widget editDailog(
    {required BuildContext context,
    required String title,
    required TextEditingController controller}) {
  return Container(
    color: Theme.of(context).colorScheme.background,
    padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height / 1.7,
    child: Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        Container(
            padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
            width: MediaQuery.of(context).size.width - 50,
            child: TextFieldWidget(hintText: "", controller: controller))
      ],
    ),
  );
}
