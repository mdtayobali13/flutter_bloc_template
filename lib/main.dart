import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc_template/constant/app_colors.dart';
import 'package:flutter_bloc_template/error_handling_screen/error_screen/error_screen.dart';
import 'package:flutter_bloc_template/main_app_entry.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';
import 'package:flutter_bloc_template/utils/observer/app_bloc_observer.dart';

Future<void> main() async {
  //////////////  flutter binding initialize
  WidgetsFlutterBinding.ensureInitialized();

  ///////////// BLoC observer initialize
  Bloc.observer = AppBlocObserver();

  ///////////// custom error screen
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return const ErrorScreen();
  };

  ///////////// devices orientation set
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  //////////// app navigation style set
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.instance.transparent,
      statusBarColor: AppColors.instance.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
  ////////////// network
  HttpOverrides.global = MyHttpOverrides(); //// use when i work local with http

  ////////////// .env file load
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    errorLog("dotenv file load", e);
  }

  runApp(const MainAppEntry());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (cert, host, port) => kDebugMode;
  }
}
