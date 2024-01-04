import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/otp/widget/otp_continers.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/otp/widget/resend_code_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/account_events.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/account_states.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/acount_bloc.dart';

class OtpBindScreen extends StatefulWidget {
  final String? phone;
  final String? password;
  final String? codePhone;
  final String? type;

  const OtpBindScreen({
    this.password,
    this.codePhone,
    this.type,
    this.phone,
    super.key,
  });

  @override
  State<OtpBindScreen> createState() => _OtpBindScreenState();
}

class _OtpBindScreenState extends State<OtpBindScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcountBloc, AccountStates>(
        listener: (BuildContext context, AccountStates state) async {
      if (state is NumberAccountSuccessState) {
        final snackBar = SnackBar(
          content: Text(state.successMessage),
          backgroundColor: (Colors.black12),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.mainScreen,
          (route) => false,
        );
      } else if (state is NumberAccountErrorState) {
        errorToast(context: context, title: state.errorMessage);
      }
    }, builder: (BuildContext context, AccountStates state) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            const Spacer(
              flex: 4,
            ),
            const HeaderWithOnlyTitle(
              title: StringManager.enterTheVerificatiOnCode,
            ),
            const Spacer(
              flex: 7,
            ),
            Image.asset(
              AssetsPath.iconApp,
              scale: 2.5,
            ),
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: Text(StringManager.verificatiCodeWiilBeSent,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              widget.phone ?? "",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: ConfigSize.defaultSize! + 6),
            ),
            const Spacer(
              flex: 2,
            ),
            const OtpContiners(),
            ResendCodeWidget(phone: widget.phone!),
            const Spacer(
              flex: 7,
            ),
            MainButton(
                onTap: () async {
                  if (widget.type == 'bindNumber') {
                    BlocProvider.of<AcountBloc>(context).add(
                        BindNumberAccountEvent(
                            credential: "token",
                            phoneNumber: widget.phone.toString(),
                            password: widget.password ?? '',
                            vrCode: OtpContiners.code));
                  }
                },
                title: StringManager.done),
            const Spacer(
              flex: 20,
            ),
          ],
        ),
      );
    });
  }
}
