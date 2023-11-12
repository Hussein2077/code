import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persian_linear_date_picker/persian_linear_date_picker.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/country_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/date/date_dilog.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/widget/male_female_widget.dart';

class UserInfoWidget extends StatefulWidget {
    static TextEditingController? bioController;
  static TextEditingController? nameController;
  static String? age;
  static int? gender;
  final MyDataModel myDataModel;
    const UserInfoWidget({required this.myDataModel, super.key});

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {

  Color btnmale = ColorManager.whiteColor;
  Color btnfemale = ColorManager.whiteColor;
  Color btnmaleicon = ColorManager.gray;
  Color btnfemaleicon = ColorManager.gray;
  bool? maleAndFemaleFlag;


  @override
  void initState() {
    CountryWidget.countryFlag = widget.myDataModel.profile!.country;
    UserInfoWidget.bioController = TextEditingController(text: widget.myDataModel.bio);
    UserInfoWidget.nameController = TextEditingController(text: widget.myDataModel.name);
    UserInfoWidget.gender = widget.myDataModel.profile!.gender;
    maleAndFemaleFlag = widget.myDataModel.profile!.gender == 0 ? false : true;
    onbuttontap();
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

  void onbuttontap() {
    if (maleAndFemaleFlag == false) {
      UserInfoWidget.gender = 0;
      btnfemale = Colors.pink;
      btnfemaleicon = ColorManager.whiteColor;
      btnmale = ColorManager.whiteColor;
      btnmaleicon = ColorManager.gray;
    } else if (maleAndFemaleFlag == true) {
      UserInfoWidget.gender = 1;
      btnfemale = ColorManager.whiteColor;
      btnfemaleicon = ColorManager.gray;
      btnmale = ColorManager.blue;
      btnmaleicon = ColorManager.whiteColor;
    }
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
            title: StringManager.bio.tr(),
            subTitle:UserInfoWidget.bioController!.text,
            onTap: () {
              bottomDailog(
                  context: context,
                  widget: editDailog(
                     maxLength: 62,
                      context: context,
                      controller: UserInfoWidget.bioController!,
                      title: StringManager.bio.tr()));
            },
          ),
          rowWidget(
              context: context,
              title: StringManager.interests.tr(),
              subTitle: "",
              onTap: () => Navigator.pushNamed(context, Routes.interstedScreen),

              ),
          rowWidget(
            context: context,
            title: StringManager.userName.tr(),
            subTitle: UserInfoWidget.nameController!.text,
            onTap: () {
              bottomDailog(
                  context: context,
                  widget: editDailog(
                      context: context,
                      controller: UserInfoWidget.nameController!,
                      title: StringManager.userName.tr()));
            },
          ),

          InkWell(
            onTap: () {
              dailogDate(
                context: context,
                widget: Container(
                    height: ConfigSize.defaultSize! * 29,
                    decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        borderRadius: BorderRadius.circular(
                            ConfigSize.defaultSize! * 2.3)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            bottom: ConfigSize.defaultSize! * 2.3,
                          ),
                          child: PersianLinearDatePicker(
                            showLabels: false,

                            dateChangeListener:
                                (String selectedDate) {
                                  UserInfoWidget.age = selectedDate;
                            },
                            showMonthName: true,
                            columnWidth:
                            ConfigSize.defaultSize! * 12.7,

                            //  labelStyle:
                            //      const TextStyle(fontFamily: 'DIN', color: Colors.blue),
                            selectedRowStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                ConfigSize.defaultSize! * 2.3),
                            unselectedRowStyle: TextStyle(
                                fontSize:
                                ConfigSize.defaultSize! * 2.3,
                                fontWeight: FontWeight.w100,
                                color: ColorManager.gray),
                            isPersian: false,
                          ),
                        ),
                        MaterialButton(
                            height: ConfigSize.defaultSize! * 5.55,
                            color: ColorManager.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(ConfigSize.defaultSize!*3),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: SizedBox(
                              width: ConfigSize.defaultSize! * 31.1,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    StringManager.confirm.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ConfigSize
                                            .defaultSize! *
                                            2.5),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    )),
              );
            },
            child: Container(
         padding:
                  EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 1),
              decoration: BoxDecoration(
                // color: const Color(0xffF5F5F5),
                borderRadius:
                    BorderRadius.circular(ConfigSize.defaultSize! * 2.7),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringManager.birthdayDate.tr(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: ConfigSize.defaultSize! * 1.7,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'NotoKufiArabic',
                      )),
                  SizedBox(
                      width: ConfigSize.screenWidth! * 0.489,
                  ),
                  Row(
                    children: [
                      Text(
                          (UserInfoWidget.age == null ||
                                  UserInfoWidget.age == "")
                              ? widget.myDataModel.profile!.birthday
                              : UserInfoWidget.age.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: ConfigSize.defaultSize! * 1.7,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'NotoKufiArabic',
                          )),
                      SizedBox(
                          width: ConfigSize.defaultSize! * 0.8),
                      // Icon(
                      //   Icons.arrow_forward_ios_rounded,
                      //   size: ConfigSize.defaultSize! * 2.5,
                      // ),
                      // SizedBox(
                      //     width: ConfigSize.defaultSize! * 0.35),
                    ],
                  )
                ],
              ),
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      maleAndFemaleFlag = true;
                      onbuttontap();
                      UserInfoWidget.gender= 1;

                    });
                  },
                  child: MaleFemale(
                    bottomColor: btnmale,
                    iconColor: btnmaleicon,
                    gender: StringManager.male.tr(),
                    icon: Icons.man,
                  )),
              InkWell(
                  onTap: () {
                    setState(() {
                      maleAndFemaleFlag = false;
                      onbuttontap();
                      UserInfoWidget.gender=0;

                    });
                  },
                  child: MaleFemale(
                      bottomColor: btnfemale,
                      iconColor: btnfemaleicon,
                      gender: StringManager.female.tr(),
                      icon: Icons.woman)),
            ],
          ),





          const  Row(
    children:
   
    [
       Spacer(flex: 1,),
      CountryWidget(),

            Spacer(flex: 1,),

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
            SizedBox(
              width: 280,
              child: Text(
                textAlign: TextAlign.right,
                subTitle,
                style: TextStyle(
                    color: Colors.grey, fontSize: ConfigSize.defaultSize! * 1.5 , overflow: TextOverflow.ellipsis),
              ),
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
    required TextEditingController controller ,
    int? maxLength}
    ) {
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
            child: TextFieldWidget(hintText: "", controller: controller , maxLength: maxLength,))
      ],
    ),
  );
}
