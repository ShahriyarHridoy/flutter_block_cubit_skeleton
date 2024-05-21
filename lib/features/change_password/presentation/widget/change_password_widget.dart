import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_cubit_skeleton/core/resources/error_msg_res.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/data/model/change_password_request.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/presentation/cubit/change_password_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/widgets/app_dialog.dart';
import '../../../../common/widgets/app_loading.dart';
import '../../../../common/widgets/drawer.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/navigation/route_name.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  ChangePasswordRequest changePasswordRequest = ChangePasswordRequest(
    newPassword: '',
    oldPassword: '',
  );

  callChangePassword(BuildContext context) async {
    if (changePasswordRequest.newPassword.isNotEmpty &&
        changePasswordRequest.oldPassword.isNotEmpty) {
      await BlocProvider.of<ChangePasswordCubit>(context)
          .changePassword(changePasswordRequest);
    } else {
      Fluttertoast.showToast(
          msg: "Password should not be empty!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 250, 50, 35),
          textColor: Colors.white,
          fontSize: 18.0);
    }
  }

  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _newPasswordConfirmController;
  bool _oldVisibility = true;
  bool _visibility = true;
  bool _visibilityConf = true;

  String accessToken = "";
  String refreshToken = "";
  String name = "";
  String email = "";
  final _formKey = GlobalKey<FormState>();

  saveAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('accessToken', accessToken);
  }

  saveRefreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('refreshToken', refreshToken);
  }

  saveName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('name', name);
  }

  saveEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('email', email);
  }

  @override
  void initState() {
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _newPasswordConfirmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) async {
        if (state is ChangePasswordLoading) {
          showAppLoading(context);
        } else if (state is ChangePasswordFailure) {
          Navigator.pop(context);

          final ex = state.exception;
          if (ex is ServerException) {
            showAppDialog(context, title: ex.message ?? '');
          } else if (ex is NoInternetException) {
            showAppDialog(context, title: ErrorMsgRes.kNoInternet);
          }
        } else if (state is ChangePasswordSuccess) {
          final responseModel = state.model;
          debugPrint("In Success");
          log("in success Response: ${json.encode(responseModel)}");
          accessToken = responseModel.data!.accessToken!;
          refreshToken = responseModel.data!.refreshToken!;
          name = responseModel.data!.fullName!;
          email = responseModel.data!.email!;
          saveAccessToken();
          saveRefreshToken();
          saveName();
          saveEmail();

          log("access tocken: $accessToken");
          log("refreshToken : $refreshToken");
          log("name: $name");
          log("email: $email");

          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Fluttertoast.showToast(
              msg: "Please Log in again !!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              textColor: Color(0xff10ac84));

          Navigator.pushNamed(context, RouteName.signin);
          MotionToast.success(
            // title: Text("Success"),
            description: const Text("Password Successfully Changed"),
            position: MotionToastPosition.center,
            toastDuration: const Duration(seconds: 2),
          ).show(context);
        }
      },
      child: Scaffold(
          drawer: const UserDetailDrawer(),
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 80,
            title: const Text('Change Password'),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hey There,\nWelcome Back.',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff341f97)),
                    ),
                    const SizedBox(height: 18.0),
                    const Text(
                      'Please change your password carefully and remember it',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff341f97),
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 80.0),
                    TextFormField(
                      controller: _oldPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your old password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        changePasswordRequest.oldPassword = value;
                      },
                      obscureText: _oldVisibility,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Color(0xff341f97)),
                        floatingLabelStyle:
                            const TextStyle(color: Color(0xff341f97)),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff341f97)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff341f97)),
                        ),
                        labelText: 'Old Password',
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Color(0xff341f97),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            _oldVisibility = !_oldVisibility;
                          }),
                          icon: Icon(
                            _oldVisibility
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _newPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter new password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        if (value == _oldPasswordController.text) {
                          return 'Old and new Passwords are same';
                        }
                        return null;
                      },
                      obscureText: _visibility,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Color(0xff341f97)),
                        floatingLabelStyle:
                            const TextStyle(color: Color(0xff341f97)),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff341f97)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff341f97)),
                        ),
                        labelText: 'New Password',
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Color(0xff341f97),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            _visibility = !_visibility;
                          }),
                          icon: Icon(
                            _visibility
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: _newPasswordConfirmController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _newPasswordController.text) {
                          return 'Passwords did not match';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        changePasswordRequest.newPassword = value;
                      },
                      obscureText: _visibilityConf,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Color(0xff341f97)),
                        floatingLabelStyle:
                            const TextStyle(color: Color(0xff341f97)),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff341f97)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff341f97)),
                        ),
                        labelText: 'Confirm New password',
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Color(0xff341f97),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            _visibilityConf = !_visibilityConf;
                          }),
                          icon: Icon(
                            _visibilityConf
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () => {
                                    if (_formKey.currentState!.validate())
                                      {callChangePassword(context)}
                                  },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0))),
                              child: Ink(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0)),
                                child: Container(
                                  height: 50.0,
                                  alignment: Alignment.center,
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.0),
                                    child: Text(
                                      'Click to Change Password',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 18.0),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
