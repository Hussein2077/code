import 'dart:async';

class CounterBloc {
  int counter = 0;
 final StreamController<int> _counterController = StreamController<int>.broadcast();
  Stream<int> get counterStream => _counterController.stream;

  Timer? _timer;

  void startCounter() {
    _timer ??= Timer.periodic(Duration(seconds: 1), (timer) {
        counter++;
        _counterController.add(counter);
      });

  }

  void pauseCounter() {
    _timer?.cancel();
    _timer = null;
  }

  void resumeCounter() {
    startCounter();
  }

  void resetCounter (){
    _timer?.cancel();
    _timer = null;
    counter = 0 ;
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    counter = 0 ;

    _counterController.close();
  }
}







