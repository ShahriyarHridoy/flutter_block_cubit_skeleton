import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/app_dialog.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/app_loading.dart';
import 'package:flutter_block_cubit_skeleton/core/exceptions/exceptions.dart';
import 'package:flutter_block_cubit_skeleton/core/navigation/route_name.dart';
import 'package:flutter_block_cubit_skeleton/core/resources/error_msg_res.dart';
import 'package:flutter_block_cubit_skeleton/core/utils/lang/app_localizations.dart';
import 'package:flutter_block_cubit_skeleton/features/sign_in/data/model/sign_in_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/widgets/app_widget.dart';
import '../../../../common/widgets/common_textfield copy.dart';
import '../cubit/sign_in_cubit/cubit/sign_in_cubit.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  String accessToken = "";
  String refreshToken = "";
  String name = "";
  String email = "";
  final TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  SignInRequest user = SignInRequest(email: "", password: "");

  // void _updateFormState(GlobalKey<FormState> key, SignInRequest userData) {
  //   if (user.email != userData.email || user.password != userData.password) {
  //     setState(() {
  //       user = userData;
  //     });
  //   }
  // }

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

  bool isLangBangla = false;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context).locale.languageCode;
    isLangBangla = s.contains('bn');
    // final user = SignInRequest(email: "", password: "");

    //final formKey = GlobalKey<FormState>();
    return BlocListener<SignInApiCubit, SignInApiState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          /// Bypass Sign In
          // Navigator.pushNamed(context, RouteName.dashboard);
          showAppLoading(context);
        } else if (state is SignInFailed) {
          // Navigator.pop(context);

          final ex = state.exception;
          if (ex is ServerException) {
            showAppDialog(context, title: ex.message ?? '');
          } else if (ex is NoInternetException) {
            showAppDialog(context, title: ErrorMsgRes.kNoInternet);
          }
        } else if (state is SignInSucceed) {
          final responseModel = state.model;
          debugPrint("In Success");
          log("in success Response: ${json.encode(responseModel)}");
          accessToken = responseModel.data!.accessToken!;
          refreshToken = responseModel.data!.refreshToken!;
          name = responseModel.data!.fullName!;
          email = responseModel.data!.email!;
          saveAccessToken();
          // saveRefreshToken();
          saveName();
          saveEmail();

          log("access tocken: $accessToken");
          // log("refreshToken : $refreshToken");
          log("name: $name");
          log("email: $email");

          // AwesomeDialog(
          //   context: context,
          //   animType: AnimType.scale,
          //   dialogType: DialogType.success,
          //   title: 'LOgin Successfull!',
          //   // desc: 'Do you want to Delete?',
          //   btnOkOnPress: () async {
          //     setState(() {
          //       Navigator.pushNamed(context, RouteName.dashboard);
          //     });
          //   },
          //   // btnCancelOnPress: () {},
          // ).show();

          Navigator.pushNamed(context, RouteName.dashboard);
          AppWidgets()
              .showSuccessSnackbar(context, message: "Login Successful");
          // MotionToast.success(
          //   // title: Text("Login Successful"),
          //   description: const Text("Login Successful"),
          //   position: MotionToastPosition.bottom,
          //   toastDuration: const Duration(seconds: 4),
          // ).show(context);

          // if (responseModel.code == 200) {
          //   // Navigator.pushNamed(context, RouteName.dashboardRoute);
          // }
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "Flutter Block Cubit Skeleton",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    // SignInUserInfoFormWidget(
                    //   formKey: formKey,
                    //   user: user,
                    //   callback: _updateFormState,
                    // ),
                    // SignInUserInfoFormWidget(
                    //   formKey: formKey,
                    //   user: user,
                    // ),
                    Container(
                        alignment: Alignment.center,
                        child: Form(
                            key: _formKey,
                            // autovalidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  _userIdTextField(context),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  _passwordTextField(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ]))),
                    const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 38),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RouteName.sendOtp);
                            },
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("forgot_password"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      // buttonName: AppLocalizations.of(context)
                      //     .translate("common_sign_in"),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("common_sign_in"),
                      ),
                      onPressed: () async {
                        log("pressed");
                        final isValid = _formKey.currentState?.validate();

                        if (isValid != null && isValid) {
                          log("validate");
                          await BlocProvider.of<SignInApiCubit>(context)
                              .signIn(user);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                      indent: 35,
                      endIndent: 35,
                      color: Color(0xff341f97),
                      height: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 38),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("Dont_have_an_account"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 38),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RouteName.signup);
                            },
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("common_sign_up"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _userIdTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      // child: CommonTextField(
      //   textEditingController: mobileController,
      //   hintText: "common_mobile_no",
      //   labelText: "common_mobile_no",
      //   needObscureText: false,
      //   validateMessage:
      //       AppLocalizations.of(context).translate("enter_mobile_number"),
      //   // "Enter Mobile Number",
      //   validatorValue: "mobile",
      //   onChange: (value) {
      //     user.userId = value;
      //   },
      // ),
      child: TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your email';
          }
          // Email regex pattern
          String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return 'Invalid email address';
          }
          return null;
        },
        onChanged: (value) {
          user.email = value;
          //_onChanged();
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   widget.callback(widget.formKey, widget.user);
          // });
        },
      ),
    );
  }

  Widget _passwordTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: CommonTextField(
        textEditingController: pwdController,
        hintText: "common_password",
        labelText: "common_password",
        needObscureText: true,
        obscureText: true,
        validateMessage:
            AppLocalizations.of(context).translate("enter_password"),
        // "Enter Password",
        validatorValue: "password",
        onChange: (value) {
          user.password = value;
          //_onChanged();
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   widget.callback(widget.formKey, widget.user);
          // });
        },
      ),
    );
  }
}
