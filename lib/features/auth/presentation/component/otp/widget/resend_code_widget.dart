import 'package:flutter/material.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/otp/widget/counter_by_minute.dart';

class ResendCodeWidget extends StatefulWidget {
  String phone;
  ResendCodeWidget({super.key, required this.phone});

  @override
  State<ResendCodeWidget> createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends State<ResendCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return CounterByMinute(phone: widget.phone);
  }
}
