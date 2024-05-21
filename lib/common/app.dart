import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_cubit_skeleton/common/cubit/locale/locale_cubit.dart';
import 'package:flutter_block_cubit_skeleton/core/navigation/route_config.dart';
import 'package:flutter_block_cubit_skeleton/core/resources/string_res.dart';
import 'package:flutter_block_cubit_skeleton/core/utils/dependency.dart';
import 'package:flutter_block_cubit_skeleton/core/utils/lang/app_localizations.dart';
import 'package:flutter_block_cubit_skeleton/features/settings/settings.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

final routeConfig = RouteConfig();

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Dependency.providers,
      child: _buildMaterialApp(),
    );
  }

  BlocBuilder<LocaleCubit, LocaleState> _buildMaterialApp() {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        // final currentTheme = enableDarkMode ? darkTheme : whiteTheme;
        return MaterialApp(
          theme: appTheme,
          // darkTheme: ThemeData.dark(),
          themeMode: enableDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: routeConfig.routes,
          supportedLocales: _supportedLocale,
          localizationsDelegates: _localizationDelegates,
          localeResolutionCallback: localeResolution,
          locale: state.getCurrentLocale(),
          builder: EasyLoading.init(),
        );
      },
    );
  }

  final _supportedLocale = [
    const Locale(StringRes.kLangCodeEN, StringRes.kLangCountryUS),
    const Locale(StringRes.kLangCodeBN, StringRes.kLangCountryBD),
  ];

  final _localizationDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  Locale localeResolution(locale, supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }
}
