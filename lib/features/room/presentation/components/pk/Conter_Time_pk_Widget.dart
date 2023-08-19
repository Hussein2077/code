import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_pk/pk_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_pk/pk_events.dart';


class CounterPkTimeWidget extends StatefulWidget {
  final String? ownerId ;
  final String? initMunite ;
  final String? initSecond ;
  const CounterPkTimeWidget({this.initMunite,this.initSecond,this.ownerId,
    Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CounterPkTimeWidgetState createState() => _CounterPkTimeWidgetState();
}

class _CounterPkTimeWidgetState extends State<CounterPkTimeWidget> {

  late Timer timer;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Text("${RoomScreen.timeMinutePK} : ${RoomScreen.timeSecondPK}",
      style:  TextStyle(color: Colors.white,
          fontSize: ConfigSize.defaultSize! * 1.5,fontWeight: FontWeight.w300),);
  }
}


class SetTimerPK {

  final StreamController<TimeData> streamController =
  StreamController<TimeData>.broadcast();
  Timer? _timer;
  // Getters
  Stream<TimeData> get stream => streamController.stream;
  Timer get timer => _timer! ;


  // Setters
  void start(BuildContext context, String  ownerId ) {
      _timer = Timer.periodic(
          const Duration(seconds: 1), (_) {

        _updateSeconds(context,ownerId);

      });



  }

  void _updateSeconds(BuildContext context,String ownerId) {
    if(RoomScreen.timeMinutePK<1 && RoomScreen.timeSecondPK<1 &&
        MyDataModel.getInstance().id.toString() == ownerId){
      BlocProvider.of<PKBloc>(context).add(ClosePKEvent(ownerId: ownerId));
    //  _timer!.cancel();

    }
    else if ( RoomScreen.timeSecondPK < 1){
      RoomScreen.timeSecondPK= 59;
      RoomScreen.timeMinutePK--  ;
      getIt<TimeData>().setMinute = RoomScreen.timeMinutePK ;
      getIt<TimeData>().setSecond = RoomScreen.timeSecondPK ;
      streamController.sink.add(getIt<TimeData>()) ;
    }else{
      RoomScreen.timeSecondPK -- ;
      getIt<TimeData>().setSecond = RoomScreen.timeSecondPK ;
      streamController.sink.add(getIt<TimeData>());
    }
  }
}





class TimeData {
   int minute ;
   int second ;

  TimeData({ this.minute=0, this.second=0});

  int get getMinute => minute ;

  set setMinute(int minute) => this.minute = minute ;

  int get getSecond => second ;

   set setSecond(int second) => this.second = second ;



  }


