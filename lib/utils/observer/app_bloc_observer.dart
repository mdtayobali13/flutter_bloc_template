import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Global BLoC observer for logging lifecycle and state transitions in debug mode
class AppBlocObserver extends BlocObserver {
  void _log(String message) {
    if (kDebugMode) {
      log(message, name: 'BLoC');
    }
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _log('''
🟢 BLoC Created
---------------------------------------
Type: ${bloc.runtimeType}
Initial State: ${bloc.state}
---------------------------------------''');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _log('''
🌀 State Changed
---------------------------------------
BLoC: ${bloc.runtimeType}
Current: ${change.currentState}
Next:    ${change.nextState}
---------------------------------------''');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _log('''
⚡ Transition
---------------------------------------
BLoC:    ${bloc.runtimeType}
Event:   ${transition.event}
Current: ${transition.currentState}
Next:    ${transition.nextState}
---------------------------------------''');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _log('''
⚠️ BLoC Error
---------------------------------------
BLoC: ${bloc.runtimeType}
Error: $error
Stack: $stackTrace
---------------------------------------''');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    _log('''
🔴 BLoC Closed
---------------------------------------
Type: ${bloc.runtimeType}
---------------------------------------''');
    super.onClose(bloc);
  }
}
