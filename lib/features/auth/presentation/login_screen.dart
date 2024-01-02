// ignore_for_file: non_constant_identifier_names
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_height_plugin/keyboard_height_plugin.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/navigation_service.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/pop_up_dialog.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/update_screen.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/continer_with_icons.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/login_with_phone_manager/login_with_phone_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/login_with_phone_manager/login_with_phone_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/login_with_phone_manager/login_with_phone_state.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'widgets/google_auth.dart';
import 'widgets/phone_wtih_country.dart';
import 'widgets/privcy_text_widget.dart';

class LoginScreen extends StatefulWidget {
  final bool? isUpdate;
  final bool? isForceUpdate;
  final bool? isLoginFromAnotherAccountAndBuildFailure;
  final bool? isBaned;
  final String? banedMassage;

  const LoginScreen(
      {required this.isForceUpdate,
      this.isBaned,
      required this.isUpdate,
      Key? key,
      this.isLoginFromAnotherAccountAndBuildFailure = false,
      this.banedMassage})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _keyboardHeight = 0;
  final KeyboardHeightPlugin _keyboardHeightPlugin = KeyboardHeightPlugin();
  late TextEditingController passwordController;


  @override
  void initState() {

    passwordController = TextEditingController();
    if (widget.isBaned!) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          showDialog(
              context: context,
              builder: (context) {
                return PopUpDialog(
                  headerText: widget.banedMassage ?? "",
                  accpetText: () {
                    Navigator.pop(context);
                  },
                  accpettitle: StringManager.ok.tr(),
                );
              });
        }
      });
    }

    else if (widget.isLoginFromAnotherAccountAndBuildFailure!) {
      Future.delayed(const Duration(seconds: 2), () {
        showDialog(
            context: context,
            builder: (context) {
              return PopUpDialog(
                headerText: StringManager.anotherAccountLoggedIn.tr(),
                accpetText: () {
                  Navigator.pop(context);
                },
                accpettitle: StringManager.ok.tr(),
              );
            });
      });
    }
    else if ((widget.isUpdate ?? false)) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialog(
            barrierDismissible: widget.isForceUpdate ?? false,
            context: context,
            builder: (BuildContext context) {
              return WillPopScope(
                  child: Material(
                      color: Colors.transparent,
                      child: UpdateScreen(
                        isForceUpdate: (widget.isForceUpdate ?? false),
                      )),
                  onWillPop: () async {
                    SystemNavigator.pop();
                    return false;
                  });
            });
      });
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _keyboardHeightPlugin.onKeyboardHeightChanged((double height) {
      if (mounted) {
        setState(() {
          _keyboardHeight = height;
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginWithPhoneBloc, LoginWithPhoneState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
              body: SingleChildScrollView(
            child: ScreenBackGround(
              image: AssetsPath.loginBackGround,
              child: Column(
                children: [
                  Image.asset(
                    AssetsPath.iconAppWithTitle,
                    scale: 2.5,
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  const PhoneWithCountry(),
                  const Spacer(
                    flex: 1,
                  ),
                  ContinerWithIcons(
                      color: Colors.white,
                      icon1: Icons.lock,
                      widget: SizedBox(
                          width: MediaQuery.of(context).size.width - 140,
                          child: TextFieldWidget(
                              obscureText: true,
                              hintColor: Colors.black.withOpacity(0.6),
                              hintText: StringManager.password.tr(),
                              controller: passwordController))),
                  const Spacer(
                    flex: 2,
                  ),
                  MainButton(
                    onTap: () {
                      if (PhoneWithCountry.phoneIsValid) {
                        BlocProvider.of<LoginWithPhoneBloc>(context).add(
                            LoginWithPhoneEvent(
                                phone: PhoneWithCountry.number.phoneNumber!,
                                password: passwordController.text));
                      }
                    },
                    title: StringManager.login.tr(),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomHorizntalDvider(
                          width: ConfigSize.defaultSize! * 10),
                      Text(
                        StringManager.orLoginWith.tr(),
                        style: TextStyle(
                            fontSize: ConfigSize.defaultSize! + 4,
                            color: ColorManager.whiteColor),
                      ),
                      CustomHorizntalDvider(
                          width: ConfigSize.defaultSize! * 10),
                    ],
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  GoogleAndAppleAuth(),
                  const Spacer(
                    flex: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.forgetPassword);
                    },
                    child: Text(
                      StringManager.forgetPassword.tr(),
                      style: TextStyle(
                          fontSize: ConfigSize.defaultSize! + 4,
                          color: ColorManager.whiteColor),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringManager.donnotHaveAccount.tr(),
                        style: TextStyle(
                            fontSize: ConfigSize.defaultSize! + 4,
                            color: ColorManager.whiteColor),
                      ),
                      InkWell(
                        onTap: () {
                          Methods.instance.clearAuthData();
                          Navigator.pushNamed(context, Routes.signUp);
                        },
                        child: Text(
                          StringManager.createAcoount.tr(),
                          style: TextStyle(
                              fontSize: ConfigSize.defaultSize! + 4,
                              color: ColorManager.whiteColor),
                        ),
                      ),
                    ],
                  ),
                  const PrivacyAndServiceTextWidget(),
                  const Spacer(
                    flex: 1,
                  )
                ],
              ),
            ),
          )),
        );
      },
      listener: (context, state) async {
        if (state is LoginWithPhoneSuccesMessageState) {
          Methods.instance.clearAuthData();
          //todo check this event if still here or not
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.mainScreen,
            (route) => false,
          );
        } else if (state is LoginWithPhoneErrorMessageState) {
          ScaffoldMessenger.of(getIt<NavigationService>().navigatorKey.currentContext!).showSnackBar(errorSnackBar(context,state.errorMessage));
        } else if (state is LoginWithPhoneLoadingState) {
          ScaffoldMessenger.of(getIt<NavigationService>().navigatorKey.currentContext!).showSnackBar(loadingSnackBar(context));
        }
      },
    );
  }
}
