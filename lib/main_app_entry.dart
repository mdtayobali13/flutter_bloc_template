import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/routes/app_routes.dart';
import 'package:flutter_bloc_template/routes/internet_cubit.dart';
import 'package:flutter_bloc_template/utils/app_size.dart';
import 'package:flutter_bloc_template/utils/app_theme.dart';
import 'package:flutter_bloc_template/utils/app_theme_configuration.dart';
import 'package:flutter_bloc_template/widgets/texts/languages/language_cubit.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final AppRoutes appRoutes = AppRoutes.instance;
final GlobalKey<OverlayState> appOverlayKey = GlobalKey<OverlayState>();

class MainAppEntry extends StatefulWidget {
  const MainAppEntry({super.key});

  @override
  State<MainAppEntry> createState() => _MainAppEntryState();
}

class _MainAppEntryState extends State<MainAppEntry> {
  Key appKey = UniqueKey();

  void resetApp() {
    setState(() {
      appKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize.size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      key: appKey,
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()),
        BlocProvider<InternetCubit>(create: (_) => InternetCubit()),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          routerConfig: appRoutes.router,
          title: "Flutter BLoC",
          color: Colors.white,
          themeAnimationCurve: Curves.easeInOut,
          themeAnimationDuration: Duration.zero,
          theme: AppThemeConfiguration.instance.lightThemeData,
          darkTheme: AppThemeConfiguration.instance.darkThemeData,
          themeMode: themeMode,
          builder: (context, child) {
            return Overlay(
              key: appOverlayKey,
              initialEntries: [OverlayEntry(builder: (context) => child ?? const SizedBox())],
            );
          },
        );
      },
    );
  }
}
