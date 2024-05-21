import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/common/app.dart';
import 'package:flutter_block_cubit_skeleton/core/resources/custom_animation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'core/utils/dependency.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await Dependency.init();
  runApp(const App());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Color(0xffc8d6e5)
    ..backgroundColor = Color(0xff10ac84)
    ..indicatorColor = Color(0xffc8d6e5)
    ..textColor = Color(0xffc8d6e5)
    ..maskColor = Color(0xff341f97).withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}
