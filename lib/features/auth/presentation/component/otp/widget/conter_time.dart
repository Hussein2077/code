


import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/utils/config_size.dart';

class CounterTimeWidget extends StatefulWidget {
   final int second ;
   final bool isPK ;
   final int minute ;
   final String? ownerId ;
   final bool? isRepeting ;
   static bool isCounting = false ;

  const CounterTimeWidget({required this.second,
    required this.minute,
    this.ownerId, required this.isPK,  this.isRepeting, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CounterTimeWidgetState createState() => _CounterTimeWidgetState();
}

class _CounterTimeWidgetState extends State<CounterTimeWidget> {
  late int seconds ;
  late Timer timer;
  late int  minute ;

  @override
  void initState() {
    seconds =widget.second;
    minute =widget.minute ;
    sartCountDown();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  log("heeeeeeeeeeeeeeeeeeeeeeee");
    if(widget.isRepeting??false){
      seconds =widget.second;
      minute =widget.minute ;
      sartCountDown();
    }

  }

  @override
  void dispose() {
     seconds = -1;
     minute =-1 ;
     CounterTimeWidget.isCounting = false ;
     // timer.cancel();
    super.dispose();
  }

  void sartCountDown() {

   
    CounterTimeWidget.isCounting = true ;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minute<1 && seconds<1 ) {
        timer.cancel();
        CounterTimeWidget.isCounting = false ;
        if(widget.isPK){
          // BlocProvider.of<PKBloc>(context).add(ClosePKEvent(ownerId:widget.ownerId!));
        }

      }
      else if (seconds < 1){
        if(widget.isPK){
          setState(() {
            minute-- ;
            seconds=60 ;
          });
        }else{
          setState(() {
            CounterTimeWidget.isCounting = false ;
            seconds=0 ;
          });
        }

      }
      else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPK ?
    Text("$minute : $seconds",
      style:  TextStyle(color: Colors.white,fontSize: ConfigSize.defaultSize! * 1.5,fontWeight: FontWeight.w300),)
        : Center(
         child: Text(
        '$seconds',
        style:  Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
