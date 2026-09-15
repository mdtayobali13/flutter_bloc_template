import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';

const String _reachabilityUrl = 'clients3.google.com';
const String _reachabilityPath = '/generate_204';

/// Cubit to monitor real-time internet connectivity and reachability
class InternetCubit extends Cubit<bool> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  InternetCubit() : super(true) {
    _init();
  }

  static Future<bool> isActuallyOnline() async {
    try {
      final client = HttpClient()..connectionTimeout = const Duration(seconds: 5);
      final request = await client.getUrl(Uri.http(_reachabilityUrl, _reachabilityPath));
      final response = await request.close();
      client.close();
      return response.statusCode == 204;
    } catch (_) {
      return false;
    }
  }

  Future<void> _init() async {
    final online = await isActuallyOnline();
    emit(online);

    _subscription = Connectivity().onConnectivityChanged.listen((results) async {
      if (results.contains(ConnectivityResult.none)) {
        emit(false);
      } else {
        final reachable = await isActuallyOnline();
        appLog('Internet reachability check: $reachable');
        emit(reachable);
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
