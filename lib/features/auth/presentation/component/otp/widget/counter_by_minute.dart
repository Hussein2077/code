import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/auth/data/data_soruce/fire_base_datasource.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/phone_wtih_country.dart';

class CounterByMinute extends StatefulWidget {
  const CounterByMinute({
    super.key,
  });

  @override
  State<CounterByMinute> createState() => _CounterByMinuteState();
}

class _CounterByMinuteState extends State<CounterByMinute> {
  late Timer _timer;
  int _start = 60; // 5 minutes in seconds
  bool isRepeatingTime = true;
  @override
  void initState() {
    super.initState();
    if (isRepeatingTime) {
      startTimer();
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            isRepeatingTime = false;
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void resetTimerAndResendCode() {
    _timer.cancel();
    setState(() {
      _start = 60;
      isRepeatingTime = true;
      getIt<FireBaseDataSource>()
          .phoneAuthentication(PhoneWithCountry.number.phoneNumber!, context);
      // Reset to 5 minutes
    });
    startTimer();
  }

  String _formatTime(int time) {
    int minutes = time ~/ 60;
    int seconds = time % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () async {
            resetTimerAndResendCode();
          },
          child: Text(
            StringManager.reSend.tr(),
            style: TextStyle(
                color:
                    isRepeatingTime ? ColorManager.gray : ColorManager.mainColor,
                fontSize: ConfigSize.defaultSize! + 6,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          _formatTime(_start),
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
