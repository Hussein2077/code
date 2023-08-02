import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/otp/widget/conter_time.dart';

class ResendCodeWidget extends StatefulWidget {
  const ResendCodeWidget({super.key});

  @override
  State<ResendCodeWidget> createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends State<ResendCodeWidget> {
    bool isRepetingTime = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: (){
              if(!CounterTimeWidget.isCounting){
                              //  getIt<FireBaseDataSource>().phoneAuthentication(widget.phone, context);
                              //  showToastWidget(ToastWidget().loadingToast(),
                              //      context: context, position: StyledToastPosition.top);
                               setState(() {
                               isRepetingTime =true ;
                               });
                             }
          },
          child: Text(
            StringManager.reSend.tr(),
            style: TextStyle(
                color: ColorManager.mainColor,
                fontSize: ConfigSize.defaultSize! + 6 , fontWeight: FontWeight.bold),
          ),
        ),

            CounterTimeWidget(
                            isRepeting:isRepetingTime,
                            second: 60,
                            isPK: false,
                            minute: 1,
                          ),
      ],
    );
  }
}
