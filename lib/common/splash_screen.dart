import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/core/utils/lang/size_config.dart';
import 'package:flutter_block_cubit_skeleton/dashboard/screen/dashboard_screen.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/presentation/screen/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? accessToken;

  getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("accessToken");
      debugPrint(
          "sharedPreferences.getString(loginId) :::${sharedPreferences.getString("accessToken")}");
      debugPrint("loginId shared preference: $accessToken");
    });
  }

  @override
  void initState() {
    super.initState();
    getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: AnimatedSplashScreen(
        splashIconSize: double.infinity,
        duration: 1000,
        splash: const Icon(
          size: 150,
          Icons.money,
          //weight: double.,
        ),
        nextScreen:
            accessToken == null ? const SignIn() : const DashboardScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Color(0xff341f97),
      ),
    );
  }
}
