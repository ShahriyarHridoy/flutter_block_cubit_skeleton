import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/common/splash_screen.dart';
import 'package:flutter_block_cubit_skeleton/core/navigation/route_name.dart';
import 'package:flutter_block_cubit_skeleton/dashboard/screen/dashboard_screen.dart';
import 'package:flutter_block_cubit_skeleton/dashboard/widget/data_list_widget.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/presentation/widget/change_password_widget.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/check_otp/presentation/screen/check_otp.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/reset_password/presentation/screen/reset_password.dart';
import 'package:flutter_block_cubit_skeleton/features/forgot_password/send_otp/presentation/screen/send_otp.dart';
import 'package:flutter_block_cubit_skeleton/features/profile/presentation/screen/profile_screen.dart';
import 'package:flutter_block_cubit_skeleton/features/settings/settings.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/presentation/screen/sign_in_screen.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_up/presentation/screen/sign_up.dart';

import '../../features/otp_validate/presentation/screen/otp_validate.dart';

// import 'package:flutter/widgets.dart';

class RouteConfig {
  Route routes(RouteSettings routeSettings) {
    print(routeSettings.arguments);
    switch (routeSettings.name) {
      case RouteName.initialRoute:
        return _getInitialRoute();
      case RouteName.dashboard:
        return _getDashboard();
      case RouteName.signup:
        return _getSignUp();
      case RouteName.signin:
        return _getSignin();
      case RouteName.profile:
        return _getProfile();
      case RouteName.record:
        return _getRecord();
      case RouteName.settings:
        return _getSettings();
      case RouteName.sendOtp:
        return _getSendOtp();
      case RouteName.checkOtp:
        return _getCheckOtp();
      case RouteName.otpValidate:
        return _getOtpValidate(routeSettings);
      case RouteName.resetPassword:
        return _getResetPassword();
      case RouteName.changePassword:
        return _getChangePassword();
    }
    return _defaultRoute();
  }

  static MaterialPageRoute _routeBuilder(Widget child,
      {RouteSettings? settings}) {
    return MaterialPageRoute(builder: (_) => child, settings: settings);
  }

  static MaterialPageRoute _defaultRoute() {
    return _routeBuilder(
      const Scaffold(
        body: Center(
          child: Text('Unknown route'),
        ),
      ),
    );
  }

  static MaterialPageRoute _getInitialRoute() {
    return _routeBuilder(const SplashScreen());
  }

  static MaterialPageRoute _getDashboard() {
    return _routeBuilder(const DashboardScreen());
  }

  static MaterialPageRoute _getSignUp() {
    return _routeBuilder(const SignUp());
  }

  static MaterialPageRoute _getSignin() {
    return _routeBuilder(const SignIn());
  }

  static MaterialPageRoute _getProfile() {
    return _routeBuilder(const ProfileScreen());
  }

  static MaterialPageRoute _getRecord() {
    return _routeBuilder(RecordsPage());
  }

  static MaterialPageRoute _getSettings() {
    return _routeBuilder(const SettingsPage());
  }

  static MaterialPageRoute _getSendOtp() {
    return _routeBuilder(const SendOtp());
  }

  static MaterialPageRoute _getCheckOtp() {
    return _routeBuilder(const CheckOtp());
  }

  static MaterialPageRoute _getOtpValidate(RouteSettings? settings) {
    return _routeBuilder(OtpValidate(), settings: settings);
  }

  static MaterialPageRoute _getResetPassword() {
    return _routeBuilder(const ResetPassword());
  }

  static MaterialPageRoute _getChangePassword() {
    return _routeBuilder(const ChangePasswordWidget());
  }
}
