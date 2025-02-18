import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (bloc is Cubit) {
      log("This is a Cubit", bloc.runtimeType);
    } else {
      log("This is a Bloc", bloc.runtimeType);
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange', bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent', event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(
        'onTransition',
        '\tcurrentState=${transition.currentState}\n'
            '\tnextState=${transition.nextState}');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose', bloc);
  }

  void log(String name, Object? msg) {
    debugPrint(
        '===== ${DateFormat("dd MMM yyyy HH:mm aa").format(DateTime.now())}: $name\n'
        '$msg');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('onError', error);
  }

}
